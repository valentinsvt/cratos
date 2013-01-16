package cratos

import org.springframework.dao.DataIntegrityViolationException

class UnidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [unidadInstanceList: Unidad.list(params), unidadInstanceTotal: Unidad.count()]
    }

    def create() {
        [unidadInstance: new Unidad(params)]
    }

    def save() {
        def unidadInstance = new Unidad(params)

        if(params.id) {
            unidadInstance = Unidad.get(params.id)
            unidadInstance.properties = params
        }

        if (!unidadInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [unidadInstance: unidadInstance])
            } else {
                render(view: "create", model: [unidadInstance: unidadInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "Unidad actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "Unidad creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: unidadInstance.id)
    }

    def show() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
            flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [unidadInstance: unidadInstance]
    }

    def edit() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
            flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [unidadInstance: unidadInstance]
    }

    def delete() {
        def unidadInstance = Unidad.get(params.id)
        if (!unidadInstance) {
			flash.message = "No se encontró Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            unidadInstance.delete(flush: true)
			flash.message = "Unidad  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar Unidad con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
