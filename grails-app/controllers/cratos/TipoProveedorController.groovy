package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoProveedorController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoProveedorInstanceList: TipoProveedor.list(params), tipoProveedorInstanceTotal: TipoProveedor.count()]
    }

    def create() {
        [tipoProveedorInstance: new TipoProveedor(params)]
    }

    def save() {
        def tipoProveedorInstance = new TipoProveedor(params)

        if (params.id) {
            tipoProveedorInstance = TipoProveedor.get(params.id)
            tipoProveedorInstance.properties = params
        }

        if (!tipoProveedorInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoProveedorInstance: tipoProveedorInstance])
            } else {
                render(view: "create", model: [tipoProveedorInstance: tipoProveedorInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoProveedor actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoProveedor creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoProveedorInstance.id)
    }

    def show() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoProveedorInstance: tipoProveedorInstance]
    }

    def edit() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoProveedorInstance: tipoProveedorInstance]
    }

    def delete() {
        def tipoProveedorInstance = TipoProveedor.get(params.id)
        if (!tipoProveedorInstance) {
            flash.message = "No se encontró TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoProveedorInstance.delete(flush: true)
            flash.message = "TipoProveedor  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
