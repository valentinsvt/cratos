package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoRelacionController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoRelacionInstanceList: TipoRelacion.list(params), tipoRelacionInstanceTotal: TipoRelacion.count()]
    }

    def create() {
        [tipoRelacionInstance: new TipoRelacion(params)]
    }

    def save() {
        def tipoRelacionInstance
        if (params.id) {
            tipoRelacionInstance = TipoRelacion.get(params.id)
            if (!tipoRelacionInstance) {
                flash.message = "No se encontr&oacute; TipoRelacion a modificar"
                render "NO"
                return
            }
            tipoRelacionInstance.properties = params
        } else {
            tipoRelacionInstance = new TipoRelacion(params)
        }
        if (!tipoRelacionInstance.save(flush: true)) {
            render "NO"
            println tipoRelacionInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoRelacion"
            return
        }

        flash.message = "TipoRelacion guardado exitosamente"
//    redirect(action: "show", id: tipoRelacionInstance.id)
        render "OK"
    }

    def show() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoRelacionInstance: tipoRelacionInstance]
    }

    def edit() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoRelacionInstance: tipoRelacionInstance]
    }

    def delete() {
        def tipoRelacionInstance = TipoRelacion.get(params.id)
        if (!tipoRelacionInstance) {
            flash.message = "No se encontr&oacute; TipoRelacion a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoRelacionInstance.delete(flush: true)
            flash.message = "TipoRelacion eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoRelacion"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
