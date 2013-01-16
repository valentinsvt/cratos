package cratos

import org.springframework.dao.DataIntegrityViolationException

class GrupoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [grupoInstanceList: Grupo.list(params), grupoInstanceTotal: Grupo.count()]
    }

    def create() {
        [grupoInstance: new Grupo(params)]
    }

    def save() {
        def grupoInstance
        if (params.id) {
            grupoInstance = Grupo.get(params.id)
            if (!grupoInstance) {
                flash.message = "No se encontr&oacute; Grupo a modificar"
                render "NO"
                return
            }
            grupoInstance.properties = params
        } else {
            grupoInstance = new Grupo(params)
        }
        if (!grupoInstance.save(flush: true)) {
            render "NO"
            println grupoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Grupo"
            return
        }

        flash.message = "Grupo guardado exitosamente"
//    redirect(action: "show", id: grupoInstance.id)
        render "OK"
    }

    def show() {
        def grupoInstance = Grupo.get(params.id)
        if (!grupoInstance) {
            flash.message = "No se encontr&oacute; Grupo a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [grupoInstance: grupoInstance]
    }

    def edit() {
        def grupoInstance = Grupo.get(params.id)
        if (!grupoInstance) {
            flash.message = "No se encontr&oacute; Grupo a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [grupoInstance: grupoInstance]
    }

    def delete() {
        def grupoInstance = Grupo.get(params.id)
        if (!grupoInstance) {
            flash.message = "No se encontr&oacute; Grupo a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            grupoInstance.delete(flush: true)
            flash.message = "Grupo eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Grupo"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
