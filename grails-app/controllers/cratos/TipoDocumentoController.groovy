package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoDocumentoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoDocumentoInstanceList: TipoDocumento.list(params), tipoDocumentoInstanceTotal: TipoDocumento.count()]
    }

    def create() {
        [tipoDocumentoInstance: new TipoDocumento(params)]
    }

    def save() {
        def tipoDocumentoInstance = new TipoDocumento(params)

        if (params.id) {
            tipoDocumentoInstance = TipoDocumento.get(params.id)
            tipoDocumentoInstance.properties = params
        }

        if (!tipoDocumentoInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [tipoDocumentoInstance: tipoDocumentoInstance])
            } else {
                render(view: "create", model: [tipoDocumentoInstance: tipoDocumentoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "TipoDocumento actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "TipoDocumento creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: tipoDocumentoInstance.id)
    }

    def show() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoInstance: tipoDocumentoInstance]
    }

    def edit() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [tipoDocumentoInstance: tipoDocumentoInstance]
    }

    def delete() {
        def tipoDocumentoInstance = TipoDocumento.get(params.id)
        if (!tipoDocumentoInstance) {
            flash.message = "No se encontró TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoDocumentoInstance.delete(flush: true)
            flash.message = "TipoDocumento  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar TipoDocumento con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
