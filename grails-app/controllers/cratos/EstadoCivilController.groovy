package cratos

import org.springframework.dao.DataIntegrityViolationException

class EstadoCivilController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [estadoCivilInstanceList: EstadoCivil.list(params), estadoCivilInstanceTotal: EstadoCivil.count()]
    }

    def create() {
        [estadoCivilInstance: new EstadoCivil(params)]
    }

    def save() {
        def estadoCivilInstance = new EstadoCivil(params)

        if (params.id) {
            estadoCivilInstance = EstadoCivil.get(params.id)
            estadoCivilInstance.properties = params
        }

        if (!estadoCivilInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [estadoCivilInstance: estadoCivilInstance])
            } else {
                render(view: "create", model: [estadoCivilInstance: estadoCivilInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "EstadoCivil actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "EstadoCivil creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: estadoCivilInstance.id)
    }

    def show() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [estadoCivilInstance: estadoCivilInstance]
    }

    def edit() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [estadoCivilInstance: estadoCivilInstance]
    }

    def delete() {
        def estadoCivilInstance = EstadoCivil.get(params.id)
        if (!estadoCivilInstance) {
            flash.message = "No se encontró EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            estadoCivilInstance.delete(flush: true)
            flash.message = "EstadoCivil  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar EstadoCivil con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
