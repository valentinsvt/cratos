package cratos.seguridad

class ModuloController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "modulo.list", default: "Modulo List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [moduloInstanceList: Modulo.list(params), moduloInstanceTotal: Modulo.count(), title: title, params: params]
    }

    def form = {
        def title
        def moduloInstance

        if (params.source == "create") {
            moduloInstance = new Modulo()
            moduloInstance.properties = params
            title = g.message(code: "modulo.create", default: "Create Modulo")
        } else if (params.source == "edit") {
            moduloInstance = Modulo.get(params.id)
            if (!moduloInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "modulo.edit", default: "Edit Modulo")
        }

        return [moduloInstance: moduloInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "modulo.edit", default: "Edit Modulo")
            def moduloInstance = Modulo.get(params.id)
            if (moduloInstance) {
                moduloInstance.properties = params
                if (!moduloInstance.hasErrors() && moduloInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'modulo.label', default: 'Modulo'), moduloInstance.id])}"
                    redirect(action: "show", id: moduloInstance.id)
                }
                else {
                    render(view: "form", model: [moduloInstance: moduloInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "modulo.create", default: "Create Modulo")
            def moduloInstance = new Modulo(params)
            if (moduloInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'modulo.label', default: 'Modulo'), moduloInstance.id])}"
                redirect(action: "show", id: moduloInstance.id)
            }
            else {
                render(view: "form", model: [moduloInstance: moduloInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def moduloInstance = Modulo.get(params.id)
        if (moduloInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (moduloInstance.version > version) {

                    moduloInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'modulo.label', default: 'Modulo')] as Object[], "Another user has updated this Modulo while you were editing")
                    render(view: "edit", model: [moduloInstance: moduloInstance])
                    return
                }
            }
            moduloInstance.properties = params
            if (!moduloInstance.hasErrors() && moduloInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'modulo.label', default: 'Modulo'), moduloInstance.id])}"
                redirect(action: "show", id: moduloInstance.id)
            }
            else {
                render(view: "edit", model: [moduloInstance: moduloInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def moduloInstance = Modulo.get(params.id)
        if (!moduloInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "modulo.show", default: "Show Modulo")

            [moduloInstance: moduloInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def moduloInstance = Modulo.get(params.id)
        if (moduloInstance) {
            try {
                moduloInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'modulo.label', default: 'Modulo'), params.id])}"
            redirect(action: "list")
        }
    }
}
