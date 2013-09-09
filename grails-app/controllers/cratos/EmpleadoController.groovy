package cratos

import groovy.json.JsonBuilder
import org.springframework.dao.DataIntegrityViolationException

class EmpleadoController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def mes = Mes.list([sort:"id"])
        def periodos = Periodo.findAllByContabilidad(session.contabilidad,[sort: "fechaInicio"])

        [empleadoInstanceList: Empleado.list(params), empleadoInstanceTotal: Empleado.count(),mes:mes,periodos:periodos]
    }

    def findPersona_ajax() {
        def ci = params.ci

        def persona = Persona.findAllByCedula(ci)
        if (persona.size() == 1) {
            persona = persona[0]
        } else if (persona.size() > 1) {
            persona = null
            println "Error: más de una persona con ci: " + ci
        } else {
            persona = null
            println "No se encontró persona con ci " + ci
        }
        def datos = [:]
        if (persona) {
            datos = [
                    cedula: persona.cedula,
                    nombre: persona.nombre,
                    apellido: persona.apellido,
                    direccion: persona.direccion,
                    telefono: persona.telefono,
                    email: persona.email,
                    fechaNacimiento: persona.fechaNacimiento.format("dd-MM-yyyy"),
                    personaId: persona.id
            ]
        }
        def json = new JsonBuilder(datos)
        render json
    }

    def form() {
        def empleadoInstance = new Empleado()
        def personaInstance = new Persona()
        if (params.id) {
            empleadoInstance = Empleado.get(params.id)
            personaInstance = empleadoInstance.persona
        }
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance, personaInstance: personaInstance]
    }


    def create() {
        [empleadoInstance: new Empleado(params)]
    }

    def save() {
        println params
        if (params.persona.fechaNacimiento) {
            params.persona.fechaNacimiento = new Date().parse("dd-MM-yyyy", params.persona.fechaNacimiento)
        }
        if (params.empleado.fechaInicio) {
            params.empleado.fechaInicio = new Date().parse("dd-MM-yyyy", params.empleado.fechaInicio)
        }
        if (params.empleado.fechaFin) {
            params.empleado.fechaFin = new Date().parse("dd-MM-yyyy", params.empleado.fechaFin)
        }
        def empleadoInstance, personaInstance
        if (params.empleado.id) {
            empleadoInstance = Empleado.get(params.empleado.id)
            if (!empleadoInstance) {
                flash.message = "No se encontr&oacute; Empleado a modificar"
                render "NO"
                return
            }
            personaInstance = Persona.get(empleadoInstance.personaId)
            empleadoInstance.properties = params.empleado
            personaInstance.properties = params.persona
        } else {
            if (params.persona.id) {
                personaInstance = Persona.get(params.persona.id)
                if (!personaInstance) {
                    println "NO se encontro persona???"
                    personaInstance = new Persona(params.persona)
                    personaInstance.nacionalidad = Nacionalidad.get(1)
                }
            } else {
                personaInstance = new Persona(params.persona)
                personaInstance.empresa=session.empresa
                personaInstance.nacionalidad = Nacionalidad.get(1)
            }
            empleadoInstance = new Empleado(params.empleado)
        }
        if (!personaInstance.save(flush: true)) {
            render "NO"
            println personaInstance.errors
            flash.message = "Ha ocurrido un error al guardar Persona"
            return
        }
        empleadoInstance.persona = personaInstance
        if (!empleadoInstance.save(flush: true)) {
            render "NO"
            println empleadoInstance.errors
            flash.message = "Ha ocurrido un error al guardar Empleado"
            return
        }

        flash.message = "Empleado guardado exitosamente"
        redirect(action: "show", id: empleadoInstance.id)
        render "OK"
    }

    def show() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a mostrar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance]
    }

    def edit() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a modificar"
//            redirect(action: "list")
            render "NO"
            return
        }

        [empleadoInstance: empleadoInstance]
    }

    def delete() {
        def empleadoInstance = Empleado.get(params.id)
        if (!empleadoInstance) {
            flash.message = "No se encontr&oacute; Empleado a eliminar"
            render "NO"
//            redirect(action: "list")
            return
        }

        try {
            empleadoInstance.delete(flush: true)
            flash.message = "Empleado eliminado exitosamente"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "Ha ocurrido un error al eliminar Empleado"
//            redirect(action: "show", id: params.id)
        }
        render "OK"
    }
}
