package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoPersonaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoPersonaInstanceList: TipoPersona.list(params), tipoPersonaInstanceTotal: TipoPersona.count()]
    }

    def create() {
        [tipoPersonaInstance: new TipoPersona(params)]
    }

    def save() {
        def tipoPersonaInstance = new TipoPersona(params)

        if (params.id) {
            tipoPersonaInstance = TipoPersona.get(params.id)
            tipoPersonaInstance.properties = params
        }

        if (!tipoPersonaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoPersonaInstance: tipoPersonaInstance])
            } else {
                render(view: "create", model: [tipoPersonaInstance: tipoPersonaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoPersona actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoPersona creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoPersonaInstance.id)
    }

    def show() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPersonaInstance: tipoPersonaInstance]
    }

    def edit() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoPersonaInstance: tipoPersonaInstance]
    }

    def delete() {
        def tipoPersonaInstance = TipoPersona.get(params.id)
        if (!tipoPersonaInstance) {
            flash.message = "No se encontró TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoPersonaInstance.delete(flush: true)
            flash.message = "TipoPersona  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoPersona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
