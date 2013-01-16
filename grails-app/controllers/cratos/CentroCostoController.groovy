package cratos

import org.springframework.dao.DataIntegrityViolationException

class CentroCostoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if (!params.sort) {
            params.sort = "nombre"
        }
        def c = CentroCosto.createCriteria()
        def centroCostoInstanceList = c.list(params) {
            eq("empresa", Empresa.get(session.empresa.id))
        }
        [centroCostoInstanceList: centroCostoInstanceList, centroCostoInstanceTotal: centroCostoInstanceList.totalCount]
    }

    def create() {
        [centroCostoInstance: new CentroCosto(params)]
    }

    def save() {
        def centroCostoInstance

//        params.empresa.id = session.empresa.id
//        params["empesa.id"] = session.empresa.id
        params.empresa = Empresa.get(session.empresa.id)

        if (params.id) {
            centroCostoInstance = CentroCosto.get(params.id)
            if (!centroCostoInstance) {
                flash.message = "No se encontr&oacute; CentroCosto a modificar"
                render "NO"
                return
            }
            centroCostoInstance.properties = params
        } else {
            centroCostoInstance = new CentroCosto(params)
        }
        if (!centroCostoInstance.save(flush: true)) {
            render "NO"
            println centroCostoInstance.errors
            flash.message = "Ha ocurrido un error al guardar CentroCosto"
            return
        }

        flash.message = "CentroCosto guardado exitosamente"
//    redirect(action: "show", id: centroCostoInstance.id)
        render "OK"
    }

    def show() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [centroCostoInstance: centroCostoInstance]
    }

    def edit() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [centroCostoInstance: centroCostoInstance]
    }

    def delete() {
        def centroCostoInstance = CentroCosto.get(params.id)
        if (!centroCostoInstance) {
            flash.message = "No se encontr&oacute; CentroCosto a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            centroCostoInstance.delete(flush: true)
            flash.message = "CentroCosto eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar CentroCosto"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
