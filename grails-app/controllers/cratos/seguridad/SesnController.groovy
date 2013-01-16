package cratos.seguridad

import org.springframework.dao.DataIntegrityViolationException

class SesnController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sesnInstanceList: Sesn.list(params), sesnInstanceTotal: Sesn.count()]
    }

    def create() {
        [sesnInstance: new Sesn(params)]
    }

    def save() {
        def sesnInstance = new Sesn(params)

        if(params.id) {
            sesnInstance = Sesn.get(params.id)
            sesnInstance.properties = params
        }

        if (!sesnInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [sesnInstance: sesnInstance])
            } else {
                render(view: "create", model: [sesnInstance: sesnInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Sesn actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Sesn creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: sesnInstance.id)
    }

    def show() {
        def sesnInstance = Sesn.get(params.id)
        if (!sesnInstance) {
            flash.message = "No se encontró Sesn con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [sesnInstance: sesnInstance]
    }

    def edit() {
        def sesnInstance = Sesn.get(params.id)
        if (!sesnInstance) {
            flash.message = "No se encontró Sesn con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [sesnInstance: sesnInstance]
    }

    def delete() {
        def sesnInstance = Sesn.get(params.id)
        if (!sesnInstance) {
			flash.message = "No se encontró Sesn con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            sesnInstance.delete(flush: true)
			flash.message = "Sesn  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Sesn con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
