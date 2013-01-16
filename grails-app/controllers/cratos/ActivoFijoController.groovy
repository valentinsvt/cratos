package cratos

import org.springframework.dao.DataIntegrityViolationException

class ActivoFijoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [activoFijoInstanceList: ActivoFijo.list(params), activoFijoInstanceTotal: ActivoFijo.count()]
    }

    def create() {
        [activoFijoInstance: new ActivoFijo(params)]
    }

    def save() {
        def activoFijoInstance = new ActivoFijo(params)


        println("act" + params)

        
        if (params.fechaInicio){

            activoFijoInstance.fechaInicio = new Date().parse("yyyy-MM-dd", params.fechaInicio)
            params.remove("fechaInicio")
        }

        if (params.fechaAdquisicion){

            activoFijoInstance.fechaAdquisicion = new Date().parse("yyyy-MM-dd", params.fechaAdquisicion)
            params.remove("fechaAdquisicion")

        }

        if (params.id) {
            activoFijoInstance = ActivoFijo.get(params.id)
            activoFijoInstance.properties = params

        }

        activoFijoInstance.properties = params


        if (!activoFijoInstance.save(flush: true)) {

            println(activoFijoInstance.errors);

            if (params.id) {
                render(view: "edit", model: [activoFijoInstance: activoFijoInstance])
            } else {
                render(view: "create", model: [activoFijoInstance: activoFijoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "ActivoFijo actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "ActivoFijo creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: activoFijoInstance.id)
    }

    def show() {
        def activoFijoInstance = ActivoFijo.get(params.id)
        if (!activoFijoInstance) {
            flash.message = "No se encontró ActivoFijo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [activoFijoInstance: activoFijoInstance]
    }

    def edit() {
        def activoFijoInstance = ActivoFijo.get(params.id)
        if (!activoFijoInstance) {
            flash.message = "No se encontró ActivoFijo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [activoFijoInstance: activoFijoInstance]
    }

    def delete() {
        def activoFijoInstance = ActivoFijo.get(params.id)
        if (!activoFijoInstance) {
            flash.message = "No se encontró ActivoFijo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            activoFijoInstance.delete(flush: true)
            flash.message = "ActivoFijo  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar ActivoFijo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
