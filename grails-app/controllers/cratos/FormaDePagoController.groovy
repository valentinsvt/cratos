package cratos

import org.springframework.dao.DataIntegrityViolationException

class FormaDePagoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [formaDePagoInstanceList: FormaDePago.list(params), formaDePagoInstanceTotal: FormaDePago.count()]
    }

    def create() {
        [formaDePagoInstance: new FormaDePago(params)]
    }

    def save() {
        def formaDePagoInstance
        if (params.id) {
            formaDePagoInstance = FormaDePago.get(params.id)
            if (!formaDePagoInstance) {
                flash.message = "No se encontr&oacute; FormaDePago a modificar"
                render "NO"
                return
            }
            formaDePagoInstance.properties = params
        } else {
            formaDePagoInstance = new FormaDePago(params)
        }
        if (!formaDePagoInstance.save(flush: true)) {
            render "NO"
            println formaDePagoInstance.errors
            flash.message = "Ha ocurrido un error al guardar FormaDePago"
            return
        }

        flash.message = "FormaDePago guardado exitosamente"
//    redirect(action: "show", id: formaDePagoInstance.id)
        render "OK"
    }

    def show() {
        def formaDePagoInstance = FormaDePago.get(params.id)
        if (!formaDePagoInstance) {
            flash.message = "No se encontr&oacute; FormaDePago a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [formaDePagoInstance: formaDePagoInstance]
    }

    def edit() {
        def formaDePagoInstance = FormaDePago.get(params.id)
        if (!formaDePagoInstance) {
            flash.message = "No se encontr&oacute; FormaDePago a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [formaDePagoInstance: formaDePagoInstance]
    }

    def delete() {
        def formaDePagoInstance = FormaDePago.get(params.id)
        if (!formaDePagoInstance) {
            flash.message = "No se encontr&oacute; FormaDePago a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            formaDePagoInstance.delete(flush: true)
            flash.message = "FormaDePago eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar FormaDePago"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
