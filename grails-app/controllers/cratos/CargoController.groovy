package cratos

import org.springframework.dao.DataIntegrityViolationException

class CargoController extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [cargoInstanceList: Cargo.list(params), cargoInstanceTotal: Cargo.count()]
}

def create() {
    [cargoInstance: new Cargo(params)]
}

def save() {
    def cargoInstance
    if(params.id) {
        cargoInstance = Cargo.get(params.id)
        if(!cargoInstance) {
            flash.message = "No se encontr&oacute; Cargo a modificar"
            render "NO"
            return
        }
        cargoInstance.properties = params
    } else {
        cargoInstance = new Cargo(params)
    }
    if (!cargoInstance.save(flush: true)) {
        render "NO"
        println cargoInstance.errors
        flash.message = "Ha ocurrido un error al guardar Cargo"
        return
    }

    flash.message = "Cargo guardado exitosamente"
//    redirect(action: "show", id: cargoInstance.id)
    render "OK"
}

def show() {
    def cargoInstance = Cargo.get(params.id)
    if (!cargoInstance) {
        flash.message = "No se encontr&oacute; Cargo a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [cargoInstance: cargoInstance]
}

def edit() {
    def cargoInstance = Cargo.get(params.id)
    if (!cargoInstance) {
        flash.message = "No se encontr&oacute; Cargo a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [cargoInstance: cargoInstance]
}

def delete() {
    def cargoInstance = Cargo.get(params.id)
    if (!cargoInstance) {
        flash.message = "No se encontr&oacute; Cargo a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        cargoInstance.delete(flush: true)
        flash.message = "Cargo eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar Cargo"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
