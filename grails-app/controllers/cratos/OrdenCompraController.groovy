package cratos

import org.springframework.dao.DataIntegrityViolationException

class OrdenCompraController extends cratos.seguridad.Shield {

    def ordenCompra

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def registrarCompra() {

    }


    def list() {

        def ordenComprasInstance = new OrdenCompra(params)
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "fecha"
            params.order = "desc"
        }
        [ordenCompraInstanceList: OrdenCompra.list(params), ordenCompraInstanceTotal: OrdenCompra.count(), ordenCompraInstance: ordenComprasInstance]
    }

    def create() {
        def iva = ParametrosAuxiliares.get(1).iva

        def ordenCompraInstance = new OrdenCompra(params)
        if (params.id) {
            ordenCompraInstance = OrdenCompra.get(params.id)
            if (!ordenCompraInstance) {
                flash.message = "No se encontr&oacute; Orden de Compra a modificar"
            }
        }

        return [ordenCompraInstance: ordenCompraInstance, iva: iva]
    }


    def loadItems() {
        def ordenCompra = OrdenCompra.get(params.id)

        def items = "["
        DetalleOrdenCompra.findAllByOrdenCompra(ordenCompra, [sort: 'item']).each { detalle ->
            items += "{"
            items += "\"cantidad\":" + detalle.cantidad + ","
            items += "\"codigo\": \"" + detalle.item.codigo + "\","
            items += "\"id\":" + detalle.item.id + ","
            items += "\"nombre\": \"" + detalle.item.nombre + "\","
            items += "\"precio\": " + detalle.precioUnitario + ","
            items += "\"total\": " + (detalle.cantidad * detalle.precioUnitario) + ","
            items += "\"saved\": true,"
            items += "\"detalle\": " + detalle.id
            items += "},"
        }
        if (items != "[") {
            items = items[0..-2]
        }
        items += "]" + "\n"

        render items
    }

    def deleteDetalle() {
        def detalle = DetalleOrdenCompra.get(params.id)
        try {
            detalle.delete(flush: true)
            render "OK"
        } catch (DataIntegrityViolationException e) {
            render e.message
        }
    }

    def save() {


        def b = true;
        def ok = true;
        def empresa = Empresa.get(session.empresa.id)
        def centroCosto = CentroCosto.get(params.centroCosto)
        def estado = params.estado
        def observaciones = params.observaciones
        def descripcion = params.descripcion
        def total = params.subtotal.toDouble()
        def fecha = new Date()
        if (params.fecha) {
            fecha = new Date().parse("yyyy-MM-dd", params.fecha)
        }

        def items = params.item
        if (items.class == java.lang.String) {
            items = [items]
        }

        def ordenCompraInstance
        if (params.id) {
            ordenCompraInstance = OrdenCompra.get(params.id)
            if (!ordenCompraInstance) {
                flash.message = "No se encontr&oacute; OrdenCompra a modificar"
                render "NO"
                return
            }
        } else {
            ordenCompraInstance = new OrdenCompra()
        }

        ordenCompraInstance.centroCosto = centroCosto
        ordenCompraInstance.descripcion = descripcion
        ordenCompraInstance.valor = total
        ordenCompraInstance.fecha = fecha
//        ordenCompraInstance.estado = estado
        ordenCompraInstance.observaciones = observaciones
        ordenCompraInstance.estado = 'N'

        ordenCompraInstance.numero = params.numero

        if (ordenCompraInstance.save(flush: true)) {

            items.each { item ->
                //items += "&item=" + item.id + "^" + item.cantidad + "^" + item.precio + "^" + item.descuento + "^" + item.conIva + "^" + item.observaciones
                def parts = item.split("\\^")
                println "PARTS: " + parts
                def id = parts[0]
                def cantidad = parts[1]
                def precio = parts[2]
                def detalleOrden = new DetalleOrdenCompra()
                if (parts.size() == 4) {
                    detalleOrden = DetalleOrdenCompra.get(parts[3].toLong())
                }

                detalleOrden.precioUnitario = precio.toDouble()
                detalleOrden.cantidad = cantidad.toDouble()
                detalleOrden.item = Item.get(id.toLong())
                detalleOrden.ordenCompra = ordenCompraInstance
                if (!detalleOrden.save(flush: true)) {
                    ok = false
                    b = false
                }
            }

        } else {
            println "ERROR!!! " + ordenCompraInstance.errors
            ok = false
        }
        if (ok) {
            if (params.id) {
                flash.message = "Orden de compra actualizada"
                flash.clase = "success"
                flash.ico = "ss_accept"
            } else {
                flash.message = "Orden de compra creada"
                flash.clase = "success"
                flash.ico = "ss_accept"
            }
            render(ordenCompraInstance.id)

        } else {
            flash.message = "Ha ocurrido un error"
            flash.clase = "error"
            flash.ico = "ss_delete"
            render("error")
        }
    }

//    def save() {
//        def ordenCompraInstance
//        if (params.id) {
//            ordenCompraInstance = OrdenCompra.get(params.id)
//            if (!ordenCompraInstance) {
//                flash.message = "No se encontr&oacute; OrdenCompra a modificar"
//                render "NO"
//                return
//            }
//            ordenCompraInstance.properties = params
//        } else {
//            ordenCompraInstance = new OrdenCompra(params)
//        }
//        if (!ordenCompraInstance.save(flush: true)) {
//            render "NO"
//            println ordenCompraInstance.errors
//            flash.message = "Ha ocurrido un error al guardar OrdenCompra"
//            return
//        }
//
//        flash.message = "OrdenCompra guardado exitosamente"
////    redirect(action: "show", id: ordenCompraInstance.id)
//        render "OK"
//    }

    def show() {
        def ordenCompraInstance = OrdenCompra.get(params.id)
        if (!ordenCompraInstance) {
            flash.message = "No se encontr&oacute; OrdenCompra a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [ordenCompraInstance: ordenCompraInstance]
    }

    def edit() {


        println(params);

        def ordenCompraInstance = OrdenCompra.get(params.id)
        if (!ordenCompraInstance) {
            flash.message = "No se encontr&oacute; OrdenCompra a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [ordenCompraInstance: ordenCompraInstance]
    }


    def actualizarEstado() {
        def ordenCompraInstance = OrdenCompra.get(params.id);
        def estado = ordenCompraInstance.estado;
        def ok = true
        if (estado == 'R') {
            ordenCompraInstance.estado = 'N';
            if (!ordenCompraInstance.save(flush: true)) {
                ok = false
            }
        }
        else {
            ordenCompraInstance.estado = 'R'
            if (!ordenCompraInstance.save(flush: true)) {
                ok = false
            }
        }

        if (ok) {
            redirect(action: 'list')
        } else {
            redirect(action: 'show', id: params.id)
        }
    }

    def delete() {
        def ordenCompraInstance = OrdenCompra.get(params.id)
        if (!ordenCompraInstance) {
            flash.message = "No se encontr&oacute; OrdenCompra a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            DetalleOrdenCompra.findAllByOrdenCompra(ordenCompraInstance).each { detalle ->
                try {
                    detalle.delete(flush: true)
                } catch (DataIntegrityViolationException e) {
                    println "ERROR AL eliminar detalle: " + e.message
                }
            }
            ordenCompraInstance.delete(flush: true)
            flash.message = "OrdenCompra eliminado exitosamente"
            redirect(action: "list")
        } catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar OrdenCompra"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
