package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [rubroInstanceList: Rubro.list(params), rubroInstanceTotal: Rubro.count()]
}

def create() {
    [rubroInstance: new Rubro(params)]
}

def save() {
    def rubroInstance
    if(params.id) {
        rubroInstance = Rubro.get(params.id)
        if(!rubroInstance) {
            flash.message = "No se encontr&oacute; Rubro a modificar"
            render "NO"
            return
        }
        rubroInstance.properties = params
    } else {
        rubroInstance = new Rubro(params)
    }
    if (!rubroInstance.save(flush: true)) {
        render "NO"
        println rubroInstance.errors
        flash.message = "Ha ocurrido un error al guardar Rubro"
        return
    }

    flash.message = "Rubro guardado exitosamente"
//    redirect(action: "show", id: rubroInstance.id)
    render "OK"
}

def show() {
    def rubroInstance = Rubro.get(params.id)
    if (!rubroInstance) {
        flash.message = "No se encontr&oacute; Rubro a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [rubroInstance: rubroInstance]
}

def edit() {
    def rubroInstance = Rubro.get(params.id)
    if (!rubroInstance) {
        flash.message = "No se encontr&oacute; Rubro a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [rubroInstance: rubroInstance]
}

def delete() {
    def rubroInstance = Rubro.get(params.id)
    if (!rubroInstance) {
        flash.message = "No se encontr&oacute; Rubro a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        rubroInstance.delete(flush: true)
        flash.message = "Rubro eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Rubro"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
