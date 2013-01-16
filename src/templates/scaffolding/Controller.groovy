<%=packageName ? "package ${packageName}\n\n" : ''%>import org.springframework.dao.DataIntegrityViolationException

class ${className}Controller extends cratos.seguridad.Shield {

static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

def index() {
    redirect(action: "list", params: params)
}

def list() {
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    [${propertyName}List: ${className}.list(params), ${propertyName}Total: ${className}.count()]
}

def create() {
    [${propertyName}: new ${className}(params)]
}

def save() {
    def ${propertyName}
    if(params.id) {
        ${propertyName} = ${className}.get(params.id)
        if(!${propertyName}) {
            flash.message = "No se encontr&oacute; ${className} a modificar"
            render "NO"
            return
        }
        ${propertyName}.properties = params
    } else {
        ${propertyName} = new ${className}(params)
    }
    if (!${propertyName}.save(flush: true)) {
        render "NO"
        println ${propertyName}.errors
        flash.message = "Ha ocurrido un error al guardar ${className}"
        return
    }

    flash.message = "${className} guardado exitosamente"
//    redirect(action: "show", id: ${propertyName}.id)
    render "OK"
}

def show() {
    def ${propertyName} = ${className}.get(params.id)
    if (!${propertyName}) {
        flash.message = "No se encontr&oacute; ${className} a mostrar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [${propertyName}: ${propertyName}]
}

def edit() {
    def ${propertyName} = ${className}.get(params.id)
    if (!${propertyName}) {
        flash.message = "No se encontr&oacute; ${className} a modificar"
//            redirect(action: "list")
        render "NO"
        return
    }

    [${propertyName}: ${propertyName}]
}

def delete() {
    def ${propertyName} = ${className}.get(params.id)
    if (!${propertyName}) {
        flash.message = "No se encontr&oacute; ${className} a eliminar"
        render "NO"
//            redirect(action: "list")
        return
    }

    try {
        ${propertyName}.delete(flush: true)
        flash.message = "${className} eliminado exitosamente"
        redirect(action: "list")
    }
    catch (DataIntegrityViolationException e) {
        flash.message = "Ha ocurrido un error al eliminar ${className}"
//            redirect(action: "show", id: params.id)
    }
    render "OK"
}
}
