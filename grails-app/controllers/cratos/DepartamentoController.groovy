package cratos

import org.springframework.dao.DataIntegrityViolationException

class DepartamentoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [departamentoInstanceList: Departamento.list(params), departamentoInstanceTotal: Departamento.count()]
    }

    def create() {
        [departamentoInstance: new Departamento(params)]
    }

    def save() {
        def departamentoInstance = new Departamento(params)


        println("departamento" + params)


        departamentoInstance.properties = params
        departamentoInstance.empresa = session.empresa


        if (params.id) {
            departamentoInstance = Departamento.get(params.id)
            departamentoInstance.properties = params
        }

        if (!departamentoInstance.save(flush: true)) {

            println(departamentoInstance.errors)

            if (params.id) {
                render(view: "edit", model: [departamentoInstance: departamentoInstance])
            } else {
                render(view: "create", model: [departamentoInstance: departamentoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Departamento actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Departamento creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: departamentoInstance.id)
    }

    def show() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [departamentoInstance: departamentoInstance]
    }

    def edit() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [departamentoInstance: departamentoInstance]
    }

    def delete() {
        def departamentoInstance = Departamento.get(params.id)
        if (!departamentoInstance) {
            flash.message = "No se encontró Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            departamentoInstance.delete(flush: true)
            flash.message = "Departamento  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Departamento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
