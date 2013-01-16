package cratos

import org.springframework.dao.DataIntegrityViolationException

class EstadoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [estadoInstanceList: Estado.list(params), estadoInstanceTotal: Estado.count()]
    }

    def create() {
        [estadoInstance: new Estado(params)]
    }

    def save() {
        def estadoInstance
        if (params.id) {
            estadoInstance = Estado.get(params.id)
            if (!estadoInstance) {
                flash.message = "No se encontr&oacute; Estado a modificar"
                render "NO"
                return
            }
            estadoInstance.properties = params
        } else {
            estadoInstance = new Estado(params)
        }
        if (!estadoInstance.save(flush: true)) {
            render "NO"
            println estadoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Estado"
            return
        }

        flash.message = "Estado guardado exitosamente"
//    redirect(action: "show", id: estadoInstance.id)
        render "OK"
    }

    def show() {
        def estadoInstance = Estado.get(params.id)
        if (!estadoInstance) {
            flash.message = "No se encontr&oacute; Estado a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [estadoInstance: estadoInstance]
    }

    def edit() {
        def estadoInstance = Estado.get(params.id)
        if (!estadoInstance) {
            flash.message = "No se encontr&oacute; Estado a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [estadoInstance: estadoInstance]
    }

    def delete() {
        def estadoInstance = Estado.get(params.id)
        if (!estadoInstance) {
            flash.message = "No se encontr&oacute; Estado a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            estadoInstance.delete(flush: true)
            flash.message = "Estado eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Estado"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
