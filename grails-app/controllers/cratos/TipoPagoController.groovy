package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoPagoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoPagoInstanceList: TipoPago.list(params), tipoPagoInstanceTotal: TipoPago.count()]
    }

    def create() {
        [tipoPagoInstance: new TipoPago(params)]
    }

    def save() {
        def tipoPagoInstance = new TipoPago(params)


        println("id" + params.id)

        if (params.id) {
            tipoPagoInstance = TipoPago.get(params.id)
            tipoPagoInstance.properties = params
        }

        if (!tipoPagoInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoPagoInstance: tipoPagoInstance])
            } else {
                render(view: "create", model: [tipoPagoInstance: tipoPagoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoPago actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoPago creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoPagoInstance.id)
    }

    def show() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPagoInstance: tipoPagoInstance]
    }

    def edit() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPagoInstance: tipoPagoInstance]
    }

    def delete() {
        def tipoPagoInstance = TipoPago.get(params.id)
        if (!tipoPagoInstance) {
            flash.message = "No se encontró TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoPagoInstance.delete(flush: true)
            flash.message = "TipoPago  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoPago con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
