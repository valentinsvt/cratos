package cratos

import org.springframework.dao.DataIntegrityViolationException

class PacienteController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def buscarCedula() {
        def ci = params.ci
        def personas = Proveedor.findAllByRuc(ci)
        def str = ""
        if (personas.size() == 1) {
            def p = personas[0]
            str += (p.nombreContacto ?: "") + "&" + (p.apellidoContacto ?: "") + "&" + (p.direccion ?: "") + "&" + ""
            render("OK&" + str)
        } else if (personas.size() > 1) {
            render("NO&Existe más de un cliente con esa cédula o RUC")
        } else {
            render("NO&No existe un cliente con esa cédula o RUC")
        }
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {

        params.max = Math.min(params.max ? params.int('max') : 20, 100)
        def c = Proveedor.createCriteria()

        println("tid:" + cratos.Proveedor.list().tipoIdentificacion.id)

        def results = c.list(params) {

        }
//         def tipoId = Proveedor.get(Proveedor.tipoIdentificacion.id)

//        def results = Proveedor.findAllByTipoIdentificacion(tipoId)


        [pacienteInstanceList: results, pacienteInstanceTotal: results.totalCount]
    }

    def create() {
        [pacienteInstance: new Proveedor(params)]
    }

    def save() {

        def pacienteInstance = new Proveedor()

        println(params)
        if (params.fecha) {

            pacienteInstance.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
            params.remove("fecha")

        }


        pacienteInstance.properties = params

        pacienteInstance.estado = '1'
        pacienteInstance.empresa = session.empresa

        if (params.id) {

            pacienteInstance = Proveedor.get(params.id)
            if (params.fecha) {

                pacienteInstance.fecha = new Date().parse("yyyy-MM-dd", params.fecha)
                params.remove("fecha")
                println "params " + params

            }
            pacienteInstance.properties = params

        }

        if (!pacienteInstance.save(flush: true)) {
            println pacienteInstance.errors
            if (params.id) {
                render(view: "edit", model: [pacienteInstance: pacienteInstance])
            } else {
                render(view: "create", model: [pacienteInstance: pacienteInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Proveedor actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Proveedor creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: pacienteInstance.id)
    }

    def show() {
        def pacienteInstance = Proveedor.get(params.id)
        if (!pacienteInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [pacienteInstance: pacienteInstance]
    }

    def edit() {
        def pacienteInstance = Proveedor.get(params.id)
        if (!pacienteInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [pacienteInstance: pacienteInstance]
    }

    def delete() {
        def pacienteInstance = Proveedor.get(params.id)
        if (!pacienteInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            pacienteInstance.delete(flush: true)
            flash.message = "Proveedor  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
