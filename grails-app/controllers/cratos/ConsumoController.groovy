package cratos

import org.springframework.dao.DataIntegrityViolationException

class ConsumoController extends cratos.seguridad.Shield  {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        def facturas = Consumo.withCriteria {
            projections {
                distinct("factura")
            }
        }

        facturas = facturas.sort { it.id*-1 }

        [facturas: facturas, facturasTotal: facturas.size()]
    }

    def create() {
        def iva = ParametrosAuxiliares.get(1).iva
        def factura

        if (!params.id) {
//            println "no id"
            factura = new Factura()
            factura.fecha = new Date()
            if (!factura.save(flush: true)) {
                println "Error factura l.25 " + factura.errors
            }
            redirect(action: "create", id: factura.id)
        } else {
//            println "si id"
            factura = Factura.get(params.id)
        }
        println "CREATE " + factura.persona + "   " + factura.direccion + "   " + factura.telefono
        return [iva: iva, factura: factura]
    }


    def buscarCliente = {

          def search = params.search

           def resultado = Proveedor.withCriteria {
               eq("empresa", Empresa.get(session.empresa.id))

               or{

                   ilike("nombre", "%" + search + "%")
                   ilike("ruc", "%" + search + "%")
                   ilike ("nombreContacto", "%" + search + "%")
                   ilike("apellidoContacto", "%" + search + "%")

               }

               maxResults(20)
               order("ruc", "asc")

           }

        return [resultado: resultado]
    }



    def saveItem() {
        println "SAVE ITEM:"
        println params
        def ok = true
        def empresa = Empresa.get(session.empresa.id)

//        println "params save item"
//        println params
        def consumos = []
        def factura
        if (params.factura && params.factura != "") {
            factura = Factura.get(params.factura)
        } else {
            factura = new Factura()
        }
//        println "SAVE ITEM1 " + factura.persona + "   " + factura.direccion + "   " + factura.telefono

        if (params.update == true || params.update == "true") {
            def proveedor = Proveedor.findByRuc(params.ci)
            if (!proveedor) {
                proveedor = new Proveedor()
                proveedor.tipoProveedor = TipoProveedor.get(1)
                proveedor.tipoPersona = TipoPersona.get(1)
                proveedor.tipoIdentificacion = TipoIdentificacion.get(2)

                proveedor.empresa = empresa

                proveedor.ruc = params.ci
                proveedor.direccion = params.direccion
                proveedor.fecha = new Date()
                proveedor.nombreContacto = params.nombre
                proveedor.apellidoContacto = params.apellido

                proveedor.descuento = 0
                proveedor.telefono = params.telefono
                if (!proveedor.save(flush: true)) {
                    println "ERROR SAVE proveedor l.87 " + proveedor.errors
                    ok = false
                }
            }
            factura.proveedor = proveedor
            factura.persona = params.nombre + " " + params.apellido
            factura.paciente = params.paciente
            factura.telefono = params.telefono
            factura.direccion = params.direccion
            factura.secuencial=params.numero
            println "numero "+ factura.secuencial
            if (!factura.save(flush: true)) {
                println "error factura: " + factura.errors
            }

//        println "SAVE ITEM2 " + factura.persona + "   " + factura.direccion + "   " + factura.telefono
            if (params.add == "true") {
                def consumo = new Consumo()
                if (params.consumo && params.consumo != "") {
                    consumo = Consumo.get(params.consumo.toLong())
                }
                consumo.factura = factura
                consumo.item = Item.get(params.item.toLong())
                consumo.cantidad = params.cantidad.toDouble()
                consumo.descuento = params.descuento.toDouble()
                consumo.observaciones = params.observaciones
                consumo.precioUnitario = params.precio.toDouble()

                if (!consumo.save(flush: true)) {
                    println "error consumo: " + consumo.errors
                }
            }
        }
        consumos = Consumo.findAllByFactura(factura)

        return [consumos: consumos, update: params.update]
    }

    def deleteItem() {
        def consumo = Consumo.get(params.id)
        consumo.delete()
        render("OK")
    }

    def save() {
//        println params
        /*
        ["apellido":"G",
        "total":"undefined",
        "direccion":"casa",
        "tipoFactura":"undefined",
        "telefono":"1234567",
        "descuentos":"undefined",
        "subtotal":"608",
        "iva0":"undefined",
        "iva1":"undefined",
        "nombre":"F",
        "tipoPago":"undefined",
        "item":["5^1^8^0^1^", "21^1^300^0^1^", "21^1^300^0^1^"],
        "ci":"171647332500",
        "tipoTarjeta":"undefined",
        "action":"save",
        "controller":"consumo"]
         */

        def factura
        if (params.factura && params.factura != "") {
            println "1"
            factura = Factura.get(params.factura)
        } else {
            println "2"
            factura = new Factura()
        }
        println "SAVE1 " + factura.persona + "   " + factura.direccion + "   " + factura.telefono
        factura.proveedor = Proveedor.findByRuc(params.ci)
        factura.persona = params.nombre
        factura.telefono = params.telefono
        factura.direccion = params.direccion
        if (!factura.save(flush: true)) {
            println "error factura: " + factura.errors
        }
        println "SAVE2 " + factura.persona + "   " + factura.direccion + "   " + factura.telefono


        render params
//        def consumoInstance = new Consumo(params)
//
//        if (params.id) {
//            consumoInstance = Consumo.get(params.id)
//            consumoInstance.properties = params
//        }
//
//        if (!consumoInstance.save(flush: true)) {
//            if (params.id) {
//                render(view: "edit", model: [consumoInstance: consumoInstance])
//            } else {
//                render(view: "create", model: [consumoInstance: consumoInstance])
//            }
//            return
//        }
//
//        if (params.id) {
//            flash.message = "Consumo actualizado"
//            flash.clase = "success"
//            flash.ico = "ss_accept"
//        } else {
//            flash.message = "Consumo creado"
//            flash.clase = "success"
//            flash.ico = "ss_accept"
//        }
//        redirect(action: "show", id: consumoInstance.id)
    }

    def show() {
        def factura = Factura.get(params.id)
        println "SHOW " + factura.persona + "   " + factura.direccion + "   " + factura.telefono
        if (!factura) {
            flash.message = "No se encontró factura con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }
        return [factura: factura]

//        def consumoInstance = Consumo.get(params.id)
//        if (!consumoInstance) {
//            flash.message = "No se encontró Consumo con id " + params.id
//            flash.clase = "error"
//            flash.ico = "ss_delete"
//            redirect(action: "list")
//            return
//        }
//
//        [consumoInstance: consumoInstance]
    }

    def edit() {
        def consumoInstance = Consumo.get(params.id)
        if (!consumoInstance) {
            flash.message = "No se encontró Consumo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [consumoInstance: consumoInstance]
    }

    def delete() {
        def consumoInstance = Consumo.get(params.id)
        if (!consumoInstance) {
            flash.message = "No se encontró Consumo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        try {
            consumoInstance.delete(flush: true)
            flash.message = "Consumo  con id " + params.id + " eliminado"
            flash.clase = "success"
            flash.ico = "ss_accept"
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = "No se pudo eliminar Consumo con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "show", id: params.id)
        }
    }
}
