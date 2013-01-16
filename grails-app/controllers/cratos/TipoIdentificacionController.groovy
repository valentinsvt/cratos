package cratos

import org.springframework.dao.DataIntegrityViolationException

class TipoIdentificacionController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [tipoIdentificacionInstanceList: TipoIdentificacion.list(params), tipoIdentificacionInstanceTotal: TipoIdentificacion.count()]
}

def create() {
    [tipoIdentificacionInstance: new TipoIdentificacion(params)]
}

def save() {
    def tipoIdentificacionInstance
    if(params.id) {
        tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
        if(!tipoIdentificacionInstance) {
            flash.message = "No se encontr&oacute; TipoIdentificacion a modificar"
            render "NO"
            return
        }
        tipoIdentificacionInstance.properties = params
    } else {
        tipoIdentificacionInstance = new TipoIdentificacion(params)
    }
    if (!tipoIdentificacionInstance.save(flush: true)) {
        render "NO"
        println tipoIdentificacionInstance.errors
        flash.message = "Ha ocurrido un error al guardar TipoIdentificacion"
        return
    }

    flash.message = "TipoIdentificacion guardado exitosamente"
//    redirect(action: "show", id: tipoIdentificacionInstance.id)
    render "OK"
}

def show() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoIdentificacionInstance: tipoIdentificacionInstance]
}

def edit() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [tipoIdentificacionInstance: tipoIdentificacionInstance]
}

def delete() {
    def tipoIdentificacionInstance = TipoIdentificacion.get(params.id)
    if (!tipoIdentificacionInstance) {
        flash.message = "No se encontr&oacute; TipoIdentificacion a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        tipoIdentificacionInstance.delete(flush: true)
        flash.message = "TipoIdentificacion eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar TipoIdentificacion"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
