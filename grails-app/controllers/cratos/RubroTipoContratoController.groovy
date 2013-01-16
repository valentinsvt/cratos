package cratos

import org.springframework.dao.DataIntegrityViolationException

class RubroTipoContratoController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [rubroTipoContratoInstanceList: RubroTipoContrato.list(params), rubroTipoContratoInstanceTotal: RubroTipoContrato.count()]
}

def create() {
    [rubroTipoContratoInstance: new RubroTipoContrato(params)]
}

def save() {
    def rubroTipoContratoInstance
    if(params.id) {
        rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
        if(!rubroTipoContratoInstance) {
            flash.message = "No se encontr&oacute; RubroTipoContrato a modificar"
            render "NO"
            return
        }
        rubroTipoContratoInstance.properties = params
    } else {
        rubroTipoContratoInstance = new RubroTipoContrato(params)
    }
    if (!rubroTipoContratoInstance.save(flush: true)) {
        render "NO"
        println rubroTipoContratoInstance.errors
        flash.message = "Ha ocurrido un error al guardar RubroTipoContrato"
        return
    }

    flash.message = "RubroTipoContrato guardado exitosamente"
//    redirect(action: "show", id: rubroTipoContratoInstance.id)
    render "OK"
}

def show() {
    def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
    if (!rubroTipoContratoInstance) {
        flash.message = "No se encontr&oacute; RubroTipoContrato a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [rubroTipoContratoInstance: rubroTipoContratoInstance]
}

def edit() {
    def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
    if (!rubroTipoContratoInstance) {
        flash.message = "No se encontr&oacute; RubroTipoContrato a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [rubroTipoContratoInstance: rubroTipoContratoInstance]
}

def delete() {
    def rubroTipoContratoInstance = RubroTipoContrato.get(params.id)
    if (!rubroTipoContratoInstance) {
        flash.message = "No se encontr&oacute; RubroTipoContrato a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        rubroTipoContratoInstance.delete(flush: true)
        flash.message = "RubroTipoContrato eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar RubroTipoContrato"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
