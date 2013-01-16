package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoTarjetaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoTarjetaInstanceList: TipoTarjeta.list(params), tipoTarjetaInstanceTotal: TipoTarjeta.count()]
    }

    def create() {
        [tipoTarjetaInstance: new TipoTarjeta(params)]
    }

    def save() {
        def tipoTarjetaInstance
        if (params.id) {
            tipoTarjetaInstance = TipoTarjeta.get(params.id)
            if (!tipoTarjetaInstance) {
                flash.message = "No se encontr&oacute; TipoTarjeta a modificar"
                render "NO"
                return
            }
            tipoTarjetaInstance.properties = params
        } else {
            tipoTarjetaInstance = new TipoTarjeta(params)
        }
        if (!tipoTarjetaInstance.save(flush: true)) {
            render "NO"
            println tipoTarjetaInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoTarjeta"
            return
        }

        flash.message = "TipoTarjeta guardado exitosamente"
//    redirect(action: "show", id: tipoTarjetaInstance.id)
        render "OK"
    }

    def show() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoTarjetaInstance: tipoTarjetaInstance]
    }

    def edit() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoTarjetaInstance: tipoTarjetaInstance]
    }

    def delete() {
        def tipoTarjetaInstance = TipoTarjeta.get(params.id)
        if (!tipoTarjetaInstance) {
            flash.message = "No se encontr&oacute; TipoTarjeta a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoTarjetaInstance.delete(flush: true)
            flash.message = "TipoTarjeta eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoTarjeta"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
