package cratos

import org.springframework.dao.DataIntegrityViolationException

class FuenteController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fuenteInstanceList: Fuente.list(params), fuenteInstanceTotal: Fuente.count()]
    }

    def create() {
        [fuenteInstance: new Fuente(params)]
    }

    def save() {
        def fuenteInstance = new Fuente(params)

        if (params.id) {
            fuenteInstance = Fuente.get(params.id)
            fuenteInstance.properties = params
        }

        if (!fuenteInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [fuenteInstance: fuenteInstance])
            } else {
                render(view: "create", model: [fuenteInstance: fuenteInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Fuente actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Fuente creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: fuenteInstance.id)
    }

    def show() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [fuenteInstance: fuenteInstance]
    }

    def edit() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [fuenteInstance: fuenteInstance]
    }

    def delete() {
        def fuenteInstance = Fuente.get(params.id)
        if (!fuenteInstance) {
            flash.message = "No se encontró Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            fuenteInstance.delete(flush: true)
            flash.message = "Fuente  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Fuente con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
