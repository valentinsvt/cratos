package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoRubroController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [tipoRubroInstanceList: TipoRubro.list(params), tipoRubroInstanceTotal: TipoRubro.count()]
}

def create() {
    [tipoRubroInstance: new TipoRubro(params)]
}

def save() {
    def tipoRubroInstance
    if(params.id) {
        tipoRubroInstance = TipoRubro.get(params.id)
        if(!tipoRubroInstance) {
            flash.message = "No se encontr&oacute; TipoRubro a modificar"
            render "NO"
            return
        }
        tipoRubroInstance.properties = params
    } else {
        tipoRubroInstance = new TipoRubro(params)
    }
    if (!tipoRubroInstance.save(flush: true)) {
        render "NO"
        println tipoRubroInstance.errors
        flash.message = "Ha ocurrido un error al guardar TipoRubro"
        return
    }

    flash.message = "TipoRubro guardado exitosamente"
//    redirect(action: "show", id: tipoRubroInstance.id)
    render "OK"
}

def show() {
    def tipoRubroInstance = TipoRubro.get(params.id)
    if (!tipoRubroInstance) {
        flash.message = "No se encontr&oacute; TipoRubro a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoRubroInstance: tipoRubroInstance]
}

def edit() {
    def tipoRubroInstance = TipoRubro.get(params.id)
    if (!tipoRubroInstance) {
        flash.message = "No se encontr&oacute; TipoRubro a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoRubroInstance: tipoRubroInstance]
}

def delete() {
    def tipoRubroInstance = TipoRubro.get(params.id)
    if (!tipoRubroInstance) {
        flash.message = "No se encontr&oacute; TipoRubro a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        tipoRubroInstance.delete(flush: true)
        flash.message = "TipoRubro eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar TipoRubro"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
