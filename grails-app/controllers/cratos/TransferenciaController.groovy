package cratos

import org.springframework.dao.DataIntegrityViolationException

class TransferenciaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def procesoService

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [transferenciaInstanceList: Transferencia.list(params), transferenciaInstanceTotal: Transferencia.count()]
    }

    def create() {
        def transferenciaInstance = new Transferencia(params)
        if (params.id) {
            transferenciaInstance = Transferencia.get(params.id)
        }

        [transferenciaInstance: transferenciaInstance]
    }

    def getBodegaFromCentroCostos() {
        def transfer = Transferencia.get(params.transfer)

        def selected = ""
        if (transfer) {
            selected = transfer["bodega" + (params.tipo.toString().capitalize())]
            selected = selected.id
        }

        def centro = CentroCosto.get(params.id)
        def bodegas = []
        Bodega.findAllByCentroCosto(centro).each { bodega ->
            if (Existencias.countByBodega(bodega) > 0) {
                bodegas.add(bodega)
            }
        }

        def select = g.select(name: "bodega" + (params.tipo.toString().capitalize()) + ".id", id: "bodega" + (params.tipo.toString().capitalize()), "class": "bodega field ui-corner-all required", from: bodegas, optionKey: "id", optionValue: "descripcion", value: selected)
        def js = "<script type='text/javascript'>"
        js += '$("#bodega' + (params.tipo.toString().capitalize()) + '").change(function () {'
        js += 'checkOverlay();'
        js += '});'
        js += "</script>"
        render select + js
    }


    def buscarItem = {
        def bodegaSale = Bodega.get(params.bodegaSale)
        def search = params.search
        def iva = ParametrosAuxiliares.get(1).iva

        def results = Existencias.withCriteria {
            and {
                eq("bodega", bodegaSale)
                item {
                    or {
                        ilike("nombre", "%" + search + "%")
                        ilike("codigo", "%" + search + "%")
                    }
                    order("nombre", "asc")
                }
            }
            maxResults(20)
        }

//        def results = Item.withCriteria {
//            or {
//                ilike("nombre", "%" + search + "%")
//                ilike("codigo", "%" + search + "%")
//            }
//            maxResults(20)
//            order("nombre", "asc")
//        }
        return [results: results, iva: iva, bodega: bodegaSale]
    }



    def save() {
        println(params)
        def transferenciaInstance = new Transferencia(params)
        if (params.fecha) {
            transferenciaInstance.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
            params.remove("fecha")
        }
        transferenciaInstance.properties = params
        transferenciaInstance.registro = '1'
        transferenciaInstance.estado = 'N'
        if (params.id) {
            transferenciaInstance = Transferencia.get(params.id)
            transferenciaInstance.properties = params
            DetalleTransferencia.findAllByTransferencia(transferenciaInstance).each {
                it.delete()
            }
        }

        if (!transferenciaInstance.save(flush: true)) {
            println(transferenciaInstance.errors)
            if (params.id) {
//                println("1")
                render(view: "edit", model: [transferenciaInstance: transferenciaInstance])
            } else {
//                println("2")
                render(view: "create", model: [transferenciaInstance: transferenciaInstance])
            }

        } else {
            def detalles = []
            def v = ParametrosAuxiliares.get(1).iva
            if (params.item.class == java.lang.String)
                params.item = [params.item]
            params.item.each { item ->
                def parts = item.split("\\^")
                println(parts)
                def id = (parts[0])
                def cantidad = (parts[1]).toDouble()
                def precio = (parts[2]).toDouble()
//                def descuento = (parts[3]).toDouble()
//                def conIva = (parts[4]).toInteger()
//                def iva = ((precio * cantidad) - (precio * cantidad * (descuento / 100)) * conIva) * v
//
//                def subtotal = (precio * cantidad) - (precio * cantidad * (descuento / 100))

                def detalle = new DetalleTransferencia();
                detalle.transferencia = transferenciaInstance;
                detalle.item = Item.get(id);
                detalle.cantidad = (cantidad);
                detalle.precioUnitario = (precio);

                if (detalle.save(flush: true))
                    detalles.add(detalle)
                else
                    println("detalles" + detalle.errors)
            }

            def proceso = Proceso.findByTransferencia(transferenciaInstance)
            if (!proceso)
                proceso = new Proceso()
            proceso.gestor = Gestor.get(params.gestor)
            proceso.contabilidad = session.contabilidad
            // proceso.factura = adquisicionesInstance.factura
            proceso.descripcion = "Transferencia de bodega id " + transferenciaInstance?.bodegaSale.id + " a bodega id " + transferenciaInstance.bodegaRecibe.id + "  " + transferenciaInstance?.fecha?.format("dd/MM/yyyy")
            proceso.estado = "N"
            proceso.fecha = new Date()
            proceso.usuario = session.usuario
            proceso.transferencia = transferenciaInstance

            if (params.fechaEmision) {
                proceso.fechaEmision = new Date().parse("yyyy-MM-dd", params.fechaEmision)
            }
            if (params.fechaRegistro) {
                proceso.fechaRegistro = new Date().parse("yyyy-MM-dd", params.fechaRegistro)
            }
            proceso.baseImponibleNoIva = 0//params.baseImponibleNoIva?.toDouble()
            proceso.iceGenerado = 0
            proceso.retencionIvaBienes = 0
            proceso.retencionIvaServicios = 0
            proceso.retencionIva = 0

            def valor = 0, impuesto = 0
            detalles.each {
                valor += (it.precioUnitario * it.cantidad)
//                impuesto += (it.iva + it.ice)
                // println "detallle " + it.iva + "  " + it.precioUnitario + "   " + it.cantidad
            }
            proceso.valor = valor
            proceso.impuesto = impuesto
            println "valor " + proceso.valor + " inp " + proceso.impuesto

            if (proceso.save(flush: true)) {
                render transferenciaInstance.id
            } else {
                println "error en el proceso " + proceso.errors
                render "error"
            }

//            if (params.id) {
//                flash.message = "Transferencia actualizado"
//                flash.clase = "success"
//                flash.ico = "ss_accept"
//            } else {
//                flash.message = "Transferencia creado"
//                flash.clase = "success"
//                flash.ico = "ss_accept"
//            }
//            render transferenciaInstance.id
//            render "OK"
        }
    }

    def show() {
        def transferenciaInstance = Transferencia.get(params.id)
        if (!transferenciaInstance) {
            flash.message = "No se encontró Transferencia con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [transferenciaInstance: transferenciaInstance]
    }


    def registrar() {
        def trans = Transferencia.get(params.id)

        def errores = ""

        DetalleTransferencia.findAllByTransferencia(trans).each { detalle ->
            def existenciaReducir = Existencias.findAllByBodegaAndItem(Bodega.get(params.bodegaSale.id), detalle.item)
            if (existenciaReducir.size() == 0) {
                println "No existe la existencia a reducir.........Creando en 0 - " + detalle.cantidad
                existenciaReducir = new Existencias()
                existenciaReducir.fecha = new Date()
                existenciaReducir.cantidad = 0 - detalle.cantidad
                existenciaReducir.empresa = Empresa.get(session.empresa.id)
                existenciaReducir.item = detalle.item
                existenciaReducir.existenciaInicial = 0
                existenciaReducir.bodega = Bodega.get(params.bodegaSale.id)
                if (!existenciaReducir.save(flush: true)) {
                    println "Error creando existencia a reducir.... " + existenciaReducir.errors
                    errores += "Error al reducir la existencia de " + detalle.item.nombre + "<br/>"
                }
            } else if (existenciaReducir.size() == 1) {
                println "Reduciendo existencia"
                if (existenciaReducir.cantidad - detalle.cantidad) {
                    println "NOOOO-> " + (existenciaReducir.cantidad - detalle.cantidad)
                    errores += "Error al reducir la existencia de " + detalle.item.nombre + ":"
                    errores += " se ha modificado la existencia del producto, por favor modifíquela para continuar<br/>"
                } else {
                    existenciaReducir = existenciaReducir[0]
                    existenciaReducir.fecha = new Date()
                    existenciaReducir.cantidad = existenciaReducir.cantidad - detalle.cantidad
                    if (!existenciaReducir.save(flush: true)) {
                        println "Error guardando existencia reducida.... " + existenciaReducir.errors
                        errores += "Error al reducir la existencia de " + detalle.item.nombre + "<br/>"
                    }
                }
            } else {
                println "WTF hay mas de una existencia a reducir!!! bodega: " + params.bodegaSale.id + " item: " + detalle.item.id
                errores += "Error: hay más de una existencia a reducir de " + detalle.item.nombre + "<br/>"
            }

            if (errores == "") {
                def existenciaAumentar = Existencias.findAllByBodegaAndItem(Bodega.get(params.bodegaRecibe.id), detalle.item)
                if (existenciaAumentar.size() == 0) {
                    println "No existe la existencia a Aumentar.........Creando en 0 + " + detalle.cantidad
                    existenciaAumentar = new Existencias()
                    existenciaAumentar.fecha = new Date()
                    existenciaAumentar.cantidad = 0 + detalle.cantidad
                    existenciaAumentar.empresa = Empresa.get(session.empresa.id)
                    existenciaAumentar.item = detalle.item
                    existenciaAumentar.existenciaInicial = 0
                    existenciaAumentar.bodega = Bodega.get(params.bodegaRecibe.id)
                    if (!existenciaAumentar.save(flush: true)) {
                        println "Error creando existencia a Aumentar.... " + existenciaAumentar.errors
                        println "Haciendo rollback de la disminucion "
                        existenciaReducir.cantidad = existenciaReducir.cantidad + detalle.cantidad
                        if (!existenciaReducir.save(flush: true)) {
                            println "Error guardando existencia reducida....del rollback!!! " + existenciaReducir.errors
                        }
                        errores += "Error al aumentar la existencia de " + detalle.item.nombre + "<br/>"
                    }
                } else if (existenciaAumentar.size() == 1) {
                    println "Aumentando existencia"
                    existenciaAumentar = existenciaAumentar[0]
                    existenciaAumentar.fecha = new Date()
                    existenciaAumentar.cantidad = existenciaAumentar.cantidad + detalle.cantidad
                    if (!existenciaAumentar.save(flush: true)) {
                        println "Error guardando existencia Aumentar.... " + existenciaAumentar.errors
                        println "Haciendo rollback de la disminucion "
                        existenciaReducir.cantidad = existenciaReducir.cantidad + detalle.cantidad
                        if (!existenciaReducir.save(flush: true)) {
                            println "Error guardando existencia reducida....del rollback!!! " + existenciaReducir.errors
                        }
                        errores += "Error al aumentar la existencia de " + detalle.item.nombre + "<br/>"
                    }
                } else {
                    println "WTF hay mas de una existencia a Aumentar!!! bodega: " + params.bodegaRecibe.id + " item: " + detalle.item.id
                    println "Haciendo rollback de la disminucion "
                    existenciaReducir.cantidad = existenciaReducir.cantidad + detalle.cantidad
                    if (!existenciaReducir.save(flush: true)) {
                        println "Error guardando existencia reducida....del rollback!!! " + existenciaReducir.errors
                    }
                    errores += "Error: hay más de una existencia a aumentar de " + detalle.item.nombre + "<br/>"
                }
            }
        }

        if (errores == "") {
            def proceso = Proceso.findByTransferencia(trans)
            trans.estado = "R"
            if (trans.save(flush: true)) {
                procesoService.registrar(proceso, session.perfil, session.usuario)
                proceso.estado = "R"
                proceso.save(flush: true)
                render "OK"
            }
        } else {
            render errores
        }
    }

    def edit() {
        def transferenciaInstance = Transferencia.get(params.id)
        if (!transferenciaInstance) {
            flash.message = "No se encontró Transferencia con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [transferenciaInstance: transferenciaInstance]
    }

    def delete() {
        def transferenciaInstance = Transferencia.get(params.id)
        if (!transferenciaInstance) {
            flash.message = "No se encontró Transferencia con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            transferenciaInstance.delete(flush: true)
            flash.message = "Transferencia  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Transferencia con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
