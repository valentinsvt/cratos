package cratos

class ProcesoController extends cratos.seguridad.Shield {

    def buscadorService
    def kerberosoldService
    def procesoService
    def loginService

    /* todo acabar los dominios */



    def index = { redirect(action: "lsta") }

    def lsta = {
        def campos = ["estado": ["Estado", "string"], "descripcion": ["Descripción", "string"], "fecha": ["Fecha", "date"]]
        [campos: campos]
    }
    def nuevoProceso = {
//        println "nuevo proceso "+params
        if (params.id) {
            def proceso = Proceso.get(params.id)
            def registro = (Comprobante.findAllByProceso(proceso)?.size() == 0) ? false : true
            println "registro "+registro
            render(view: "procesoForm", model: [proceso: proceso, registro: registro])
        }
        else
            render(view: "procesoForm", model: [registro: false])
    }

    def save = {
        if (request.method == 'POST') {

            //println "save proceso "

            params.controllerName = controllerName
            params.actionName = actionName
            if (params.proveedor.id == "null")
                params.proveedor.id = null
            params.estado = "N"
            println "params " + params
            if (!params.fecha){

                println("entro")

                params.fecha = new Date()

            }else {

                println("entro2 "+params.fecha)

                params.fecha = Date.parse("yyyy-MM-dd",params.fecha);

//                p.fecha = params.fecha

            }

            println("fecha:" + params.fecha)

            def p = new Proceso(params)

            p.contabilidad = session.contabilidad


            p.save(flush: true)
            println "errores proceso " + p.errors
            if (p.errors.getErrorCount() == 0)
                redirect(action: 'show', id: p.id)
            else
                render(view: 'procesoForm', model: ['proceso': p], error: true)
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }



    def registrar = {
        if (request.method == 'POST') {
            println "registrar " + params
            def pro = Proceso.get(params.id)
            if (pro.estado == "R") {
                render("El proceso ya ha sido registrado previamente")
            } else {
                def lista = procesoService.registrar(pro, session.perfil, session.usuario)
                if (lista[0] != false) {
                    render(view: "detalleProceso", model: [comprobantes: lista[1], asientos: lista[2]])

                } else {
                    render("Error registrando el proceso")
                }

            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
    def cargaComprobantes = {
//        println "cargar comprobantes " + params
        def proceso = Proceso.get(params.proceso)
        def comprobantes = Comprobante.findByProceso(proceso)
        def asientos = []
        if (comprobantes)
            asientos += Asiento.findAllByComprobante(comprobantes)
        if (asientos.size()>0){
            asientos.sort{it.cuenta.numero}
        }

        //println "comp "+comprobantes+" as "+asientos
        render(view: "detalleProceso", model: [comprobantes: comprobantes, asientos: asientos, proceso: proceso])
    }

    def valorAsiento = {
        if (request.method == 'POST') {
            //println "cambiar Valor Asiento "+params
            def vd = params.vd.toDouble()
            def vh = params.vh.toDouble()
            // println "vd "+vd +" vh  "+vh
            def proceso = Proceso.get(params.proceso)
            def comprobantes = Comprobante.findAllByProceso(proceso)
            def asiento = Asiento.get(params.id)
            def asientos = []
            comprobantes.each {
                asientos += Asiento.findAllByComprobante(it)
            }
            params.controllerName = controllerName
            params.actionName = actionName
            // kerberosService.generarEntradaAuditoria(params,Asiento,"debe",vd,asiento.debe,session.perfil,session.usuario)
            //kerberosService.generarEntradaAuditoria(params,Asiento,"haber",vh,asiento.haber,session.perfil,session.usuario)
            asiento.debe = vd
            asiento.haber = vh
            if (asiento.save(flush: true))
                render "ok"
            else
                render "error"
//            render(view: "detalleProceso", model: [comprobantes: comprobantes, asientos: asientos])
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
    def registrarComprobante = {
        if (request.method == 'POST') {
            println "registrar comprobante " + params
            def comprobante = Comprobante.get(params.id)
            def msn = kerberosoldService.ejecutarProcedure("mayorizar", [comprobante.id, 1])
            println "mayorizando por comprobante " + msn+" "
            if (msn=~ "Error") {
//                def asientos=Asiento.findAllByComprobante(comprobante)
//                println "error al mayorizar "+msn
//                render(view: "detalleProceso", model: [comprobante: comprobante, asientos: asientos, msn: msn])
                render " "+msn
            } else {
                def proceso = comprobante.proceso
                params.controllerName = controllerName
                params.actionName = actionName
//                kerberosService.generarEntradaAuditoria(params,Comprobante,"registrado","R",comprobante.registrado,session.perfil,session.usuario)
                comprobante.registrado = "S"
                comprobante.save(flush: true)
                proceso.estado = "R"
                proceso.save(flush: true)
                render "ok"
            }
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def listar = {
        //println "buscar proceso"
        def closure = {estado ->
            if (estado == "R")
                return "Registrado"
            else
                return "No registrado"
        }
        def listaTitulos = ["Fecha", "Descripcion", "Registrado"]       /*Titulos de la tabla*/
        def listaCampos = ["fecha", "descripcion", "estado"]           /*campos que van a mostrarse en la tabla, en el mismo orden que los titulos*/
        def funciones = [["format": ["dd/MM/yyyy hh:mm"]], null, ["closure": [closure, "?"]]]   /*funciones para cada campo en caso de ser necesari. Cada campo debe tener un mapa (con el nombre de la funcion como key y los parametros como arreglo) o un null si no tiene funciones... si un parametro es ? sera sustituido por el valor del campo, si es & sera sustituido por el objeto */
        def link = "descripcion"                                      /*nombre del campo que va a llevar el link*/
        def url=g.createLink(action: "listar",controller: "proceso")     /*link de esta accion ...  sive para la opcion de reporte*/
//        params.ordenado="fecha"
//        params.orden="desc"
        def lista = buscadorService.buscar(Proceso, "Proceso", "excluyente", params, true) /* Dominio, nombre del dominio , excluyente dejar asi,params tal cual llegan de la interfaz del buscador, ignore case */
        lista.pop()
        if (!params.reporte){
            render(view: '../lstaTbla', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista,  link: link, funciones: funciones,url:url])
        } else{
            /*De esto solo cambiar el dominio, el parametro tabla, el paramtero titulo y el tamaño de las columnas (anchos)*/
            session.dominio=Proceso
            session.funciones=funciones
            def anchos = [16,70,14] /*el ancho de las columnas en porcentajes*/
            redirect(controller: "reportes2",action: "reporteBuscador",params: [listaCampos: listaCampos,listaTitulos: listaTitulos,tabla:"Proceso",orden:params.orden,ordenado:params.ordenado,criterios:params.criterios,operadores:params.operadores,campos: params.campos,titulo:"Transacciones contables",anchos:anchos])
        }

    }

    def show = {
        def proceso = Proceso.get(params.id)
        def registro = (Comprobante.findAllByProceso(proceso)?.size() == 0) ? false : true
        println "registro "+registro
        if (registro)
            [proceso: proceso, registro: registro]
        else
            render(view: "procesoForm", model: [proceso: proceso, registro: registro])
    }

    def comprobarPassword = {
        if (request.method == 'POST') {
            println "comprobar password " + params
            def resp = loginService.autorizaciones(session.usuario, params.atrz)

            render(resp)
        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }

    def cargarAuxiliares = {
        //println "cargar auxiliares "+params
        def msn = null
        def asiento = Asiento.get(params.id);
        def auxiliares = Auxiliar.findAllByAsiento(asiento)
        if (auxiliares.size() == 0) {
            msn = "EL asiento no tiene auxiliares"
        }
        def max = Math.abs(asiento.debe - asiento.haber)
        render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento, msn: msn, max: max])
    }

    def nuevoAuxiliar = {
        if (request.method == 'POST') {
//            println "nuevo aux "+params
            def msn = null
            if (params.razon == "D")
                params["debe"] = params.valor
            else
                params["haber"] = params.valor
            if (params.proveedor.id == "-1") {
                def proceso = Proceso.get(params.proceso)
                println "proveedor " + proceso.proveedor
                if (proceso.proveedor != null)
                    params["proveedor.id"] = proceso.proveedor.id
            }
//            kerberosService.save(params,Auxiliar,session.perfil,session.usuario)
            def fecha = params.remove("fechaPago")
            def p = new Auxiliar(params)
            p.fechaPago = new Date().parse("dd-MM-yyyy", fecha)
            p.save(flush: true)
            println "nuevo auxiliar " + params + "  " + p.errors
            if (p.errors.getErrorCount() != 0)
                msn = "Error al insertar el auxiliar revise los datos ingresados"
            else
                redirect(action: "cargarAuxiliares", params: ["id": params.asiento.id])
//      def asiento=p.asientoContable
//      def auxiliares=Auxiliar.findAllByAsientoContable(asiento)

        } else {
            redirect(controller: "shield", action: "ataques")
        }
    }
    def borrarAuxiliar = {

        if (request.method == 'POST') {
            println " borrar auxiliar " + params
//            kerberosService.delete(params,Auxiliar,session.perfil,session.usuario)
            def aux = Auxiliar.get(params.id)
            aux.delete(flush: true)
            def asiento = Asiento.get(params.idAs)
            def auxiliares = Auxiliar.findAllByAsiento(asiento)
            render(view: "detalleAuxiliares", model: [auxiliares: auxiliares, asiento: asiento])
        } else {
            redirect(controller: "shield", action: "ataques")
        }

    }

    def buscarProveedor = {
        // println "buscar proveedor "+params
        def provs = []
        if (params.par != "" && params.par != " ") {
            if (params.tipo == "1") {
                provs = Proveedor.findAll("from Proveedor where ruc like '%${params.par}%' order by nombre")
            } else {
                provs = Proveedor.findAll("from Proveedor where upper(nombre) like '%${params.par.toUpperCase()}%' order by nombre")
            }
        } else {
            provs = Proveedor.list([sort: "nombre", max: 10])
        }

        [provs: provs]

    }

    def detallePagos = {
        def aux = Auxiliar.get(params.id)
        def pagos = PagoAux.findAllByAuxiliar(aux)
        [pagos: pagos, aux: aux]
    }

    def savePago = {
        println "save pago " + params
        def fecha = params.remove("fecha")
        def pago = new PagoAux(params)
        pago.fecha = new Date().parse("dd-MM-yyyy", fecha)
        if (pago.save(flush: true)) {
            def proceso = new Proceso()
            proceso.gestor = Gestor.get(params.gestor)
            proceso.contabilidad = session.contabilidad
            proceso.descripcion = "Pago de auxiliar " + new Date().format("dd/MM/yyyy hh:mm") + " Monto: " + pago.monto + " Proveedor: " + pago.auxiliar?.asiento?.comprobante?.proceso?.proveedor
            proceso.estado = "R"
            proceso.fecha = new Date()
            proceso.proveedor = pago.auxiliar.asiento.comprobante.proceso.proveedor
            proceso.tipoPago = pago.auxiliar.asiento.comprobante.proceso.tipoPago
            proceso.usuario = session.usuario
            proceso.tipoComprobanteId = TipoComprobanteId.get(3)
            proceso.valor = pago.monto
            proceso.impuesto = 0
            proceso.documento = pago.factura
            proceso.pagoAux = pago
            println "valor " + proceso.valor + " inp " + proceso.impuesto
            if (proceso.save(flush: true)) {
                procesoService.registrar(proceso, session.perfil, session.usuario)
                render "ok"
            } else {
                println "error en el proceso " + proceso.errors
                render "error"
            }

        } else {
            println "error save pago " + pago.errors
        }
    }

    def prueba(){
        render "prueba"
    }

}
