package cratos

class ReportesController {

    def cuentasService
    def buscadorService
    def kerberosoldService

    def index() {
        def camposCliente = ["nombre": ["Nombre", "string"], "ruc": ["Ruc", "string"]]
        if (params.msn)
            [camposCliente: camposCliente, msn: params.msn]
        else
            [camposCliente: camposCliente]
    }


    def listarClientes = {
        def closure = { proveedor ->
            if (proveedor.nombre) {
                return proveedor.nombre
            } else {
                return proveedor.nombreContacto + " " + proveedor?.apellidoContacto
            }

        }
        def listaTitulos = ["Ruc", "Nombre", "Actividad"]       /*Titulos de la tabla*/
        def listaCampos = ["ruc", "nombre", "actividad"]           /*campos que van a mostrarse en la tabla, en el mismo orden que los titulos*/
        def funciones = [null, ["closure": [closure, "&"]], null]   /*funciones para cada campo en caso de ser necesario. Cada campo debe tener un mapa (con el nombre de la funcion como key y los parametros como arreglo) o un null si no tiene funciones... si un parametro es ? sera sustituido por el valor del campo*/
        def url = g.createLink(action: "listarClientes", controller: "reportes")     /*link de esta accion ...  sive para la opcion de reporte*/
        if (params.campos instanceof java.lang.String) {
            params.campos = [params.campos, "empresa"]
            params.criterios = [params.criterios, session.empresa.id]
            params.operadores = [params.operadores, "="]
        } else {
            def t = ["empresa"]
            params.campos.each {
                t.add(it.trim())
            }
            params.campos = t
            t = ["1"]
            params.criterios.each {
                t.add(it.trim())
            }
            params.criterios = t
            t = ["="]
            params.operadores.each {
                t.add(it.trim())
            }
            params.operadores = t
        }
        def lista = buscadorService.buscar(Proveedor, "Proveedor", "excluyente", params, true) /* Dominio, nombre del dominio , excluyente o incluyente ,params tal cual llegan de la interfaz del buscador, ignore case */
        lista.pop()
        render(view: '../tablaBuscador', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista, funciones: funciones, url: url])

    }

    def retencion() {

//        println "retencion " + params
        def proceso = Proceso.findAllByAdquisicion(Adquisiciones.get(params.id))
        def p
        def empresa = Empresa.get(params.empr)
        // println "procesos " + proceso + " empresa " + empresa
        proceso.each {
            //println "proceso " + it.gestor.empresa
            if (it.gestor.empresa == empresa) {
                p = it
                println "si empresa "
            }
        }
        if (p) {
            def ret = Retencion.findByProceso(p)
            def det
            if (ret) {
                det = DetalleRetencion.findAllByRetencion(ret)
                [ret: ret, empresa: empresa, det: det, p: p]
            } else {
                render "Esta transacción no tiene comprobantes de retención"
            }

        } else {
            render "Transacción no encontrada"
        }
    }

    def updatePeriodo() {

        def cont = Contabilidad.get(params.cont)
        def periodos = Periodo.findAllByContabilidad(cont, [sort: 'fechaInicio'])

        // <g:select name="contP" from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}" optionKey="id" optionValue="descripcion"
        // class="ui-widget-content ui-corner-all"/>

        def sel = g.select(name: "periodo" + params.cual, from: periodos, optionKey: "id", "class": "ui-widget-content ui-corner-all")

        def html = "Periodo: " + sel

        def js = ""
        if (params.cual == "2") {
            js += "<script>"
            js += "updateCuenta();"
            js += '$("#periodo2").change(function() {'
            js += "updateCuenta();"
            js += '});'
            js += "</script>"

            html += js
        }
        render html
    }

    def planDeCuentas() {
        [cuentas: cuentasService.getCuentas(params.cont, params.emp)]
    }

    def balanceComprobacion() {
        def sp = kerberosoldService.ejecutarProcedure("saldos", params.cont)

        def contabilidad = Contabilidad.get(params.cont)
        def periodo = Periodo.get(params.per)


        def saldos = SaldoMensual.findAllByPeriodo(periodo)
//        println "saldos "+saldos+" periodo "+periodo.id
//        saldos.each {
//            println "saldo "+it.cuenta.numero+" "+it.saldoInicial+" d "+it.debe+" h "+it.haber
//        }

        saldos.sort {
            it.refresh()
            it.cuenta.numero
        }

//        println cuentas
//        println res
        return [res: saldos, contabilidad: contabilidad, periodo: periodo]
    }

    def presupuesto() {
        [asignaciones: cuentasService.getAsignacion(2), presupuestos: cuentasService.getPresupuesto(params.cont, params.emp)]
    }

    def gestorContable() {
        def gestor = cuentasService.getGestor(params.cont, params.emp)
        def cuentas = cuentasService.getCuentas(params.cont, params.emp)
//        def genera = cuentasService.getGenera(7)

        def genera = []
        gestor.each { g ->
            genera += cuentasService.getGenera(g.id)
        }

        def res = [:]

        genera.each { generas ->
            def nombre = generas.gestor.nombre
            def fecha = generas.gestor.fecha

            def descripcion = generas.gestor.descripcion

            if (!res.containsKey(nombre)) {
                res[nombre] = [:]
                res[nombre].descripcion = descripcion
                res[nombre].fecha = fecha
                res[nombre].items = []
            }
            def m = [:]

            m.numero = generas.cuenta.numero
            m.descripcion = generas.cuenta.descripcion
            m.porcentaje = generas.porcentaje
            m.porcentajeImpuestos = generas.porcentajeImpuestos
            m.valor = generas.valor
            m.debeHaber = generas.debeHaber

            res[nombre].items.add(m)
        }

        [gestor: gestor, genera: genera, cuentas: cuentas, res: res]

    }

    def reporteOrdenCompra() {
        def ordenCompraInstance = OrdenCompra.get(params.id);
        [ordenCompraInstance: ordenCompraInstance]
    }



    def comprobante() {
        println "imprimir comprobante " + params
        def comprobantes = cuentasService.getComprobante(params.id)

        def tipoComprobante = []

//        println("CMPR:" + comprobantes.tipo)

        comprobantes.each { i ->
            tipoComprobante += i.tipo.codigo
        }

        def asiento
        if (comprobantes)
            asiento = cuentasService.getAsiento(comprobantes?.pop()?.id)

        //def cuentas = cuentasService.getCuentas(params.cont, params.emp)

        def comp = [:]

        asiento.each { asientos ->

            def fecha = asientos.comprobante.fecha
            def numero = "" + asientos.comprobante.prefijo + "" + asientos.comprobante.numero
            def descripcion = asientos.comprobante.descripcion

            if (!comp.containsKey(numero)) {

                comp[numero] = [:]
                comp[numero].fecha = fecha
                comp[numero].descripcion = descripcion
                comp[numero].tipo = asientos.comprobante.tipo.descripcion
                comp[numero].items = []
            }

            def c = [:]
            c.debe = asientos.debe
            c.haber = asientos.haber
            c.cuenta = asientos.cuenta.numero
            c.descripcion = asientos.cuenta.descripcion


            def cont =

                comp[numero].items.add(c)

        }

        [asiento: asiento, comprobantes: comprobantes, comp: comp, tipoComprobante: tipoComprobante]

    }

    def cargaDatosItem() {
        def file = new File("/home/svt/Downloads/items.csv")
        def cont = 1
        file.eachLine {
            def parts = it.split("&")

            def item = Item.findByNombre(parts[0])
            if (!item) {
                println "no item " + parts[0]
                println "parts " + parts
                def i = new Item()
                i.nombre = parts[0]
                i.precioUnitario = parts[1].toDouble() * 1.11
                i.codigo = "md-$cont"
                i.fecha = new Date()
                i.iva = 1
                i.estado = "1"
                i.precioCosto = parts[1].toDouble()
                i.stock = 100
                i.stockMaximo = 10
                if (!i.save(flush: true))
                    println "errores  " + i.errors
            }

            cont++
        }

    }

    def situacionFinanciera() {

//        println "++++++++++++++++++++++++++++++++++" + params

        def periodo = Periodo.get(params.per)

        def sp = kerberosoldService.ejecutarProcedure("saldos", periodo.contabilidadId)

        def cuenta2 = Cuenta.findByNumero("2")
        def cuenta3 = Cuenta.findByNumero("3")
        def cuenta4 = Cuenta.findByNumero("4")
        def cuenta5 = Cuenta.findByNumero("5")
//        println "periodo " + periodo + " cuenta2 " + cuenta3.id
        def saldo2 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta2)
        def saldo3 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta3)
        def saldo4 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta4)
        def saldo5 = SaldoMensual.findByPeriodoAndCuenta(periodo, cuenta5)
        def tot2
        def tot3
        def tot4
        def tot5
        if (saldo2) {
            saldo2.refresh()
            tot2 = saldo2.saldoInicial + (saldo2.debe - saldo2.haber)
        } else
            tot2 = 0
        if (saldo3) {
            saldo3.refresh()
            tot3 = saldo3.saldoInicial + (saldo3.debe - saldo3.haber)
        } else
            tot3 = 0
        if (saldo4) {
            saldo4.refresh()
            tot4 = saldo4.saldoInicial + (saldo4.debe - saldo4.haber)
        } else
            tot4 = 0
        if (saldo5) {
            saldo5.refresh()
            tot5 = saldo5.saldoInicial + (saldo5.debe - saldo5.haber)
        } else
            tot5 = 0
//        println "saldo2:" + tot2 + "  3:" + tot3 + "  4:" + tot4 + "  5:" + tot5

        /*
        SELECT c.cntanmro as numero, c.cntadscr as nombre,
  (s.slmsdebe-s.slmshber) as total, nvel__id as nivel
from cnta c, slms s, prdo p
where s.cnta__id = c.cnta__id and p.prdo__id = s.prdo__id and
      p.prdo__id = $P!{fecha} and c.cntanmro not like '4.%' and
      c.cntanmro not like '5.%' and
     (s.slmsdebe - s.slmshber) <> 0
order by 1
         */

        def datos = SaldoMensual.withCriteria {
            eq("periodo", periodo)
            cuenta {
                and {
                    not {
                        like("numero", "4%")
                    }
                    not {
                        like("numero", "5%")
                    }
                }
                order("numero", "asc")
            }
            neProperty("debe", "haber")
        }

//        println datos

        return [periodo: periodo, contabilidad: session.contabilidad, tot2: tot2, tot3: tot3, tot4: tot4, tot5: tot5, datos: datos]

    }

    def flujoEfectivo() {
        def periodo = Periodo.get(params.per)
        def cuenta = Cuenta.findByNumero("10102")  //cuenta de activo disponible
        def prdo = Periodo.findByNumeroAndContabilidad(1, session.contabilidad)
        def saldo = SaldoMensual.findByPeriodoAndCuenta(prdo, cuenta)
        def disponible
        if (saldo)
            disponible = saldo.saldoInicial
        else
            disponible = 0

        println "saldo: " + disponible

        /*
        select rpcndscr, rplndscr, (slmsslin+slmsdebe-slmshber)*cnlndbhb saldo,
rpgrdscr, cntanmro, cntadscr
from rpcn, rpgr, rpln, cnln, slms, cnta
where rpcn.rpcn__id = 1 and
      rpgr.rpcn__id = rpcn.rpcn__id and
      rpln.rpgr__id = rpgr.rpgr__id and
      cnln.rpln__id = rpln.rpln__id and
      slms.cnta__id = cnln.cnta__id and
      prdo__id = $P{periodo} and
      cnta.cnta__id = cnln.cnta__id
order by rplnnmro
        */
//        reportesService.mostrarPdf([contabilidad: session.contabilidad.toString(), periodo: periodo.id.toInteger(),
//                inicial: disponible.toDouble()], "flujoDeEfectivo", "flujoDeEfectivo-" + periodo, "pdf", "", response)
    }

    def cambiosPatrimonio() {

    }


    def ventas() {
        println "ventas " + params
        def desde = new Date().parse("yyyy-MM-dd", params.desde)
        def hasta = new Date().parse("yyyy-MM-dd", params.hasta)

        def ventas = Factura.findAllByFechaBetween(desde, hasta)


        [desde: desde, hasta: hasta, ventas: ventas]
    }

    def auxiliaresContables() {

//        params.cont = 1
//        params.per = 10
//        params.cnta = 1108

        println("paramsCont:" + params)
        println("periodoCont:" + params.per)
        println("cuenta-->>" + params.cnta)


        def contabilidad = Contabilidad.get(params.cont);


        def periodo = Periodo.get(params.per);

        def fini = periodo.fechaInicio

        def fin = periodo.fechaFin


        println(fini);

        println(fin);


        def proceso = Proceso.findAllByContabilidadAndFechaBetween(contabilidad, fini, fin)

//        println(proceso.descripcion);
//
//        println("contabilidadCont:" + contabilidad.descripcion)
//
//        println("procesos:" + proceso)

        def cuenta


        if (params.cnta == '-1') {

            println("entro!! cuenta ID")

            cuenta = Cuenta.all

//            println("cuenta" + cuenta.id)

            cuenta.each { g ->

                println(g.id)

                def cuentaP

                cuentaP = Cuenta.get(g.id)

//                println("cuentaP: " + cuentaP)

                def saldoMensual = SaldoMensual.findByCuentaAndPeriodo(cuentaP, periodo)

                println("SM:" + saldoMensual)


                def comprobante = Comprobante.findAllByProcesoInList(proceso)

//                println("comprobante" + comprobante)

//                def asiento = Asiento.findAllByCuentatAndComprobanteInList(cuenta, comprobante)

//                println("asiento" + asiento)

            }


            return [contabilidad: contabilidad, periodo: periodo, proceso: proceso, cuenta: cuenta, asiento:
                    asiento, saldo: saldo, saldoMensual: saldoMensual, saldoInicial: saldoInicial]

        } else {

            cuenta = Cuenta.get(params.cnta);

//            println("cuentaC: " + cuenta.id)



            def saldoMensual = SaldoMensual.findByCuentaAndPeriodo(cuenta, periodo)

//        println("saldoMensual:" + saldoMensual.saldoInicial)

            def comprobante = Comprobante.findAllByProcesoInListAndRegistrado(proceso,"S")

//            println("comprobante" + comprobante)

            def asiento = Asiento.findAllByCuentaAndComprobanteInList(cuenta, comprobante)

//            println("asiento" + asiento)


            def saldo = []

            def saldoInicial


            if (saldoMensual != null) {


                saldoInicial = saldoMensual.saldoInicial;
            } else {

                saldoInicial = 0;
//            println("ENTRO:" + saldoInicial)
            }



            asiento.each { v ->

                def m = v
                def saldos = [:]

                saldos.debe = m.debe
                saldos.haber = m.haber

                if (saldoInicial == 0) {

                    saldoInicial = saldos.debe - saldos.haber


                } else {

                    if (saldos.debe != 0) {


                        saldoInicial = saldoInicial + saldos.debe

                    } else {

                        saldoInicial = saldoInicial - saldos.haber
                    }


                }
                println(saldoInicial)

                saldo.add(saldoInicial)

            }

            return [contabilidad: contabilidad, periodo: periodo, proceso: proceso, cuenta: cuenta, asiento:
                    asiento, saldo: saldo, saldoMensual: saldoMensual, saldoInicial: saldoInicial]
        }


    }


    def reporteFacturacion() {


        def cuenta
        def asientos
        def periodo = Periodo.get(params.per);
//
//        println("periodo: " + periodo)
//
//        println("inicio" + periodo.fechaInicio)
//        println("fin" + periodo.fechaFin)


        def hijos
        def asientos2 = []

        def comprobante

        cuenta = Cuenta.get(params.cnta);

        hijos = Cuenta.findAllByPadre(cuenta)

        comprobante = Comprobante.findAllByFechaBetween(periodo.fechaInicio, periodo.fechaFin)
//
//        println(comprobante)
//
//
//        println(hijos)

        if (hijos == []) {

//            asientos = Asiento.findAllByCuenta(cuenta)
//            asientos2+=asientos

            asientos = Asiento.findAllByCuentaAndComprobanteInList(cuenta, comprobante)
            asientos2 += asientos

        } else {


            hijos.each { i ->

                def cuentas = Cuenta.get(i.id)

//               asientos = Asiento.findAllByCuenta(cuentas)

                asientos = Asiento.findAllByCuentaAndComprobanteInList(cuentas, comprobante)

                asientos2 += asientos

            }


        }

//        println(asientos2)

        return [asientos: asientos2, cuenta: cuenta, periodo: periodo]


    }


}
