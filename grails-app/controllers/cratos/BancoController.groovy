package cratos

import org.springframework.dao.DataIntegrityViolationException

class BancoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bancoInstanceList: Banco.list(params), bancoInstanceTotal: Banco.count()]
    }

    def create() {
        [bancoInstance: new Banco(params)]
    }

    def save() {
        def bancoInstance = new Banco(params)

        if (params.id) {
            bancoInstance = Banco.get(params.id)
            if (!bancoInstance) {
                flash.message = "No se encontr&oacute; Banco a modificar"
                render "NO"
                return
            }
            bancoInstance.properties = params
        } else {
            bancoInstance = new Banco(params)
        }
        bancoInstance.empresa = Empresa.get(session.empresa.id)
        if (!bancoInstance.save(flush: true)) {
            render "NO"
            println bancoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Banco"
            return
        }

        flash.message = "Banco guardado exitosamente"
//    redirect(action: "show", id: bancoInstance.id)
        render "OK"
    }

    def show() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [bancoInstance: bancoInstance]
    }

    def edit() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [bancoInstance: bancoInstance]
    }

    def delete() {
        def bancoInstance = Banco.get(params.id)
        if (!bancoInstance) {
            flash.message = "No se encontr&oacute; Banco a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            bancoInstance.delete(flush: true)
            flash.message = "Banco eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Banco"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
