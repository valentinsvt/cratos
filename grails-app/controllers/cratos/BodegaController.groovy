package cratos

import org.springframework.dao.DataIntegrityViolationException

class BodegaController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [bodegaInstanceList: Bodega.list(params), bodegaInstanceTotal: Bodega.count()]
}

def create() {
    [bodegaInstance: new Bodega(params)]
}

def save() {
    def bodegaInstance
    if(params.id) {
        bodegaInstance = Bodega.get(params.id)
        if(!bodegaInstance) {
            flash.message = "No se encontr&oacute; Bodega a modificar"
            render "NO"
            return
        }
        bodegaInstance.properties = params
    } else {
        bodegaInstance = new Bodega(params)
    }
    if (!bodegaInstance.save(flush: true)) {
        render "NO"
        println bodegaInstance.errors
        flash.message = "Ha ocurrido un error al guardar Bodega"
        return
    }

    flash.message = "Bodega guardado exitosamente"
//    redirect(action: "show", id: bodegaInstance.id)
    render "OK"
}

def show() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [bodegaInstance: bodegaInstance]
}

def edit() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [bodegaInstance: bodegaInstance]
}

def delete() {
    def bodegaInstance = Bodega.get(params.id)
    if (!bodegaInstance) {
        flash.message = "No se encontr&oacute; Bodega a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        bodegaInstance.delete(flush: true)
        flash.message = "Bodega eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Bodega"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
