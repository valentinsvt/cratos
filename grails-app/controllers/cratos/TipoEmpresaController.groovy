package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoEmpresaController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoEmpresaInstanceList: TipoEmpresa.list(params), tipoEmpresaInstanceTotal: TipoEmpresa.count()]
    }

    def create() {
        [tipoEmpresaInstance: new TipoEmpresa(params)]
    }

    def save() {
        def tipoEmpresaInstance = new TipoEmpresa(params)

        if(params.id) {
            tipoEmpresaInstance = TipoEmpresa.get(params.id)
            tipoEmpresaInstance.properties = params
        }

        if (!tipoEmpresaInstance.save(flush: true)) {
            if(params.id) {
                render(view: "edit", model: [tipoEmpresaInstance: tipoEmpresaInstance])
            } else {
                render(view: "create", model: [tipoEmpresaInstance: tipoEmpresaInstance])
            }
            return
        }

        if(params.id) {
            flash.message = "TipoEmpresa actualizado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        } else {
		    flash.message = "TipoEmpresa creado"
            flash.clase = "success"
            flash.ico ="ss_accept"
        }
        redirect(action: "show", id: tipoEmpresaInstance.id)
    }

    def show() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
            flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoEmpresaInstance: tipoEmpresaInstance]
    }

    def edit() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
            flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        [tipoEmpresaInstance: tipoEmpresaInstance]
    }

    def delete() {
        def tipoEmpresaInstance = TipoEmpresa.get(params.id)
        if (!tipoEmpresaInstance) {
			flash.message = "No se encontró TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "list")
            return
        }

        try {
            tipoEmpresaInstance.delete(flush: true)
			flash.message = "TipoEmpresa  con id "+params.id+" eliminado"
            flash.clase = "success"
            flash.ico ="ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = "No se pudo eliminar TipoEmpresa con id "+params.id
            flash.clase = "error"
            flash.ico ="ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
