package cratos

import org.springframework.dao.DataIntegrityViolationException

class DetalleAdquisicionController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [detalleAdquisicionInstanceList: DetalleAdquisicion.list(params), detalleAdquisicionInstanceTotal: DetalleAdquisicion.count()]
    }

    def create() {
        [detalleAdquisicionInstance: new DetalleAdquisicion(params)]
    }

    def save() {
        def detalleAdquisicionInstance = new DetalleAdquisicion(params)


//        detalleAdquisicionInstance.adquisiciones.id = new Adquisiciones().getId();
        def a  = new Adquisiciones().getId();

        println("a:" + a)

        println("detalle" + params)

        detalleAdquisicionInstance.properties = params

////
//            detalleAdquisicionInstance.estado = '0';


        if (!detalleAdquisicionInstance.save(flush: true)) {

            if (params.id) {
                render(view: "edit", model: [detalleAdquisicionInstance: detalleAdquisicionInstance])
            } else {
                render(view: "create", model: [detalleAdquisicionInstance: detalleAdquisicionInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "DetalleAdquisicion actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "DetalleAdquisicion creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }

        detalleAdquisicionInstance.adquisiciones.id = Adquisiciones.idAdquisiciones
//        println(detalleAdquisicionInstance.adquisiciones.id)
        redirect(action: "show", id: detalleAdquisicionInstance.id)
    }

    def show() {
        def detalleAdquisicionInstance = DetalleAdquisicion.get(params.id)
        if (!detalleAdquisicionInstance) {
            flash.message = "No se encontró DetalleAdquisicion con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [detalleAdquisicionInstance: detalleAdquisicionInstance]
    }

    def edit() {
        def detalleAdquisicionInstance = DetalleAdquisicion.get(params.id)
        if (!detalleAdquisicionInstance) {
            flash.message = "No se encontró DetalleAdquisicion con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [detalleAdquisicionInstance: detalleAdquisicionInstance]
    }

    def delete() {
        def detalleAdquisicionInstance = DetalleAdquisicion.get(params.id)
        if (!detalleAdquisicionInstance) {
            flash.message = "No se encontró DetalleAdquisicion con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            detalleAdquisicionInstance.delete(flush: true)
            flash.message = "DetalleAdquisicion  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar DetalleAdquisicion con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
