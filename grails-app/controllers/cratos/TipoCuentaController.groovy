package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoCuentaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoCuentaInstanceList: TipoCuenta.list(params), tipoCuentaInstanceTotal: TipoCuenta.count()]
    }

    def create() {
        [tipoCuentaInstance: new TipoCuenta(params)]
    }

    def save() {
        def tipoCuentaInstance = new TipoCuenta(params)

        if(params.id) {
            tipoCuentaInstance = TipoCuenta.get(params.id)
            tipoCuentaInstance.properties = params
        }

        if (!tipoCuentaInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [tipoCuentaInstance: tipoCuentaInstance])
            } else {
                render(view: "create", model: [tipoCuentaInstance: tipoCuentaInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "TipoCuenta actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "TipoCuenta creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: tipoCuentaInstance.id)
    }

    def show() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
            flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoCuentaInstance: tipoCuentaInstance]
    }

    def edit() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
            flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoCuentaInstance: tipoCuentaInstance]
    }

    def delete() {
        def tipoCuentaInstance = TipoCuenta.get(params.id)
        if (!tipoCuentaInstance) {
			flash.message = "No se encontró TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoCuentaInstance.delete(flush: true)
			flash.message = "TipoCuenta  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar TipoCuenta con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
