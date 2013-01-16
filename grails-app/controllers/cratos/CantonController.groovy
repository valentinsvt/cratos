package cratos

import org.springframework.dao.DataIntegrityViolationException

class CantonController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cantonInstanceList: Canton.list(params), cantonInstanceTotal: Canton.count()]
    }

    def create() {
        [cantonInstance: new Canton(params)]
    }

    def save() {
        def cantonInstance = new Canton(params)

        if (params.id) {
            cantonInstance = Canton.get(params.id)
            cantonInstance.properties = params
        }

        if (!cantonInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [cantonInstance: cantonInstance])
            } else {
                render(view: "create", model: [cantonInstance: cantonInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Canton actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Canton creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: cantonInstance.id)
    }

    def show() {
        def cantonInstance = Canton.get(params.id)
        if (!cantonInstance) {
            flash.message = "No se encontró Canton con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [cantonInstance: cantonInstance]
    }

    def edit() {
        def cantonInstance = Canton.get(params.id)
        if (!cantonInstance) {
            flash.message = "No se encontró Canton con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [cantonInstance: cantonInstance]
    }

    def delete() {
        def cantonInstance = Canton.get(params.id)
        if (!cantonInstance) {
            flash.message = "No se encontró Canton con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            cantonInstance.delete(flush: true)
            flash.message = "Canton  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Canton con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
