package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoComprobanteSriController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoComprobanteSriInstanceList: TipoComprobanteSri.list(params), tipoComprobanteSriInstanceTotal: TipoComprobanteSri.count()]
    }

    def create() {
        [tipoComprobanteSriInstance: new TipoComprobanteSri(params)]
    }

    def save() {
        def tipoComprobanteSriInstance
        if (params.id) {
            tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
            if (!tipoComprobanteSriInstance) {
                flash.message = "No se encontr&oacute; TipoComprobanteSri a modificar"
                render "NO"
                return
            }
            tipoComprobanteSriInstance.properties = params
        } else {
            tipoComprobanteSriInstance = new TipoComprobanteSri(params)
        }
        if (!tipoComprobanteSriInstance.save(flush: true)) {
            render "NO"
            println tipoComprobanteSriInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoComprobanteSri"
            return
        }

        flash.message = "TipoComprobanteSri guardado exitosamente"
//    redirect(action: "show", id: tipoComprobanteSriInstance.id)
        render "OK"
    }

    def show() {
        def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
        if (!tipoComprobanteSriInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteSri a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
    }

    def edit() {
        def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
        if (!tipoComprobanteSriInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteSri a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoComprobanteSriInstance: tipoComprobanteSriInstance]
    }

    def delete() {
        def tipoComprobanteSriInstance = TipoComprobanteSri.get(params.id)
        if (!tipoComprobanteSriInstance) {
            flash.message = "No se encontr&oacute; TipoComprobanteSri a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoComprobanteSriInstance.delete(flush: true)
            flash.message = "TipoComprobanteSri eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoComprobanteSri"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
