package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoComprobanteIdController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoComprobanteIdInstanceList: TipoComprobanteId.list(params), tipoComprobanteIdInstanceTotal: TipoComprobanteId.count()]
    }

    def create() {
        [tipoComprobanteIdInstance: new TipoComprobanteId(params)]
    }

    def save() {
        def tipoComprobanteIdInstance
        if (params.id) {
            tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
            if (!tipoComprobanteIdInstance) {
                flash.message = "No se encontr&oacute; TipoComprobanteId a modificar"
                render "NO"
                return
            }
            tipoComprobanteIdInstance.properties = params
        } else {
            tipoComprobanteIdInstance = new TipoComprobanteId(params)
        }
        if (!tipoComprobanteIdInstance.save(flush: true)) {
            render "NO"
            println tipoComprobanteIdInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoComprobanteId"
            return
        }

        flash.message = "TipoComprobanteId guardado exitosamente"
//    redirect(action: "show", id: tipoComprobanteIdInstance.id)
        render "OK"
    }

    def show() {
        def tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
        if (!tipoComprobanteIdInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteId a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoComprobanteIdInstance: tipoComprobanteIdInstance]
    }

    def edit() {
        def tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
        if (!tipoComprobanteIdInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteId a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoComprobanteIdInstance: tipoComprobanteIdInstance]
    }

    def delete() {
        def tipoComprobanteIdInstance = TipoComprobanteId.get(params.id)
        if (!tipoComprobanteIdInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteId a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoComprobanteIdInstance.delete(flush: true)
            flash.message = "TipoComprobanteId eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoComprobanteId"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
