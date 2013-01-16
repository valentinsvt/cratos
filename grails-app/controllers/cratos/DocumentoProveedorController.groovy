package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentoProveedorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [documentoProveedorInstanceList: DocumentoProveedor.list(params), documentoProveedorInstanceTotal: DocumentoProveedor.count()]
    }

    def create() {
        [documentoProveedorInstance: new DocumentoProveedor(params)]
    }

    def save() {
        def documentoProveedorInstance
        if (params.id) {
            documentoProveedorInstance = DocumentoProveedor.get(params.id)
            if (!documentoProveedorInstance) {
                flash.message = "No se encontr&oacute; DocumentoProveedor a modificar"
                render "NO"
                return
            }
            documentoProveedorInstance.properties = params
        } else {
            documentoProveedorInstance = new DocumentoProveedor(params)
        }
        if (!documentoProveedorInstance.save(flush: true)) {
            render "NO"
            println documentoProveedorInstance.errors
            flash.message = "Ha ocurrido un error al guardar DocumentoProveedor"
            return
        }

        flash.message = "DocumentoProveedor guardado exitosamente"
//    redirect(action: "show", id: documentoProveedorInstance.id)
        render "OK"
    }

    def show() {
        def documentoProveedorInstance = DocumentoProveedor.get(params.id)
        if (!documentoProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentoProveedor a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentoProveedorInstance: documentoProveedorInstance]
    }

    def edit() {
        def documentoProveedorInstance = DocumentoProveedor.get(params.id)
        if (!documentoProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentoProveedor a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentoProveedorInstance: documentoProveedorInstance]
    }

    def delete() {
        def documentoProveedorInstance = DocumentoProveedor.get(params.id)
        if (!documentoProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentoProveedor a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            documentoProveedorInstance.delete(flush: true)
            flash.message = "DocumentoProveedor eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar DocumentoProveedor"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
