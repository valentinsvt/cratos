package cratos

import org.springframework.dao.DataIntegrityViolationException

class FechaSriController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [fechaSriInstanceList: FechaSri.list(params), fechaSriInstanceTotal: FechaSri.count()]
    }

    def create() {
        [fechaSriInstance: new FechaSri(params)]
    }

    def save() {
        def fechaSriInstance
        if (params.id) {
            fechaSriInstance = FechaSri.get(params.id)
            if (!fechaSriInstance) {
                flash.message = "No se encontr&oacute; FechaSri a modificar"
                render "NO"
                return
            }
            fechaSriInstance.properties = params
        } else {
            fechaSriInstance = new FechaSri(params)
        }
        if (!fechaSriInstance.save(flush: true)) {
            render "NO"
            println fechaSriInstance.errors
            flash.message = "Ha ocurrido un error al guardar FechaSri"
            return
        }

        flash.message = "FechaSri guardado exitosamente"
//    redirect(action: "show", id: fechaSriInstance.id)
        render "OK"
    }

    def show() {
        def fechaSriInstance = FechaSri.get(params.id)
        if (!fechaSriInstance) {
            flash.message = "No se encontr&oacute; FechaSri a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [fechaSriInstance: fechaSriInstance]
    }

    def edit() {
        def fechaSriInstance = FechaSri.get(params.id)
        if (!fechaSriInstance) {
            flash.message = "No se encontr&oacute; FechaSri a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [fechaSriInstance: fechaSriInstance]
    }

    def delete() {
        def fechaSriInstance = FechaSri.get(params.id)
        if (!fechaSriInstance) {
            flash.message = "No se encontr&oacute; FechaSri a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            fechaSriInstance.delete(flush: true)
            flash.message = "FechaSri eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar FechaSri"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
