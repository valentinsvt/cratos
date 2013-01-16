package cratos

import org.springframework.dao.DataIntegrityViolationException

class NacionalidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [nacionalidadInstanceList: Nacionalidad.list(params), nacionalidadInstanceTotal: Nacionalidad.count()]
    }

    def create() {
        [nacionalidadInstance: new Nacionalidad(params)]
    }

    def save() {
        def nacionalidadInstance = new Nacionalidad(params)

        if(params.id) {
            nacionalidadInstance = Nacionalidad.get(params.id)
            nacionalidadInstance.properties = params
        }

        if (!nacionalidadInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [nacionalidadInstance: nacionalidadInstance])
            } else {
                render(view: "create", model: [nacionalidadInstance: nacionalidadInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Nacionalidad actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Nacionalidad creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: nacionalidadInstance.id)
    }

    def show() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
            flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nacionalidadInstance: nacionalidadInstance]
    }

    def edit() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
            flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [nacionalidadInstance: nacionalidadInstance]
    }

    def delete() {
        def nacionalidadInstance = Nacionalidad.get(params.id)
        if (!nacionalidadInstance) {
			flash.message = "No se encontró Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            nacionalidadInstance.delete(flush: true)
			flash.message = "Nacionalidad  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Nacionalidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
