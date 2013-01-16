package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentosProveedorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [documentosProveedorInstanceList: DocumentosProveedor.list(params), documentosProveedorInstanceTotal: DocumentosProveedor.count()]
    }

    def create() {
        [documentosProveedorInstance: new DocumentosProveedor(params)]
    }

    def save() {
        def documentosProveedorInstance
        if (params.id) {
            documentosProveedorInstance = DocumentosProveedor.get(params.id)
            if (!documentosProveedorInstance) {
                flash.message = "No se encontr&oacute; DocumentosProveedor a modificar"
                render "NO"
                return
            }
            documentosProveedorInstance.properties = params
        } else {
            documentosProveedorInstance = new DocumentosProveedor(params)
        }
        if (!documentosProveedorInstance.save(flush: true)) {
            render "NO"
            println documentosProveedorInstance.errors
            flash.message = "Ha ocurrido un error al guardar DocumentosProveedor"
            return
        }

        flash.message = "DocumentosProveedor guardado exitosamente"
//    redirect(action: "show", id: documentosProveedorInstance.id)
        render "OK"
    }

    def show() {
        def documentosProveedorInstance = DocumentosProveedor.get(params.id)
        if (!documentosProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentosProveedor a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentosProveedorInstance: documentosProveedorInstance]
    }

    def edit() {
        def documentosProveedorInstance = DocumentosProveedor.get(params.id)
        if (!documentosProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentosProveedor a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentosProveedorInstance: documentosProveedorInstance]
    }

    def delete() {
        def documentosProveedorInstance = DocumentosProveedor.get(params.id)
        if (!documentosProveedorInstance) {
            flash.message = "No se encontr&oacute; DocumentosProveedor a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            documentosProveedorInstance.delete(flush: true)
            flash.message = "DocumentosProveedor eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar DocumentosProveedor"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
