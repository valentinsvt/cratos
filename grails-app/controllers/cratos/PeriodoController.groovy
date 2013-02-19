package cratos

import org.springframework.dao.DataIntegrityViolationException

class PeriodoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [periodoInstanceList: Periodo.list(params), periodoInstanceTotal: Periodo.count()]
    }

    def create() {
        [periodoInstance: new Periodo(params)]
    }

    def save() {
        println "save epriodo "+params
        if (params.fechaFin) {
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)

        }
        if (params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)

        }
        def periodoInstance = new Periodo(params)



        if (params.id) {
            periodoInstance = Periodo.get(params.id)
            periodoInstance.properties = params
        }

        if (!periodoInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [periodoInstance: periodoInstance])
            } else {
                render(view: "create", model: [periodoInstance: periodoInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Periodo actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Periodo creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: periodoInstance.id)
    }

    def show() {
        def periodoInstance = Periodo.get(params.id)
        if (!periodoInstance) {
            flash.message = "No se encontró Periodo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [periodoInstance: periodoInstance]
    }

    def edit() {
        def periodoInstance = Periodo.get(params.id)
        if (!periodoInstance) {
            flash.message = "No se encontró Periodo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [periodoInstance: periodoInstance]
    }

    def delete() {
        def periodoInstance = Periodo.get(params.id)
        if (!periodoInstance) {
            flash.message = "No se encontró Periodo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            periodoInstance.delete(flush: true)
            flash.message = "Periodo  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Periodo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
