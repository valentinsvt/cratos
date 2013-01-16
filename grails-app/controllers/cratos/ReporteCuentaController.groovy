package cratos

import org.springframework.dao.DataIntegrityViolationException

class ReporteCuentaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [reporteCuentaInstanceList: ReporteCuenta.list(params), reporteCuentaInstanceTotal: ReporteCuenta.count()]
    }

    def create() {
        [reporteCuentaInstance: new ReporteCuenta(params)]
    }

    def save() {
        def reporteCuentaInstance = new ReporteCuenta(params)

        reporteCuentaInstance.properties = params
        reporteCuentaInstance.empresa = session.empresa

        if (params.id) {
            reporteCuentaInstance = ReporteCuenta.get(params.id)
            if (!reporteCuentaInstance) {
                flash.message = "No se encontr&oacute; ReporteCuenta a modificar"
                render "NO"
                return
            }
            reporteCuentaInstance.properties = params
        } else {
            reporteCuentaInstance = new ReporteCuenta(params)
        }
        if (!reporteCuentaInstance.save(flush: true)) {
            render "NO"
            println reporteCuentaInstance.errors
            flash.message = "Ha ocurrido un error al guardar ReporteCuenta"
            return
        }

        flash.message = "ReporteCuenta guardado exitosamente"
//    redirect(action: "show", id: reporteCuentaInstance.id)
        render "OK"
    }

    def show() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [reporteCuentaInstance: reporteCuentaInstance]
    }

    def edit() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [reporteCuentaInstance: reporteCuentaInstance]
    }

    def delete() {
        def reporteCuentaInstance = ReporteCuenta.get(params.id)
        if (!reporteCuentaInstance) {
            flash.message = "No se encontr&oacute; ReporteCuenta a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            reporteCuentaInstance.delete(flush: true)
            flash.message = "ReporteCuenta eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar ReporteCuenta"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
