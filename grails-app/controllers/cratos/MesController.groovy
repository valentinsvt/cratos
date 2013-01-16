package cratos

import org.springframework.dao.DataIntegrityViolationException

class MesController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [mesInstanceList: Mes.list(params), mesInstanceTotal: Mes.count()]
    }

    def create() {
        [mesInstance: new Mes(params)]
    }

    def save() {
        def mesInstance
        if (params.id) {
            mesInstance = Mes.get(params.id)
            if (!mesInstance) {
                flash.message = "No se encontr&oacute; Mes a modificar"
                render "NO"
                return
            }
            mesInstance.properties = params
        } else {
            mesInstance = new Mes(params)
        }
        if (!mesInstance.save(flush: true)) {
            render "NO"
            println mesInstance.errors
            flash.message = "Ha ocurrido un error al guardar Mes"
            return
        }

        flash.message = "Mes guardado exitosamente"
//    redirect(action: "show", id: mesInstance.id)
        render "OK"
    }

    def show() {
        def mesInstance = Mes.get(params.id)
        if (!mesInstance) {
            flash.message = "No se encontr&oacute; Mes a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [mesInstance: mesInstance]
    }

    def edit() {
        def mesInstance = Mes.get(params.id)
        if (!mesInstance) {
            flash.message = "No se encontr&oacute; Mes a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [mesInstance: mesInstance]
    }

    def delete() {
        def mesInstance = Mes.get(params.id)
        if (!mesInstance) {
            flash.message = "No se encontr&oacute; Mes a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            mesInstance.delete(flush: true)
            flash.message = "Mes eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Mes"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
