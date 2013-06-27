package cratos

import org.springframework.dao.DataIntegrityViolationException

class FacturaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def procesoService

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = "fecha"
        params.order = "desc"
        [facturaInstanceList: Factura.list(params), facturaInstanceTotal: Factura.count()]
    }

    def create() {
        def iva = ParametrosAuxiliares.get(1).iva
        def bodegas=[]
        Existencias.findAllByEmpresa(session.empresa).each {

            if (!bodegas.contains(it.bodega))
                bodegas.add(it.bodega)

        }
        [facturaInstance: new Factura(params), iva: iva,bodegas:bodegas]
    }


    def buscarItem = {
        def search = params.search
        def iva = ParametrosAuxiliares.get(1).iva
        def results

        results = Item.withCriteria {
            eq("empresa", Empresa.get(session.empresa.id))
            or {
                ilike("nombre", "%" + search + "%")
                ilike("codigo", "%" + search + "%")
//              ilike("marca", "%" + search + "%")

            }

            maxResults(20)
            order("nombre", "asc")
        }




        return [results: results, iva: iva]
    }

    def buscarItemBodega(){
        println "buscar item bodega "+params
        def search = params.search
        def iva = ParametrosAuxiliares.get(1).iva
        def results
        def items = Existencias.findAllByBodegaAndCantidadGreaterThan(Bodega.get(params.bodega),0)
        if (search){
            items.each {
                if(it.item.nombre.toUpperCase()=~search.toUpperCase() || it.item.codigo.toUpperCase()=~search.toUpperCase()){                     
                        results.add(it)
                }
            }
        } else{
            results=items
        }
        return [results: results, iva: iva]
    }


    def buscarCliente ={

        def search = params.search

        def results = Proveedor.withCriteria {

            or{
                ilike("nombre", "%" + search + "%")
                ilike("ruc", "%" + search + "%")
                ilike("nombreContacto", "%" + search + "%")
                ilike("apellidoContacto", "%" + search + "%")

            }

            maxResults(20)
            order("ruc", "asc")

        }

        return [results: results]
    }



    def save() {
        println "save "+params
        def b = true
        def ok = true
        def empresa = Empresa.get(session.empresa.id)

        def total = params.total
        def direccion = params.direccion
        def fecha = new Date()
        if (params.fecha) {
            fecha = new Date().parse("yyyy-MM-dd", params.fecha)
        }
        def tipoTarjeta = params.tipoTarjeta.id
        def tipoPago = params.tipoPago.id
        def telefono = params.telefono
        def descuentos = params.descuentos
        def subtotal = params.subtotal
        def iva0 = params.iva0
        def iva1 = params.iva1
        def iva = params.iva
        def items = params.item
        if (items.class == java.lang.String) {
            items = [items]
        }
        def ci = params.ci
        def tipoFactura = params.tipoFactura.id
        def persona = params.persona

        def gestor = params.gestor

        def facturaSerie01 = params.facturaSerie01
        def facturaSerie02 = params.facturaSerie02
        def secuencial = params.secuencial

//        def numero = params.numero

        def proveedor = Proveedor.findByRuc(ci)

        if (!proveedor) {
            proveedor = new Proveedor()

            proveedor.tipoProveedor = TipoProveedor.get(1)
            proveedor.tipoPersona = TipoPersona.get(1)
            proveedor.tipoIdentificacion = TipoIdentificacion.get(2)

            proveedor.empresa = empresa

            proveedor.ruc = ci
            proveedor.direccion = direccion
            proveedor.fecha = new Date()
            proveedor.nombreContacto = params.nombre
            proveedor.apellidoContacto = params.apellido

            proveedor.descuento = 0
            proveedor.telefono = telefono
            if (!proveedor.save(flush: true)) {
                println "ERROR SAVE proveedor l.100 " + proveedor.errors
                ok = false
            }
        }

        def facturaInstance = new Factura()
        if (params.id) {
            facturaInstance = Factura.get(params.id)
        }

//        facturaInstance.registro
        facturaInstance.pagado = total.toDouble()
        facturaInstance.iva1 = iva1.toDouble()
        facturaInstance.iva0 = iva0.toDouble()
        facturaInstance.iva = iva.toDouble()
        facturaInstance.subtotal = subtotal.toDouble()
        facturaInstance.descuentos = descuentos.toDouble()
        facturaInstance.direccion = direccion
        facturaInstance.telefono = telefono
        facturaInstance.persona = persona
        facturaInstance.facturaSerie01=facturaSerie01
        facturaInstance.facturaSerie02=facturaSerie02
        facturaInstance.secuencial=secuencial

//        facturaInstance.numero = numero
        facturaInstance.empresa = empresa
        if (tipoPago && tipoPago != "null" && TipoPago.get(tipoPago.toLong()))
            facturaInstance.tipoPago = TipoPago.get(tipoPago.toLong())
        facturaInstance.proveedor = proveedor
//        facturaInstance.estado
        if (tipoFactura && tipoFactura != "null" && TipoFactura.get(tipoFactura.toLong()))
            facturaInstance.tipoFactura = TipoFactura.get(tipoFactura.toLong())
        if (tipoTarjeta && tipoTarjeta != "null" && TipoTarjeta.get(tipoTarjeta.toLong()))
            facturaInstance.tipoTarjeta = TipoTarjeta.get(tipoTarjeta.toLong())
//        facturaInstance.observaciones

        facturaInstance.gestor = Gestor.get(Parametros.findByDescripcion("GESTOR CONTABLE VENTAS").valor)

//        println("tarjeta 2" + facturaInstance.tipoTarjeta)

        if (!facturaInstance.save(flush: true)) {
            ok = false
            println "ERROR factura: " + facturaInstance.errors
            return
        } else {
            //println "ITEMS --- >"
            items.each { item ->
                //items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.observaciones
                def parts = item.split("\\^")
                //println "PARTS: " + parts
                def id = parts[0]
                def cantidad = parts[1]
                def precio = parts[2]
                def descuento = parts[3]
                def conIva = parts[4]
                def observaciones = ""
                def bodega = Bodega.get(parts[6])
                if (parts.size() == 6) {
                    observaciones = parts[5]
                }

                def detalleFactura = new DetalleFactura()

                detalleFactura.descuento = descuento.toDouble()
                detalleFactura.precioUnitario = precio.toDouble()
                detalleFactura.cantidad = cantidad.toDouble()
                detalleFactura.item = Item.get(id.toLong())
                detalleFactura.factura = facturaInstance
                detalleFactura.observaciones = observaciones
                detalleFactura.bodega=bodega
                if (!detalleFactura.save(flush: true)) {
                    ok = false
                    b = false
                }else{

                        def ext = new Existencias()
                        ext.cantidad = 0
                        ext.item = detalleFactura.item
                        ext.bodega = detalleFactura.bodega
                        ext.empresa = Empresa.get(session.empresa.id)
                        ext.existenciaInicial = 0
                        def oke = true

                        def existencias = Existencias.findAllByItemAndBodega(detalleFactura.item, detalleFactura.bodega)
                        if (existencias.size() == 1) {
                            println "\t\tHay un registro de existencias para " + detalleFactura.item.nombre + " en la dtaq.bodega " + detalleFactura.bodega.descripcion
                            ext = existencias[0]
                        } else if (existencias.size() == 0) {
                            println "\t\tNo hay registros de existencias para " + detalleFactura.item.nombre + " en la dtaq.bodega " + detalleFactura.bodega.descripcion
                        } else {
                            println "\t\tWTF hay mas de un registro de existencias para " + detalleFactura.item.nombre + " en la dtaq.bodega " + detalleFactura.bodega.descripcion
                            oke = false
                        }

                        if (oke) {
                            println "\t\tmodificando/creando la existencia"
                            ext.cantidad = ext.cantidad - detalleFactura.cantidad
                            ext.fecha = new Date()
//                        ext.precio = precio
                            if (!ext.save(flush: true)) {
                                println "\t\t\tNO se guardo la existencia!!"
                            } else {
                                println "\t\t\tSI se guardo la existencia!!"
                            }
                        }

                }


            }
            def proceso = new Proceso()
            proceso.gestor = facturaInstance.gestor
            proceso.contabilidad = session.contabilidad
            //proceso.factura = facturaInstance.numero
            proceso.procesoSerie01 = facturaInstance.facturaSerie01
            proceso.procesoSerie02 = facturaInstance.facturaSerie02
            proceso.secuencial = facturaInstance.secuencial
            proceso.descripcion = "Facturación - Cliente - "+facturaInstance?.proveedor?.ruc+" - fecha:  "+new Date().format("dd/MM/yyyy hh:mm")
            proceso.estado = "N"
            proceso.fecha = new Date()
            proceso.proveedor = facturaInstance.proveedor
            proceso.tipoPago = facturaInstance.tipoPago
            proceso.usuario = session.usuario
            proceso.documento=facturaInstance.facturaSerie01+""+facturaInstance.facturaSerie02+""+facturaInstance.secuencial
            proceso.valor = facturaInstance.subtotal
            proceso.impuesto = facturaInstance.iva
            proceso.fact=facturaInstance


            if (proceso.save(flush: true)) {
                procesoService.registrar(proceso, session.perfil, session.usuario)

                /*todo cambiar la pantalla del show adquisicion*/
            } else {
                println "error en el proceso " + proceso.errors
//                    render "error"
                ok = false
            }
        }
        if (ok) {
            if (params.id) {
                flash.message = "Factura actualizada"
                flash.clase = "success"
                flash.ico = "ss_accept"
            } else {
                flash.message = "Factura creada"
                flash.clase = "success"
                flash.ico = "ss_accept"
            }
            render(facturaInstance.id)

        } else {
            flash.message = "Ha ocurrido un error"
            flash.clase = "error"
            flash.ico = "ss_delete"
            render("error")

        }

    }

    def show() {
        def iva = ParametrosAuxiliares.get(1).iva
        def facturaInstance = Factura.get(params.id)
        if (!facturaInstance) {
            flash.message = "No se encontró Factura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [facturaInstance: facturaInstance, iva: iva]
    }

    def edit() {
        def facturaInstance = Factura.get(params.id)
        if (!facturaInstance) {
            flash.message = "No se encontró Factura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [facturaInstance: facturaInstance]
    }

    def delete() {
        def facturaInstance = Factura.get(params.id)
        if (!facturaInstance) {
            flash.message = "No se encontró Factura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            facturaInstance.delete(flush: true)
            flash.message = "Factura  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Factura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }

    def generar() {
        println params

        def factura = Factura.get(params.id)
        def ok = true

        def consumos = Consumo.findAllByFactura(factura)

        def items = [:]

        /*
        Consumo:
            String estado
            double precioUnitario
            double descuento
            double cantidad
            Item item
            Factura factura
            String observaciones

        Detalle Factura
            double descuento
            double precioUnitario
            double cantidad
            Item item
            Factura factura
            String observaciones
         */

        consumos.each { consumo ->
            def id = consumo.item.id
//            println "id:" + consumo.item.id + " pu:" + consumo.precioUnitario + " ds:" + consumo.descuento + " ca:" + consumo.cantidad + " obs:" + consumo.observaciones

            if (!items[id]) {
                def detalleFactura = new DetalleFactura()
                detalleFactura.descuento = consumo.descuento
                detalleFactura.precioUnitario = consumo.precioUnitario
                detalleFactura.cantidad = consumo.cantidad
                detalleFactura.item = consumo.item
                detalleFactura.observaciones = consumo.observaciones
                detalleFactura.factura = consumo.factura
                items[id] = detalleFactura
            } else {
                items[id].descuento = consumo.descuento
                items[id].precioUnitario = consumo.precioUnitario
                items[id].cantidad = items[id].cantidad + consumo.cantidad
                items[id].observaciones += " " + consumo.observaciones
            }

        }

        def pagado = 0, iva1 = 0, iva0 = 0, iva = 0, descuentos = 0, subtotal = 0
        def pctIva = (ParametrosAuxiliares.get(1).iva / 100)

//        println "++++++++++++++++++++++++++++++++++++++++"
        items.each {
            def v = it.value
//            println "id:" + v.item.id + " pu:" + v.precioUnitario + " ds:" + v.descuento + " ca:" + v.cantidad + " obs:" + v.observaciones
            if (!v.save(flush: true)) {
                ok = false
                println "error save item crear factura de consumo l. 324"
                println v.errors
            } else {
                def precio = v.precioUnitario
                def conIva = v.item.iva
                def cantidad = v.cantidad
                def descuento = v.descuento / 100

                def st = precio * cantidad
                def ds = st * descuento

                def t = st - ds
                def iv = 0
                if (conIva == 1) {
                    iva1 += t
                    iv = t * pctIva
                    iva += iv
                } else {
                    iva0 += t
                }

                def tt = t + iv

                descuentos += ds
                subtotal += st
                pagado += tt
            }
        }
        //pagado = 0, iva1 = 0, iva0 = 0, iva = 0, descuentos = 0, subtotal = 0
        factura.pagado = pagado
        factura.iva1 = iva1
        factura.iva0 = iva0
        factura.iva = iva
        factura.descuentos = descuentos
        factura.subtotal = subtotal
        factura.gestor=Gestor.get(Parametros.findByDescripcion("GESTOR CONTABLE CONSUMOS").valor)
        factura.empresa=Empresa.get(session.empresa.id)
        println "factura gestor "+factura.gestor

        if (!factura.save(flush: true)) {
            ok = false
            println "error save factura l. 366"
            println factura.errors
        }else{
            def proceso = new Proceso()
            proceso.gestor = factura.gestor
            proceso.contabilidad = session.contabilidad
            proceso.procesoSerie01 = factura.facturaSerie01
            proceso.procesoSerie02 = factura.facturaSerie02
            proceso.secuencial = factura.secuencial
//            proceso.factura = factura.numero
            proceso.descripcion = "Facturación - Cliente - "+factura?.proveedor?.ruc+" - fecha:  "+new Date().format("dd/MM/yyyy hh:mm")
            proceso.estado = "R"
            proceso.fecha = new Date()
            proceso.proveedor = factura.proveedor
            proceso.tipoPago = factura.tipoPago
            proceso.usuario = session.usuario
//                def iva = ParametrosAuxiliares.get(1).iva
            proceso.valor = factura.subtotal
            proceso.impuesto = factura.iva


            if (proceso.save(flush: true)) {
                procesoService.registrar(proceso, session.perfil, session.usuario)
                //render factura.id
                /*todo cambiar la pantalla del show adquisicion*/
            } else {
                println "error en el proceso " + proceso.errors
//                    render "error"
                ok = false
            }
        }

        if (ok) {
            flash.message = "Factura generada exitosamente"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Ha ocurrido un error en la generación de la factura"
            flash.clase = "error"
            flash.ico = "ss_delete"
        }
        redirect(action: "show", id: factura.id)
    }

}
