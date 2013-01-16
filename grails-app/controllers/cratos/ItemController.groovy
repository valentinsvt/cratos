package cratos

import org.springframework.dao.DataIntegrityViolationException

class ItemController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def updatePrecio() {
        println params
        def item = Item.get(params.id)
        def precio = (params.precio).toDouble()

        item.precioCosto = precio

        if (item.save(flush: true)) {
            render "Precio actualizado exitosamente_info_Mensaje"
        } else {
            render "Ha ocurrido un error al actualizar el precio_alert_Error"
        }
    }

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itemInstanceList: Item.list(params), itemInstanceTotal: Item.count()]
    }

    def create() {
        [itemInstance: new Item(params)]
    }

    def buscarItem() {
        def search = params.search

        def iva = ParametrosAuxiliares.get(1).iva
//        println "from Item where upper(nombre) like '%${search.toUpperCase()}%' and upper(codigo) like '%${search.toUpperCase()}%' "
//        def results = Item.findAll("from Item where upper(nombre) like '%${search.toUpperCase()}%' or upper(codigo) like '%${search.toUpperCase()}%' ", [max: 20])

        def results = Item.withCriteria {
            eq("empresa", Empresa.get(session.empresa.id))
            or {
                ilike("nombre", "%" + search + "%")
                ilike("codigo", "%" + search + "%")
            }
            order("nombre", "asc")
            maxResults(20)
        }

        return [results: results, iva: iva]
    }

    def buscarItemOrdenCompra() {
        def search = params.search

        def iva = ParametrosAuxiliares.get(1).iva
//        println "from Item where upper(nombre) like '%${search.toUpperCase()}%' and upper(codigo) like '%${search.toUpperCase()}%' "
//        def results = Item.findAll("from Item where upper(nombre) like '%${search.toUpperCase()}%' or upper(codigo) like '%${search.toUpperCase()}%' ", [max: 20])

        def results = Item.withCriteria {
            eq("empresa", Empresa.get(session.empresa.id))
            or {
                ilike("nombre", "%" + search + "%")
                ilike("codigo", "%" + search + "%")
            }
            order("nombre", "asc")
            maxResults(20)
        }


        return [results: results, iva: iva]
    }

    def save() {

        params.empresa = Empresa.get(session.empresa.id)

        println("Items:" + params)


        def itemInstance = new Item()

        if (params.fecha) {

            itemInstance.fecha = new Date().parse("yyy-MM-dd", params.fecha)
            params.remove("fecha")


        }

        itemInstance.properties = params



        if (params.id) {

            itemInstance = Item.get(params.id)


            if (params.fecha) {

                itemInstance.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
                params.remove("fecha")

            }

            itemInstance.properties = params
        }


        itemInstance.estado = params.estado

        if (!itemInstance.save(flush: true)) {
            println(itemInstance.errors)
            if (params.id) {
                render(view: "edit", model: [itemInstance: itemInstance])
            } else {
                render(view: "create", model: [itemInstance: itemInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Item actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Item creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: itemInstance.id)
    }

    def show() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def edit() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [itemInstance: itemInstance]
    }

    def delete() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = "No se encontró Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            itemInstance.delete(flush: true)
            flash.message = "Item  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Item con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
