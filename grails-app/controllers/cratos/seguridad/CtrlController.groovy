package cratos.seguridad

class CtrlController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        def title = g.message(code: "ctrl.list", default: "Ctrl List")
//        <g:message code="default.list.label" args="[entityName]" />

        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [ctrlInstanceList: Ctrl.list(params), ctrlInstanceTotal: Ctrl.count(), title: title, params: params]
    }

    def form = {
        def title
        def ctrlInstance

        if (params.source == "create") {
            ctrlInstance = new Ctrl()
            ctrlInstance.properties = params
            title = g.message(code: "ctrl.create", default: "Create Ctrl")
        } else if (params.source == "edit") {
            ctrlInstance = Ctrl.get(params.id)
            if (!ctrlInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
                redirect(action: "list")
            }
            title = g.message(code: "ctrl.edit", default: "Edit Ctrl")
        }

        return [ctrlInstance: ctrlInstance, title: title, source: params.source]
    }

    def create = {
        params.source = "create"
        redirect(action: "form", params: params)
    }

    def save = {
        def title
        if (params.id) {
            title = g.message(code: "ctrl.edit", default: "Edit Ctrl")
            def ctrlInstance = Ctrl.get(params.id)
            if (ctrlInstance) {
                ctrlInstance.properties = params
                if (!ctrlInstance.hasErrors() && ctrlInstance.save(flush: true)) {
                    flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), ctrlInstance.id])}"
                    redirect(action: "show", id: ctrlInstance.id)
                }
                else {
                    render(view: "form", model: [ctrlInstance: ctrlInstance, title: title, source: "edit"])
                }
            }
            else {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
                redirect(action: "list")
            }
        } else {
            title = g.message(code: "ctrl.create", default: "Create Ctrl")
            def ctrlInstance = new Ctrl(params)
            if (ctrlInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.created.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), ctrlInstance.id])}"
                redirect(action: "show", id: ctrlInstance.id)
            }
            else {
                render(view: "form", model: [ctrlInstance: ctrlInstance, title: title, source: "create"])
            }
        }
    }

    def update = {
        def ctrlInstance = Ctrl.get(params.id)
        if (ctrlInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (ctrlInstance.version > version) {

                    ctrlInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'ctrl.label', default: 'Ctrl')] as Object[], "Another user has updated this Ctrl while you were editing")
                    render(view: "edit", model: [ctrlInstance: ctrlInstance])
                    return
                }
            }
            ctrlInstance.properties = params
            if (!ctrlInstance.hasErrors() && ctrlInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), ctrlInstance.id])}"
                redirect(action: "show", id: ctrlInstance.id)
            }
            else {
                render(view: "edit", model: [ctrlInstance: ctrlInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
            redirect(action: "list")
        }
    }

    def show = {
        def ctrlInstance = Ctrl.get(params.id)
        if (!ctrlInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
            redirect(action: "list")
        }
        else {

            def title = g.message(code: "ctrl.show", default: "Show Ctrl")

            [ctrlInstance: ctrlInstance, title: title]
        }
    }

    def edit = {
        params.source = "edit"
        redirect(action: "form", params: params)
    }

    def delete = {
        def ctrlInstance = Ctrl.get(params.id)
        if (ctrlInstance) {
            try {
                ctrlInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'ctrl.label', default: 'Ctrl'), params.id])}"
            redirect(action: "list")
        }
    }
}
