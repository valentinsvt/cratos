package cratos

import org.springframework.dao.DataIntegrityViolationException

class PersonaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [personaInstanceList: Persona.list(params), personaInstanceTotal: Persona.count()]
    }

    def create() {
        [personaInstance: new Persona(params)]
    }

    def save() {
        if (params.fechaNacimiento) {
            params.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.fechaNacimiento)
        }

        def personaInstance = new Persona(params)

        if (params.id) {
            personaInstance = Persona.get(params.id)
            personaInstance.properties = params
        }

        if (!personaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [personaInstance: personaInstance])
            } else {
                render(view: "create", model: [personaInstance: personaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Persona actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Persona creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: personaInstance.id)
    }

    def show() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.message = "No se encontró Persona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }

    def edit() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.message = "No se encontró Persona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }

    def delete() {
        def personaInstance = Persona.get(params.id)
        if (!personaInstance) {
            flash.message = "No se encontró Persona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            personaInstance.delete(flush: true)
            flash.message = "Persona  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Persona con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
