package cratos

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat

class EmpresaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [empresaInstanceList: Empresa.list(params), empresaInstanceTotal: Empresa.count()]
    }

    def create() {
        [empresaInstance: new Empresa(params)]
    }

    def save() {
//        println("empresa" + params)
        def empresaInstance = new Empresa()
        if (params.fechaInicio) {
            empresaInstance.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
            params.remove("fechaInicio")
        }

        if (params.fechaFin) {
            empresaInstance.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
            params.remove("fechaFin")
        }
        if (params.id) {
            empresaInstance = Empresa.get(params.id)
        }
        empresaInstance.properties = params
//        println "\t\t" + empresaInstance.ordenCompra
        empresaInstance.ordenCompra = params.ordenCompra
//        println "\t\t" + empresaInstance.ordenCompra
        if (!empresaInstance.save(flush: true)) {
            println(empresaInstance.errors)
            if (params.id) {
                render(view: "edit", model: [empresaInstance: empresaInstance])
            } else {
                render(view: "create", model: [empresaInstance: empresaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Empresa actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Empresa creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: empresaInstance.id)
    }

    def show() {
        def empresaInstance = Empresa.get(params.id)
        if (!empresaInstance) {
            flash.message = "No se encontró Empresa con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [empresaInstance: empresaInstance]
    }

    def edit() {
        def empresaInstance = Empresa.get(params.id)
        if (!empresaInstance) {
            flash.message = "No se encontró Empresa con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [empresaInstance: empresaInstance]
    }

    def delete() {

        println("id: " + params.id)
        def empresaInstance = Empresa.get(params.id)
        if (!empresaInstance) {
            flash.message = "No se encontró Empresa con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            empresaInstance.delete(flush: true)
            flash.message = "Empresa  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Empresa con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
