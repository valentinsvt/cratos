package cratos

import org.springframework.dao.DataIntegrityViolationException

class ConceptoRetencionImpuestoRentaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [conceptoRetencionImpuestoRentaInstanceList: ConceptoRetencionImpuestoRenta.list(params), conceptoRetencionImpuestoRentaInstanceTotal: ConceptoRetencionImpuestoRenta.count()]
    }

    def create() {
        [conceptoRetencionImpuestoRentaInstance: new ConceptoRetencionImpuestoRenta(params)]
    }

    def save() {
        def conceptoRetencionImpuestoRentaInstance
        if (params.id) {
            conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
            if (!conceptoRetencionImpuestoRentaInstance) {
                flash.message = "No se encontr&oacute; ConceptoRetencionImpuestoRenta a modificar"
                render "NO"
                return
            }
            conceptoRetencionImpuestoRentaInstance.properties = params
        } else {
            conceptoRetencionImpuestoRentaInstance = new ConceptoRetencionImpuestoRenta(params)
        }
        if (!conceptoRetencionImpuestoRentaInstance.save(flush: true)) {
            render "NO"
            println conceptoRetencionImpuestoRentaInstance.errors
            flash.message = "Ha ocurrido un error al guardar ConceptoRetencionImpuestoRenta"
            return
        }

        flash.message = "ConceptoRetencionImpuestoRenta guardado exitosamente"
//    redirect(action: "show", id: conceptoRetencionImpuestoRentaInstance.id)
        render "OK"
    }

    def show() {
        def conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
        if (!conceptoRetencionImpuestoRentaInstance) {
            flash.message = "No se encontr&oacute; ConceptoRetencionImpuestoRenta a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [conceptoRetencionImpuestoRentaInstance: conceptoRetencionImpuestoRentaInstance]
    }

    def edit() {
        def conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
        if (!conceptoRetencionImpuestoRentaInstance) {
            flash.message = "No se encontr&oacute; ConceptoRetencionImpuestoRenta a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [conceptoRetencionImpuestoRentaInstance: conceptoRetencionImpuestoRentaInstance]
    }

    def delete() {
        def conceptoRetencionImpuestoRentaInstance = ConceptoRetencionImpuestoRenta.get(params.id)
        if (!conceptoRetencionImpuestoRentaInstance) {
            flash.message = "No se encontr&oacute; ConceptoRetencionImpuestoRenta a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            conceptoRetencionImpuestoRentaInstance.delete(flush: true)
            flash.message = "ConceptoRetencionImpuestoRenta eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar ConceptoRetencionImpuestoRenta"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
