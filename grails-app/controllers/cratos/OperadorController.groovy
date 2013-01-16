package cratos

import org.springframework.dao.DataIntegrityViolationException

class OperadorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [operadorInstanceList: Operador.list(params), operadorInstanceTotal: Operador.count()]
    }

    def create() {
        [operadorInstance: new Operador(params)]
    }

    def save() {
        def operadorInstance
        if (params.id) {
            operadorInstance = Operador.get(params.id)
            if (!operadorInstance) {
                flash.message = "No se encontr&oacute; Operador a modificar"
                render "NO"
                return
            }
            operadorInstance.properties = params
        } else {
            operadorInstance = new Operador(params)
        }
        if (!operadorInstance.save(flush: true)) {
            render "NO"
            println operadorInstance.errors
            flash.message = "Ha ocurrido un error al guardar Operador"
            return
        }

        flash.message = "Operador guardado exitosamente"
//    redirect(action: "show", id: operadorInstance.id)
        render "OK"
    }

    def show() {
        def operadorInstance = Operador.get(params.id)
        if (!operadorInstance) {
            flash.message = "No se encontr&oacute; Operador a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [operadorInstance: operadorInstance]
    }

    def edit() {
        def operadorInstance = Operador.get(params.id)
        if (!operadorInstance) {
            flash.message = "No se encontr&oacute; Operador a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [operadorInstance: operadorInstance]
    }

    def delete() {
        def operadorInstance = Operador.get(params.id)
        if (!operadorInstance) {
            flash.message = "No se encontr&oacute; Operador a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            operadorInstance.delete(flush: true)
            flash.message = "Operador eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Operador"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
