package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoComprobanteController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoComprobanteInstanceList: TipoComprobante.list(params), tipoComprobanteInstanceTotal: TipoComprobante.count()]
    }

    def create() {
        [tipoComprobanteInstance: new TipoComprobante(params)]
    }

    def save() {
        def tipoComprobanteInstance = new TipoComprobante(params)

        if (params.id) {
            tipoComprobanteInstance = TipoComprobante.get(params.id)
            tipoComprobanteInstance.properties = params
        }

        if (!tipoComprobanteInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoComprobanteInstance: tipoComprobanteInstance])
            } else {
                render(view: "create", model: [tipoComprobanteInstance: tipoComprobanteInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoComprobante actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoComprobante creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoComprobanteInstance.id)
    }

    def show() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoComprobanteInstance: tipoComprobanteInstance]
    }

    def edit() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoComprobanteInstance: tipoComprobanteInstance]
    }

    def delete() {
        def tipoComprobanteInstance = TipoComprobante.get(params.id)
        if (!tipoComprobanteInstance) {
            flash.message = "No se encontró TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoComprobanteInstance.delete(flush: true)
            flash.message = "TipoComprobante  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoComprobante con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
