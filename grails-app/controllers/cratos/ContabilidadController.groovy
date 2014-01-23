package cratos

import org.springframework.dao.DataIntegrityViolationException

class ContabilidadController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [contabilidadInstanceList: Contabilidad.list(params), contabilidadInstanceTotal: Contabilidad.count()]
    }

    def create() {
        [contabilidadInstance: new Contabilidad(params)]
    }

    def save() {

        if(params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }
        if(params.fechaCierre) {
            params.fechaCierre = new Date().parse("dd-MM-yyyy", params.fechaCierre)
        }
        if(params.presupuesto) {
            params.presupuesto = new Date().parse("dd-MM-yyyy", params.presupuesto)
        }

        def contabilidadInstance = new Contabilidad(params)

        if (params.id) {
            contabilidadInstance = Contabilidad.get(params.id)
            contabilidadInstance.properties = params
        }

        if (!contabilidadInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [contabilidadInstance: contabilidadInstance])
            } else {
                render(view: "create", model: [contabilidadInstance: contabilidadInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Contabilidad actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Contabilidad creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }

        12.times {
            def ini = new Date().parse("dd-MM-yyyy", "01-"+((it+1).toString().padLeft(2,'0'))+"-"+contabilidadInstance.fechaInicio.format("yyyy"))
            def fin = getLastDayOfMonth(ini)
            def periodoInstance = new Periodo()

            if(periodoInstance.save(flush: true)){

                periodoInstance.contabilidad = contabilidadInstance
                periodoInstance.fechaInicio = ini
                periodoInstance.fechaFin = fin
                periodoInstance.numero = it+1
            }
            else {

                 render "Error al grabar períodos"
            }
        }

        redirect(action: "show", id: contabilidadInstance.id)
    }

    def getLastDayOfMonth(fecha) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);

        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.add(Calendar.DATE, -1);

        Date lastDayOfMonth = calendar.getTime();
        return lastDayOfMonth
    }


    def show() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [contabilidadInstance: contabilidadInstance]
    }

    def edit() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [contabilidadInstance: contabilidadInstance]
    }

    def delete() {
        def contabilidadInstance = Contabilidad.get(params.id)
        if (!contabilidadInstance) {
            flash.message = "No se encontró Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            contabilidadInstance.delete(flush: true)
            flash.message = "Contabilidad  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Contabilidad con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }



}
