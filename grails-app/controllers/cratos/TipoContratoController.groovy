package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoContratoController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [tipoContratoInstanceList: TipoContrato.list(params), tipoContratoInstanceTotal: TipoContrato.count()]
}

def create() {
    [tipoContratoInstance: new TipoContrato(params)]
}

def save() {
    def tipoContratoInstance
    if(params.id) {
        tipoContratoInstance = TipoContrato.get(params.id)
        if(!tipoContratoInstance) {
            flash.message = "No se encontr&oacute; TipoContrato a modificar"
            render "NO"
            return
        }
        tipoContratoInstance.properties = params
    } else {
        tipoContratoInstance = new TipoContrato(params)
    }
    if (!tipoContratoInstance.save(flush: true)) {
        render "NO"
        println tipoContratoInstance.errors
        flash.message = "Ha ocurrido un error al guardar TipoContrato"
        return
    }

    flash.message = "TipoContrato guardado exitosamente"
//    redirect(action: "show", id: tipoContratoInstance.id)
    render "OK"
}

def show() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoContratoInstance: tipoContratoInstance]
}

def edit() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoContratoInstance: tipoContratoInstance]
}

def delete() {
    def tipoContratoInstance = TipoContrato.get(params.id)
    if (!tipoContratoInstance) {
        flash.message = "No se encontr&oacute; TipoContrato a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        tipoContratoInstance.delete(flush: true)
        flash.message = "TipoContrato eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar TipoContrato"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
