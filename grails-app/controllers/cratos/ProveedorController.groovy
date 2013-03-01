package cratos

import org.springframework.dao.DataIntegrityViolationException

class ProveedorController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def buscarCedula() {
        def ci = params.ci
        def personas = Proveedor.findAllByRuc(ci)
        def str = ""
        println(personas)
        println(ci)

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

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def c = Proveedor.createCriteria()
        def results = c.list(params) {
            eq("empresa", session.empresa)
        }

        [proveedorInstanceList: results, proveedorInstanceTotal: results.totalCount]
    }

    def create() {
        [proveedorInstance: new Proveedor(params)]
    }

    def save() {
        def proveedorInstance
        def ci = params.ruc

        def persona


        //save

        if (params.fecha) {

            params.fecha = new Date().parse("yyyy-MM-dd", params.fecha)

        }
        if (params.fechaCaducidad) {

           params.fechaCaducidad = new Date().parse("yyyy-MM-dd", params.fechaCaducidad)

        }


        if (params.id) {

            proveedorInstance = Proveedor.get(params.id)
            proveedorInstance.properties = params


        }else{
            proveedorInstance = new Proveedor()
            proveedorInstance.properties = params
            proveedorInstance.estado = '1'
            proveedorInstance.empresa = session.empresa
        }


        if (!proveedorInstance.save(flush: true)) {
            println proveedorInstance.errors

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
//            redirect(action: "show", id: proveedorInstance.id)
        render "OK"



        println("per:" + persona)

    }

    def show() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [proveedorInstance: proveedorInstance]
    }

    def edit() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [proveedorInstance: proveedorInstance]
    }

    def delete() {
        def proveedorInstance = Proveedor.get(params.id)
        if (!proveedorInstance) {
            flash.message = "No se encontró Proveedor con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            proveedorInstance.delete(flush: true)
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
