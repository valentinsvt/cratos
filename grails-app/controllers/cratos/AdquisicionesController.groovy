package cratos

import org.springframework.dao.DataIntegrityViolationException

class AdquisicionesController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]
    def procesoService

    def index() {
        redirect(action: "create", params: params)
//
    }

    def list() {


        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "fecha"
            params.order = "desc"
        }


        [adquisicionesInstanceList: Adquisiciones.list(params), adquisicionesInstanceTotal: Adquisiciones.count()]
    }

    def datosSri() {
        def orden = OrdenCompra.get(params.ordenCompra)
        def proveedor = Proveedor.get(params.proveedor)

        def tipoId = proveedor.tipoIdentificacion
        def tiposComprobante = []
        if (tipoId) {
            TipoComprobanteId.findAllByTipoIdentificacion(tipoId).each {tp ->
                tiposComprobante.add(tp.tipoComprobanteSri)
            }
        }

        println proveedor
        println tipoId
        println tiposComprobante


        return [tiposComprobante: tiposComprobante]
    }

    def create() {

        println "create " + params
        def adq
        def emp = Empresa.get(session.empresa.id)
        def ordenesCompra = emp.ordenCompra == '1'

        if (params.id) {
            adq = Adquisiciones.get(params.id)
        } else {
            adq = new Adquisiciones(params)
        }
        def ordenCompra = null

        if (ordenesCompra) {
            if (params.ordenCompra) {
                ordenCompra = OrdenCompra.get(params.ordenCompra)
                adq.descripcion = ordenCompra.descripcion
            }
        } else {
            if (!params.id) {
//                ordenCompra = new OrdenCompra()
//                def centroCostos = CentroCosto.findByEmpresa(emp)
//                if (!centroCostos) {
//                    centroCostos = new CentroCosto()
//                    centroCostos.empresa = emp
//                    centroCostos.nombre = "Centro costos por defecto"
//                    if (!centroCostos.save(flush: true)) {
//                        println centroCostos.errors
//                        println "error al crear centro de costos por default de empresa " + emp.id
//                    }
//                }
//                ordenCompra.centroCosto = centroCostos
//                ordenCompra.estado = 'R'
//                ordenCompra.descripcion = "Orden compra por defecto "
//                ordenCompra.observaciones = "Orden compra por defecto "
//                ordenCompra.fecha = new Date()
//                if (!ordenCompra.save(flush: true)) {
//                    println ordenCompra.errors
//                    println "error al crear orden de compra por default de empresa " + emp.id
//                }
//                ordenCompra.descripcion = ordenCompra.descripcion + ordenCompra.id
//                ordenCompra.observaciones = ordenCompra.observaciones + ordenCompra.id
//                if (!ordenCompra.save(flush: true)) {
//                    println ordenCompra.errors
//                    println "error 2 al crear orden de compra por default de empresa " + emp.id
//                }
            }
        }

        if (params.id) {
            ordenCompra = adq.orden
        }

        def ordenes = []

        def centros = CentroCosto.findAllByEmpresa(session.empresa)

//        println "empresa " + session.empresa + "   " + centros
        if (centros) {
            centros.each {
                def tmp = OrdenCompra.findAllByCentroCosto(it)
                if (tmp)
                    ordenes += tmp
            }
        }
        println "ordenes " + ordenes

        def iva = ParametrosAuxiliares.get(1).iva

        def cantidades = [:]

        if (params.id) {
            def ord = adq.orden

            Adquisiciones.findAllByOrden(ord).each {a ->
                DetalleAdquisicion.findAllByAdquisiciones(a).each { d ->
                    if (!cantidades[d.item]) {
                        cantidades[d.item] = 0
                    }
                    cantidades[d.item] += d.cantidad
                }
            }
        }

        return [iva: iva, adquisicionesInstance: adq, ordenes: ordenes, ordenCompra: ordenCompra, cantidades: cantidades, ordenesCompra: ordenesCompra]
    }


    def buscarItem = {
        println "buscar item"
        println params

        def emp = Empresa.get(session.empresa.id)
        def ordenesCompra = emp.ordenCompra == '1'

        def orden
        def items = []
        def cants = [:]
        if (params.orden != "-1")
            orden = OrdenCompra.get(params.orden)
        if (orden) {
            DetalleOrdenCompra.findAllByOrdenCompra(orden).each {
                if (params.search) {
                    def band = false
                    //println "si search"
                    if (it.item.nombre.toLowerCase() =~ params.search.toLowerCase()) {
                        band = true
                    }
                    if (it.item.codigo.toLowerCase() =~ params.search.toLowerCase()) {
                        band = true
                    }
                    if (band) {
                        items.add(it.item)
                        def c = it.cantidad
                        Adquisiciones.findAllByOrden(orden).each { a ->
                            def cantidades = DetalleAdquisicion.findAllByAdquisicionesAndItem(a, it.item)?.cantidad
                            cantidades.each { cc ->
                                c -= cc
                            }
                        }
                        cants.put(it.item.id.toString(), c)
                    }
                } else {
                    //println "no search "
                    items.add(it.item)
                    def c = it.cantidad
                    Adquisiciones.findAllByOrden(orden).each { a ->
                        def detalles = DetalleAdquisicion.findAllByAdquisicionesAndItem(a, it.item)
                        detalles.each { detalleAdq ->
                            c -= detalleAdq.cantidad
                        }
                    }
                    cants.put(it.item.id.toString(), c)
                }
            }
        } else {
            if (params.search)
                items = Item.findAll("from Item where nombre like '%${params.search}%' or codigo like '%${params.serach}%' and empresa = ${session.empresa.id}")
            else
                items = Item.findAllByEmpresa(session.empresa, [sort: "nombre", max: 20])

            items.each() { item ->
                cants.put(item.id.toString(), 999999999999)
            }
        }

        def iva = ParametrosAuxiliares.get(1).iva
        return [items: items, iva: iva, cants: cants, ordenesCompra: ordenesCompra]
    }


    def buscarProveedor = {

        def search = params.search
        def emp = Empresa.get(session.empresa.id)
        def results = Proveedor.withCriteria {
            and {
                eq("empresa", emp)
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("nombreContacto", "%" + search + "%")
                    ilike("apellidoContacto", "%" + search + "%")
                    ilike("ruc", "%" + search + "%")
                }
                maxResults(20)
                order("nombre", "asc")
            }
        }

        return [results: results]
    }


    def buscarOC = {
        def search = params.search.toString()
        def results = OrdenCompra.withCriteria {
            and {
                or {
                    ilike("descripcion", "%" + search + "%")
                    ilike("observaciones", "%" + search + "%")
                }
                eq("estado", "R")
            }
            maxResults(20)
            order("fecha", "asc")
        }
        def ordenes = []

        results.each { ordenCompra ->
            def m = [:]
            DetalleOrdenCompra.findAllByOrdenCompra(ordenCompra).each { detalleOC ->
                m[detalleOC.itemId] = detalleOC.cantidad
            }

            Adquisiciones.findAllByOrden(ordenCompra).each { adq ->
                println adq
                DetalleAdquisicion.findAllByAdquisiciones(adq).each { detalleAdq ->
                    println "\t" + detalleAdq
                    m[detalleAdq.itemId] -= detalleAdq.cantidad
                }
            }
            if (m.findAll {it.value > 0}.size() != 0) {
                ordenes.add(ordenCompra)
            } else {
                ordenCompra.estado = 'C'
                if (!ordenCompra.save(flush: true)) {
                    println "error actualizando estado de orden de compra " + ordenCompra.errors
                }
            }
        }

        return [results: ordenes]
    }


    def estadoDetalles() {
//        println("entro")
//       println params
        def adquisicionesInstance = Adquisiciones.get(params.id)
        if (params.id) {
            DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance).each { item ->
                if (params.revisar?.contains(item.id.toString())) {
                    item.estado = '1'
                }
                else {
                    item.estado = '0'
                }
                println item.id + ' ' + item.estado
                if (!item.save(flush: true)) {
                    println("error :" + item.errors)
//                    redirect(action: "list");
                } else {
                    println("OK")
                }
            }
            redirect(action: "list");
        }
    }


    def save() {
        println "Adquisiciones" + params
        println "id " + params.id

        def emp = Empresa.get(session.empresa.id)
        def ordenesCompra = emp.ordenCompra == '1'

        def adquisicionesInstance
        if (params.id) {
            adquisicionesInstance = Adquisiciones.get(params.id)
            DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance).each {
                it.delete()
            }
        } else {
            adquisicionesInstance = new Adquisiciones()
        }

        if (params.fechaPago) {
            adquisicionesInstance.fechaPago = new Date().parse("yyyy-MM-dd", params.fechaPago)
            params.remove("fechaPago")
        }
        if (params.fecha) {
            params.remove("fecha")
        }
        params.registro = "N"
        params.estado = "N"

        adquisicionesInstance.properties = params

        def ok = true

        if (!ordenesCompra) {
            def ordenCompra = new OrdenCompra()
            def centroCostos = CentroCosto.findByEmpresa(emp)
            if (!centroCostos) {
                centroCostos = new CentroCosto()
                centroCostos.empresa = emp
                centroCostos.nombre = "Centro costos por defecto"
                if (!centroCostos.save(flush: true)) {
                    println "error al crear centro de costos por default de empresa " + emp.id
                    println centroCostos.errors
                    ok = false
                }
                if (ok) {
                    def bodega = new Bodega()
                    bodega.centroCosto = centroCostos
                    bodega.codigo = "BD"
                    bodega.descripcion = "Bodega por defecto"
                    if (!bodega.save(flush: true)) {
                        println "error al crear bodega por default de empresa " + emp.id
                        println bodega.errors
                        ok = false
                    }
                }
            }
            if (ok) {
                ordenCompra.centroCosto = centroCostos
                ordenCompra.estado = 'R'
                ordenCompra.descripcion = "Orden compra por defecto "
                ordenCompra.observaciones = "Orden compra por defecto "
                ordenCompra.fecha = new Date()
                if (!ordenCompra.save(flush: true)) {
                    println "error al crear orden de compra por default de empresa " + emp.id
                    println ordenCompra.errors
                    ok = false
                }
                if (ok) {
                    ordenCompra.descripcion = ordenCompra.descripcion + ordenCompra.id
                    ordenCompra.observaciones = ordenCompra.observaciones + ordenCompra.id
                    if (!ordenCompra.save(flush: true)) {
                        println "error 2 al crear orden de compra por default de empresa " + emp.id
                        println ordenCompra.errors
                        ok = false
                    }
                }
            }
            adquisicionesInstance.orden = ordenCompra
        }
        if (ok) {
            if (!adquisicionesInstance.save(flush: true)) {
                println(adquisicionesInstance.errors)
                if (params.id) {
                    render(view: "edit", model: [adquisicionesInstance: adquisicionesInstance])
                } else {
                    render(view: "create", model: [adquisicionesInstance: adquisicionesInstance])
                }
                render "error"
            } else {

                def detalles = []
//
                def orden = adquisicionesInstance.orden
                def bodega
                if (orden) {
                    bodega = Bodega.findByCentroCosto(orden.centroCosto)
                    println "si orden " + bodega
                } else {
                    bodega = Bodega.findByCentroCosto(CentroCosto.get(params.centroCosto))
                    println "si orden " + bodega
                }

                def v = (ParametrosAuxiliares.get(1).iva) / 100
                println("items:" + params.item)
                if (params.item.class == java.lang.String) {
                    params.item = [params.item]
                }

                params.item.each { item ->
                    def parts = item.split("\\^")
                    println(parts)
                    def id = parts[0]
                    def cantidad = (parts[1]).toDouble()
                    def precio = (parts[2]).toDouble()
                    def descuento = (parts[3]).toDouble()
                    def conIva = (parts[4]).toInteger()

                    //items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.bodega.id + "^" + item.iva + "^" + item.ice
                    //                      0                   1                   2                   3                       4                   5                   6                  7

                    def iva = (parts[6]).toDouble()
                    def ice = (parts[7]).toDouble()


                    def prod = Item.get(id)

                    def subtotal = (precio * cantidad) - (precio * cantidad * (descuento / 100))

                    def detalle = new DetalleAdquisicion()
                    detalle.adquisiciones = adquisicionesInstance
                    detalle.estado = '0'
                    detalle.item = prod
                    detalle.cantidad = (cantidad)

                    detalle.precioUnitario = (precio)
                    detalle.iva = (iva)
                    detalle.ice = (ice)
                    detalle.subtotal = (subtotal)

                    detalle.bodega = bodega

                    if (detalle.save(flush: true)) {
                        detalles.add(detalle)
                    } else {
                        println("detalles" + detalle.errors)
                    }

                    if (!ordenesCompra) {
                        def detalleOrden = new DetalleOrdenCompra()
                        detalleOrden.ordenCompra = orden
                        detalleOrden.item = prod
                        detalleOrden.cantidad = cantidad
                        detalleOrden.precioUnitario = precio
                        if (!detalleOrden.save(flush: true)) {
                            println "error al crear el detalle de la orde de compra default"
                            println detalleOrden.errors
                        } else {
                            println "\t\t\tguardado ok!!"
                        }
                    }

                }

                def proceso = Proceso.findByAdquisicion(adquisicionesInstance)
                if (!proceso)
                    proceso = new Proceso()
                proceso.gestor = adquisicionesInstance.gestor
                proceso.contabilidad = session.contabilidad
                // proceso.factura = adquisicionesInstance.factura
                proceso.descripcion = "Adquisiciones " + adquisicionesInstance?.proveedor?.ruc + " " + adquisicionesInstance?.fecha?.format("dd/MM/yyyy hh:mm")
                proceso.estado = "N"
                proceso.fecha = new Date()
                proceso.proveedor = adquisicionesInstance.proveedor
                proceso.tipoPago = adquisicionesInstance.tipoPago
                proceso.usuario = session.usuario
                proceso.adquisicion = adquisicionesInstance
                proceso.documento = adquisicionesInstance.facturaSerie1 + "" + adquisicionesInstance.facturaSerie2 + "" + adquisicionesInstance.facturaNumero

//            proceso.tipoComprobanteId = TipoComprobanteId.get(params.tipoComprobanteId)
                if (params.fechaEmision) {
                    proceso.fechaEmision = new Date().parse("yyyy-MM-dd", params.fechaEmision)
                }
                if (params.fechaRegistro) {
                    proceso.fechaRegistro = new Date().parse("yyyy-MM-dd", params.fechaRegistro)
                }
                proceso.autorizacionSRI = params.autorizacionSRI
                proceso.baseImponibleNoIva = 0//params.baseImponibleNoIva?.toDouble()
                proceso.iceGenerado = params.iceGenerado?.toDouble()
//            if (!params.retencionIvaBienes || params.retencionIvaBienes?.trim() == "") {
                params.retencionIvaBienes = 0
//            }
//            proceso.retencionIvaBienes = params.retencionIvaBienes?.toDouble()
//            if (!params.retencionIvaServicio || params.retencionIvaServicio?.trim() == "") {
                params.retencionIvaServicio = 0
//            }
//            proceso.retencionIvaServicios = params.retencionIvaServicio?.toDouble()
//            if (!params.retencionIva || params.retencionIva?.trim() == "") {
                params.retencionIva = 0
//            }
                proceso.retencionIva = 0
                proceso.tipoSoporte = TipoSoporte.get(params.tipoSoporte)


                proceso.tipoRetencion = params.tipoRetencion
                if (params.tipoRetencion != 'N') {
                    proceso.retencionSerie1 = params.retencionSerie1
                    proceso.retencionSerie2 = params.retencionSerie2
                    proceso.retencionSecuencial = params.retencionSecuencial
                    proceso.retencionAutorizacion = params.retencionAutorizacion
                }


                def valor = 0, impuesto = 0
                detalles.each {
                    valor += (it.precioUnitario * it.cantidad)
                    impuesto += (it.iva + it.ice)
                    // println "detallle " + it.iva + "  " + it.precioUnitario + "   " + it.cantidad
                }
                proceso.valor = valor
                proceso.impuesto = impuesto
                println "valor " + proceso.valor + " inp " + proceso.impuesto

                if (proceso.save(flush: true)) {
                    render adquisicionesInstance.id
                } else {
                    println "error en el proceso " + proceso.errors
                    render "error"
                }
            }
        } else {
            println "ERRORES!!"
            render "error"
        }
    } //fin del save


    def registrar() {
        def adq = Adquisiciones.get(params.id)
        def proceso = Proceso.findByAdquisicion(adq)
        adq.estado = "R"
        if (adq.save(flush: true)) {
            procesoService.registrar(proceso, session.perfil, session.usuario)
            proceso.estado = "N"

            proceso.save(flush: true)
            def orden = adq.orden
            //println "Validando estado de la adquisicion...."
            def m = [:]
            DetalleOrdenCompra.findAllByOrdenCompra(orden).each { detalleOC ->
                m[detalleOC.itemId] = detalleOC.cantidad
            }

            Adquisiciones.findAllByOrden(orden).each { adqc ->
                DetalleAdquisicion.findAllByAdquisiciones(adqc).each { detalleAdq ->
                    m[detalleAdq.itemId] -= detalleAdq.cantidad
                }
            }
            if (m.findAll {it.value > 0}.size() != 0) {
//                ordenes.add(orden)
            } else {
                orden.estado = 'C'
                if (!orden.save(flush: true)) {
                    println "error actualizando estado de orden de compra " + orden.errors
                }
            }

            DetalleAdquisicion.findAllByAdquisiciones(adq).each {dtaq ->
                def ext = new Existencias()
                ext.cantidad = 0
                ext.item = dtaq.item
                ext.bodega = dtaq.bodega
                ext.empresa = Empresa.get(session.empresa.id)
                ext.existenciaInicial = 0
                def ok = true

                def existencias = Existencias.findAllByItemAndBodega(dtaq.item, dtaq.bodega)
                if (existencias.size() == 1) {
                    // println "\t\tHay un registro de existencias para " + dtaq.item.nombre + " en la dtaq.bodega " + dtaq.bodega.descripcion
                    ext = existencias[0]
                } else if (existencias.size() == 0) {
                    // println "\t\tNo hay registros de existencias para " + dtaq.item.nombre + " en la dtaq.bodega " + dtaq.bodega.descripcion
                } else {
                    println "\t\tWTF hay mas de un registro de existencias para " + dtaq.item.nombre + " en la dtaq.bodega " + dtaq.bodega.descripcion
                    ok = false
                }

                if (ok) {
                    // println "\t\tmodificando/creando la existencia"
                    ext.cantidad = ext.cantidad + dtaq.cantidad
                    ext.fecha = new Date()
//                        ext.precio = precio
                    if (!ext.save(flush: true)) {
                        println "\t\t\tNO se guardo la existencia!!"
                    } else {
                        //println "\t\t\tSI se guardo la existencia!!"
                    }
                }
            }


            render "OK"
        }
    }

    def show() {

        def datos = ParametrosAuxiliares.get(1)

        def adquisicionesInstance = Adquisiciones.get(params.id)
        if (!adquisicionesInstance) {
            flash.message = "No se encontró Adquisiciones con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [adquisicionesInstance: adquisicionesInstance, piva: datos.iva]
    }


    def revisarAdquisicion() {


        def adquisicionesInstance = Adquisiciones.get(params.id)
        if (!adquisicionesInstance) {
            flash.message = "No se encontró Adquisiciones con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"


            return

        }

        [adquisicionesInstance: adquisicionesInstance]
    }

//    def revisarSave() {
//
//
//        def adquisicionesInstance = Adquisiciones.get(params.id);
//
//        if (!adquisicionesInstance) {
//            flash.message = "No se encontró Adquisiciones con id " + params.id
//            flash.clase = "error"
//            flash.ico = "ss_delete"
//            return
//
//        }
//
//
//        def detalleAdqc = DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance);
//
//
//
//        println("detalle" + detalleAdqc);
//
//        println("estado" + detalleAdqc.estado);
//
//        [adquisicionesInstance: adquisicionesInstance]
//
//
//    }


    def edit() {
        def adquisicionesInstance = Adquisiciones.get(params.id)
        if (!adquisicionesInstance) {
            flash.message = "No se encontró Adquisiciones con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [adquisicionesInstance: adquisicionesInstance]
    }

    def delete() {
        def adquisicionesInstance = Adquisiciones.get(params.id)
        if (!adquisicionesInstance) {
            flash.message = "No se encontró Adquisiciones con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            adquisicionesInstance.delete(flush: true)
            flash.message = "Adquisiciones  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Adquisiciones con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}

