package cratos

import org.springframework.dao.DataIntegrityViolationException

class NivelController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [nivelInstanceList: Nivel.list(params), nivelInstanceTotal: Nivel.count()]
    }

    def create() {
        [nivelInstance: new Nivel(params)]
    }

    def save() {
        def nivelInstance = new Nivel(params)



        nivelInstance.properties = params

        if(params.id) {
            nivelInstance = Nivel.get(params.id)
            nivelInstance.properties = params
        }

        if (!nivelInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [nivelInstance: nivelInstance])
            } else {
                render(view: "create", model: [nivelInstance: nivelInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Nivel actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Nivel creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: nivelInstance.id)
    }

    def show() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nivelInstance: nivelInstance]
    }

    def edit() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
            flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nivelInstance: nivelInstance]
    }

    def delete() {
        def nivelInstance = Nivel.get(params.id)
        if (!nivelInstance) {
			flash.message = "No se encontró Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            nivelInstance.delete(flush: true)
			flash.message = "Nivel  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Nivel con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
