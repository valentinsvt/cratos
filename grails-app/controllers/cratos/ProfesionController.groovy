package cratos

import org.springframework.dao.DataIntegrityViolationException

class ProfesionController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [profesionInstanceList: Profesion.list(params), profesionInstanceTotal: Profesion.count()]
}

def create() {
    [profesionInstance: new Profesion(params)]
}

def save() {
    def profesionInstance
    if(params.id) {
        profesionInstance = Profesion.get(params.id)
        if(!profesionInstance) {
            flash.message = "No se encontr&oacute; Profesion a modificar"
            render "NO"
            return
        }
        profesionInstance.properties = params
    } else {
        profesionInstance = new Profesion(params)
    }
    if (!profesionInstance.save(flush: true)) {
        render "NO"
        println profesionInstance.errors
        flash.message = "Ha ocurrido un error al guardar Profesion"
        return
    }

    flash.message = "Profesion guardado exitosamente"
//    redirect(action: "show", id: profesionInstance.id)
    render "OK"
}

def show() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [profesionInstance: profesionInstance]
}

def edit() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [profesionInstance: profesionInstance]
}

def delete() {
    def profesionInstance = Profesion.get(params.id)
    if (!profesionInstance) {
        flash.message = "No se encontr&oacute; Profesion a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        profesionInstance.delete(flush: true)
        flash.message = "Profesion eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Profesion"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
