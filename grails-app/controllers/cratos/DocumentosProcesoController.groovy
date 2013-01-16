package cratos

import org.springframework.dao.DataIntegrityViolationException

class DocumentosProcesoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [documentosProcesoInstanceList: DocumentosProceso.list(params), documentosProcesoInstanceTotal: DocumentosProceso.count()]
    }

    def create() {
        [documentosProcesoInstance: new DocumentosProceso(params)]
    }

    def save() {
        def documentosProcesoInstance
        if (params.id) {
            documentosProcesoInstance = DocumentosProceso.get(params.id)
            if (!documentosProcesoInstance) {
                flash.message = "No se encontr&oacute; DocumentosProceso a modificar"
                render "NO"
                return
            }
            documentosProcesoInstance.properties = params
        } else {
            documentosProcesoInstance = new DocumentosProceso(params)
        }
        if (!documentosProcesoInstance.save(flush: true)) {
            render "NO"
            println documentosProcesoInstance.errors
            flash.message = "Ha ocurrido un error al guardar DocumentosProceso"
            return
        }

        flash.message = "DocumentosProceso guardado exitosamente"
//    redirect(action: "show", id: documentosProcesoInstance.id)
        render "OK"
    }

    def show() {
        def documentosProcesoInstance = DocumentosProceso.get(params.id)
        if (!documentosProcesoInstance) {
            flash.message = "No se encontr&oacute; DocumentosProceso a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentosProcesoInstance: documentosProcesoInstance]
    }

    def edit() {
        def documentosProcesoInstance = DocumentosProceso.get(params.id)
        if (!documentosProcesoInstance) {
            flash.message = "No se encontr&oacute; DocumentosProceso a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [documentosProcesoInstance: documentosProcesoInstance]
    }

    def delete() {
        def documentosProcesoInstance = DocumentosProceso.get(params.id)
        if (!documentosProcesoInstance) {
            flash.message = "No se encontr&oacute; DocumentosProceso a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            documentosProcesoInstance.delete(flush: true)
            flash.message = "DocumentosProceso eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar DocumentosProceso"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
