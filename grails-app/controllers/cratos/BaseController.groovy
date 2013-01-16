package cratos

import org.springframework.dao.DataIntegrityViolationException

class BaseController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [baseInstanceList: Base.list(params), baseInstanceTotal: Base.count()]
}

def create() {
    [baseInstance: new Base(params)]
}

def save() {
    def baseInstance
    if(params.id) {
        baseInstance = Base.get(params.id)
        if(!baseInstance) {
            flash.message = "No se encontr&oacute; Base a modificar"
            render "NO"
            return
        }
        baseInstance.properties = params
    } else {
        baseInstance = new Base(params)
    }
    if (!baseInstance.save(flush: true)) {
        render "NO"
        println baseInstance.errors
        flash.message = "Ha ocurrido un error al guardar Base"
        return
    }

    flash.message = "Base guardado exitosamente"
//    redirect(action: "show", id: baseInstance.id)
    render "OK"
}

def show() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [baseInstance: baseInstance]
}

def edit() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [baseInstance: baseInstance]
}

def delete() {
    def baseInstance = Base.get(params.id)
    if (!baseInstance) {
        flash.message = "No se encontr&oacute; Base a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        baseInstance.delete(flush: true)
        flash.message = "Base eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Base"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
