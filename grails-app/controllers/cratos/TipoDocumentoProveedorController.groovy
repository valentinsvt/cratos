package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoDocumentoProveedorController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoDocumentoProveedorInstanceList: TipoDocumentoProveedor.list(params), tipoDocumentoProveedorInstanceTotal: TipoDocumentoProveedor.count()]
    }

    def create() {
        [tipoDocumentoProveedorInstance: new TipoDocumentoProveedor(params)]
    }

    def save() {
        def tipoDocumentoProveedorInstance = new TipoDocumentoProveedor(params)

        if (params.id) {
            tipoDocumentoProveedorInstance = TipoDocumentoProveedor.get(params.id)
            tipoDocumentoProveedorInstance.properties = params
        }

        if (!tipoDocumentoProveedorInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoDocumentoProveedorInstance: tipoDocumentoProveedorInstance])
            } else {
                render(view: "create", model: [tipoDocumentoProveedorInstance: tipoDocumentoProveedorInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoDocumentoProveedor actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoDocumentoProveedor creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoDocumentoProveedorInstance.id)
    }

    def show() {
        def tipoDocumentoProveedorInstance = TipoDocumentoProveedor.get(params.id)
        if (!tipoDocumentoProveedorInstance) {
            flash.message = "No se encontró TipoDocumentoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoProveedorInstance: tipoDocumentoProveedorInstance]
    }

    def edit() {
        def tipoDocumentoProveedorInstance = TipoDocumentoProveedor.get(params.id)
        if (!tipoDocumentoProveedorInstance) {
            flash.message = "No se encontró TipoDocumentoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoProveedorInstance: tipoDocumentoProveedorInstance]
    }

    def delete() {
        def tipoDocumentoProveedorInstance = TipoDocumentoProveedor.get(params.id)
        if (!tipoDocumentoProveedorInstance) {
            flash.message = "No se encontró TipoDocumentoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoDocumentoProveedorInstance.delete(flush: true)
            flash.message = "TipoDocumentoProveedor  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoDocumentoProveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
