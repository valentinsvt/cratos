package cratos

import org.springframework.dao.DataIntegrityViolationException

class SustentoTributarioController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [sustentoTributarioInstanceList: SustentoTributario.list(params), sustentoTributarioInstanceTotal: SustentoTributario.count()]
    }

    def create() {
        [sustentoTributarioInstance: new SustentoTributario(params)]
    }

    def save() {
        def sustentoTributarioInstance
        if (params.id) {
            sustentoTributarioInstance = SustentoTributario.get(params.id)
            if (!sustentoTributarioInstance) {
                flash.message = "No se encontr&oacute; SustentoTributario a modificar"
                render "NO"
                return
            }
            sustentoTributarioInstance.properties = params
        } else {
            sustentoTributarioInstance = new SustentoTributario(params)
        }
        if (!sustentoTributarioInstance.save(flush: true)) {
            render "NO"
            println sustentoTributarioInstance.errors
            flash.message = "Ha ocurrido un error al guardar SustentoTributario"
            return
        }

        flash.message = "SustentoTributario guardado exitosamente"
//    redirect(action: "show", id: sustentoTributarioInstance.id)
        render "OK"
    }

    def show() {
        def sustentoTributarioInstance = SustentoTributario.get(params.id)
        if (!sustentoTributarioInstance) {
            flash.message = "No se encontr&oacute; SustentoTributario a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [sustentoTributarioInstance: sustentoTributarioInstance]
    }

    def edit() {
        def sustentoTributarioInstance = SustentoTributario.get(params.id)
        if (!sustentoTributarioInstance) {
            flash.message = "No se encontr&oacute; SustentoTributario a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [sustentoTributarioInstance: sustentoTributarioInstance]
    }

    def delete() {
        def sustentoTributarioInstance = SustentoTributario.get(params.id)
        if (!sustentoTributarioInstance) {
            flash.message = "No se encontr&oacute; SustentoTributario a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            sustentoTributarioInstance.delete(flush: true)
            flash.message = "SustentoTributario eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar SustentoTributario"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
