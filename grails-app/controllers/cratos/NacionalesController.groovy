package cratos

import org.springframework.dao.DataIntegrityViolationException

class NacionalesController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [nacionalesInstanceList: Nacionales.list(params), nacionalesInstanceTotal: Nacionales.count()]
    }

    def create() {
        [nacionalesInstance: new Nacionales(params)]
    }

    def save() {
        def nacionalesInstance
        if (params.id) {
            nacionalesInstance = Nacionales.get(params.id)
            if (!nacionalesInstance) {
                flash.message = "No se encontr&oacute; Nacionales a modificar"
                render "NO"
                return
            }
            nacionalesInstance.properties = params
        } else {
            nacionalesInstance = new Nacionales(params)
        }
        if (!nacionalesInstance.save(flush: true)) {
            render "NO"
            println nacionalesInstance.errors
            flash.message = "Ha ocurrido un error al guardar Nacionales"
            return
        }

        flash.message = "Nacionales guardado exitosamente"
//    redirect(action: "show", id: nacionalesInstance.id)
        render "OK"
    }

    def show() {
        def nacionalesInstance = Nacionales.get(params.id)
        if (!nacionalesInstance) {
            flash.message = "No se encontr&oacute; Nacionales a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [nacionalesInstance: nacionalesInstance]
    }

    def edit() {
        def nacionalesInstance = Nacionales.get(params.id)
        if (!nacionalesInstance) {
            flash.message = "No se encontr&oacute; Nacionales a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [nacionalesInstance: nacionalesInstance]
    }

    def delete() {
        def nacionalesInstance = Nacionales.get(params.id)
        if (!nacionalesInstance) {
            flash.message = "No se encontr&oacute; Nacionales a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            nacionalesInstance.delete(flush: true)
            flash.message = "Nacionales eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Nacionales"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
