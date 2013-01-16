package cratos.seguridad

import org.springframework.dao.DataIntegrityViolationException

class UsroController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [usroInstanceList: Usro.list(params), usroInstanceTotal: Usro.count()]
    }

    def create() {
        [usroInstance: new Usro(params)]
    }

    def save() {
        if (params.fechaPass) {
            params.fechaPass = new Date().parse("dd-MM-yyyy", params.fechaPass)
        }
        if (params.password) {
            params.password = params.password.encodeAsMD5()
        }
        if (params.autorizacion) {
            params.autorizacion = params.autorizacion.encodeAsMD5()
        }
        def usroInstance = new Usro(params)

        if (params.id) {
            usroInstance = Usro.get(params.id)
            usroInstance.properties = params
        }

        if (!usroInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [usroInstance: usroInstance])
            } else {
                render(view: "create", model: [usroInstance: usroInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Usro actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Usro creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: usroInstance.id)
    }

    def show() {
        def usroInstance = Usro.get(params.id)
        if (!usroInstance) {
            flash.message = "No se encontró Usro con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [usroInstance: usroInstance]
    }

    def edit() {
        def usroInstance = Usro.get(params.id)
        if (!usroInstance) {
            flash.message = "No se encontró Usro con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [usroInstance: usroInstance]
    }

    def delete() {
        def usroInstance = Usro.get(params.id)
        if (!usroInstance) {
            flash.message = "No se encontró Usro con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            usroInstance.delete(flush: true)
            flash.message = "Usro  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Usro con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
