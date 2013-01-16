package cratos

import org.springframework.dao.DataIntegrityViolationException

class MarcaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [marcaInstanceList: Marca.list(params), marcaInstanceTotal: Marca.count()]
    }

    def create() {
        [marcaInstance: new Marca(params)]
    }

    def save() {
        def marcaInstance = new Marca(params)

        if (params.id) {
            marcaInstance = Marca.get(params.id)
            marcaInstance.properties = params
        }

        if (!marcaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [marcaInstance: marcaInstance])
            } else {
                render(view: "create", model: [marcaInstance: marcaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Marca actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Marca creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: marcaInstance.id)
    }

    def show() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [marcaInstance: marcaInstance]
    }

    def edit() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [marcaInstance: marcaInstance]
    }

    def delete() {
        def marcaInstance = Marca.get(params.id)
        if (!marcaInstance) {
            flash.message = "No se encontró Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            marcaInstance.delete(flush: true)
            flash.message = "Marca  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Marca con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
