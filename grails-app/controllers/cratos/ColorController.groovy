package cratos

import org.springframework.dao.DataIntegrityViolationException

class ColorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [colorInstanceList: Color.list(params), colorInstanceTotal: Color.count()]
    }

    def create() {
        [colorInstance: new Color(params)]
    }

    def save() {
        def colorInstance
        if (params.id) {
            colorInstance = Color.get(params.id)
            if (!colorInstance) {
                flash.message = "No se encontr&oacute; Color a modificar"
                render "NO"
                return
            }
            colorInstance.properties = params
        } else {
            colorInstance = new Color(params)
        }
        if (!colorInstance.save(flush: true)) {
            render "NO"
            println colorInstance.errors
            flash.message = "Ha ocurrido un error al guardar Color"
            return
        }

        flash.message = "Color guardado exitosamente"
//    redirect(action: "show", id: colorInstance.id)
        render "OK"
    }

    def show() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [colorInstance: colorInstance]
    }

    def edit() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [colorInstance: colorInstance]
    }

    def delete() {
        def colorInstance = Color.get(params.id)
        if (!colorInstance) {
            flash.message = "No se encontr&oacute; Color a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            colorInstance.delete(flush: true)
            flash.message = "Color eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Color"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
