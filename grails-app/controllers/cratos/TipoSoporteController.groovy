package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoSoporteController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoSoporteInstanceList: TipoSoporte.list(params), tipoSoporteInstanceTotal: TipoSoporte.count()]
    }

    def create() {
        [tipoSoporteInstance: new TipoSoporte(params)]
    }

    def save() {
        def tipoSoporteInstance
        if (params.id) {
            tipoSoporteInstance = TipoSoporte.get(params.id)
            if (!tipoSoporteInstance) {
                flash.message = "No se encontr&oacute; TipoSoporte a modificar"
                render "NO"
                return
            }
            tipoSoporteInstance.properties = params
        } else {
            tipoSoporteInstance = new TipoSoporte(params)
        }
        if (!tipoSoporteInstance.save(flush: true)) {
            render "NO"
            println tipoSoporteInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoSoporte"
            return
        }

        flash.message = "TipoSoporte guardado exitosamente"
//    redirect(action: "show", id: tipoSoporteInstance.id)
        render "OK"
    }

    def show() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoSoporteInstance: tipoSoporteInstance]
    }

    def edit() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoSoporteInstance: tipoSoporteInstance]
    }

    def delete() {
        def tipoSoporteInstance = TipoSoporte.get(params.id)
        if (!tipoSoporteInstance) {
            flash.message = "No se encontr&oacute; TipoSoporte a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoSoporteInstance.delete(flush: true)
            flash.message = "TipoSoporte eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoSoporte"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
