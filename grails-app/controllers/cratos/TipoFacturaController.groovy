package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoFacturaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoFacturaInstanceList: TipoFactura.list(params), tipoFacturaInstanceTotal: TipoFactura.count()]
    }

    def create() {
        [tipoFacturaInstance: new TipoFactura(params)]
    }

    def save() {
        def tipoFacturaInstance
        if (params.id) {
            tipoFacturaInstance = TipoFactura.get(params.id)
            if (!tipoFacturaInstance) {
                flash.message = "No se encontr&oacute; TipoFactura a modificar"
                render "NO"
                return
            }
            tipoFacturaInstance.properties = params
        } else {
            tipoFacturaInstance = new TipoFactura(params)
        }
        if (!tipoFacturaInstance.save(flush: true)) {
            render "NO"
            println tipoFacturaInstance.errors
            flash.message = "Ha ocurrido un error al guardar TipoFactura"
            return
        }

        flash.message = "TipoFactura guardado exitosamente"
//    redirect(action: "show", id: tipoFacturaInstance.id)
        render "OK"
    }

    def show() {
        def tipoFacturaInstance = TipoFactura.get(params.id)
        if (!tipoFacturaInstance) {
            flash.message = "No se encontr&oacute; TipoFactura a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoFacturaInstance: tipoFacturaInstance]
    }

    def edit() {
        def tipoFacturaInstance = TipoFactura.get(params.id)
        if (!tipoFacturaInstance) {
            flash.message = "No se encontr&oacute; TipoFactura a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [tipoFacturaInstance: tipoFacturaInstance]
    }

    def delete() {
        def tipoFacturaInstance = TipoFactura.get(params.id)
        if (!tipoFacturaInstance) {
            flash.message = "No se encontr&oacute; TipoFactura a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            tipoFacturaInstance.delete(flush: true)
            flash.message = "TipoFactura eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar TipoFactura"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
