package cratos

class GestorContableController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def gestorContableService
    def buscadorService
    def kerberosoldService
    def index = {
        gestorContableService.vaciarLista()
    }

    def buscarGestor() {
        gestorContableService.vaciarLista()
        println "parasm " + params
        def lista = buscadorService.buscar(Gestor, "Gestor", "incluyente", [campos: ["nombre", "descripcion"], criterios: [params.nombre, params.nombre], operadores: ["like", "like"], ordenado: "nombre", orden: "asc"], true)
        def numRegistros = lista.get(lista.size() - 1)
        lista.pop()
        return [lista: lista]
    }

    def nuevoGestor() {
        println "nuevo gestor " + params
        gestorContableService.vaciarLista()
        def gestorInstance
        def nuevo = true
        def tipoCom
        if (params.id) {
            nuevo = false
            gestorInstance = Gestor.get(params.id.toLong())
            println "gestor " + gestorInstance
            def movs = gestorInstance.movimientos.toArray()
            if (movs.size() > 0) {
                movs.each {
                    println "add " + it
                    tipoCom = it.tipoComprobante
                    gestorContableService.cuentas.add(it)
                }
                println "cuentas " + gestorContableService.cuentas
                gestorContableService.tipo = movs[0]?.tipoComprobante?.id
                println "cambio tipo " + gestorContableService.tipo

            }
        } else {
            gestorContableService.vaciarLista()
            gestorInstance = new Gestor()
        }
        //println "nuevo gestor "+gestorInstance
        render(view: 'gestorForm', model: [gestorInstance: gestorInstance, nuevo: nuevo, tipoCom: tipoCom])
    }

    def buscarCuentas() {
        println "buscar cuentas!!! " + params

        def descripcion = (params.nombre) ?: null
        def numero = (params.codigo) ?: null
        def res = buscadorService.buscar(Cuenta, "Cuenta", "excluyente", [campos: ["descripcion", "numero", "movimiento"], criterios: [descripcion, numero, "1"], operadores: ["like", "like der", "="], ordenado: "numero", orden: "asc"], true)
        def numRegistros = res.get(res.size() - 1)
        res.pop()
        return [planCuentas: res]
    }

    def cargarCuentas() {
        println "cuentas !!!!! " + gestorContableService.cuentas
        render(view: 'agregarCuenta', model: [cuentas: gestorContableService.cuentas])
    }

    def cambiarComprobante() {
        def tipo = TipoComprobante.get(params.tc)
        gestorContableService.cambiaTipoComprobante(tipo)
        render(view: 'agregarCuenta', model: [cuentas: gestorContableService.cuentas])
    }

    def agregarCuenta() {
        println "agregar cuenta !! " + params
        if (params.posicion) {
            if (!params.eliminar) {
                gestorContableService.cuentas[params.posicion.toInteger()].porcentaje = params.por.toDouble()
                gestorContableService.cuentas[params.posicion.toInteger()].porcentajeImpuestos = params.imp.toDouble()
                gestorContableService.cuentas[params.posicion.toInteger()].valor = params.val.toDouble()
            } else {
                println "tam " + gestorContableService.cuentas.size() + " pos " + params.posicion
                gestorContableService.cuentas.remove(params.posicion.toInteger())
            }

        } else {
            def genera = new Genera()
            def cuenta = Cuenta.get(params.id)
            def tipo = TipoComprobante.get(params.tc)
            genera.cuenta = cuenta
            genera.tipoComprobante = tipo
            println "tipo comprobante  " + tipo
            genera.debeHaber = (params.razon == "Debe") ? "D" : "H"
            //GestorService.cambiaTipoComprobante(tipo)
            gestorContableService.cuentas.add(genera)

        }
        gestorContableService.cuentas = gestorContableService.ordenarLista(gestorContableService.cuentas)
        println "cuentas !22#asfasfasfasdasdasd " + gestorContableService.cuentas
        return [cuentas: gestorContableService.cuentas]
    }

    def save() {
        params.movimientos = null
        println "params save!!! " + params + " id " + params.id
        def p
        if (params.id == null || params.id == "") {
            println "save "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
//        p=kerberosService.save(params,Gestor,session.perfil,session.usuario)
                p = new Gestor(params)
                p.fecha = new Date()
                p.empresa = session.empresa
                p.save(flush: true)
                println "errores gestor  " + p.properties.errors
                println "empeiza genera"
                if (gestorContableService.cuentas.size() > 0) {
                    println "gestor " + p
                    gestorContableService.cuentas.each {
                        println "  size!!!!!!  " + gestorContableService.cuentas.size()
                        it.gestor = p
                        println " save genera " + it + " " + it.save()
                        p.addToMovimientos(it)
                    }

                    gestorContableService.cuentas = []
                }
                flash.message = "Registro insertado"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
            }
        } else {
            println "edit "
            try {
                params.controllerName = controllerName
                params.actionName = actionName
                params.estado = "A"
//                kerberosService.save(params,Gestor,session.perfil,session.usuario)
                p = Gestor.get(params.id)
                p.properties = params
                p.save(flush: true)
                println "errores " + p.properties.errors
                def lista = []
                def generaAntiguos = Genera.findAllByGestor(p)
                if (gestorContableService.cuentas.size() > 0) {
                    println "  size!!!!!!  " + gestorContableService.cuentas.size() + " \n\n\n\n\n"
                    def genera
                    gestorContableService.cuentas.each {
                        println "cuentas  ==> " + it.id
                        if (it.id == null) {
                            println "save cuenta"
                            it.gestor = p
                            println " save new " + it + " " + it.save()
                            p.addToMovimientos(it)
                        } else {
                            println "edit cuenta"
                            genera = Genera.get(it.id)
                            genera.porcentaje = it.porcentaje
                            genera.porcentajeImpuestos = it.porcentajeImpuestos
                            genera.valor = it.valor
                            println "tipo  !! " + gestorContableService.tipo
                            if (gestorContableService.tipo)
                                genera.tipoComprobante = TipoComprobante.get(gestorContableService.tipo.toLong())
                            println " datos " + it.porcentajeImpuestos + " " + it.porcentaje + " " + it.valor
                            println "paso genera " + genera
                            genera.save(flush: true)
                            lista.add(it.id)
                            println " save edit " + genera + " " + genera.save()
                            genera = null
                        }

                    }
                    generaAntiguos.each {
                        if (!lista.contains(it.id)) {
                            it.delete()
                        }
                    }

                    p.save()
                    gestorContableService.cuentas = []
                }
                flash.message = "Registro insertado"
                redirect(action: 'index')
            } catch (Exception e) {
                println "catch " + e
                render(view: 'gestorForm', model: ['GestorInstance': p], error: true)
            }
        }
    }

    def verGestor() {

        def gestor = Gestor.get(params.id)
        def c = Genera.findAllByGestor(gestor)
        println "ver gestor "
        c.each {
            println "it " + it + " tipo " + it.tipoComprobante.id
        }
        gestorContableService.cuentas = Genera.findAllByGestor(gestor)
        //println "cuentas "+GestorService.cuentas[0].tipoComprobante
        if (!gestor) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'Gestor.label', default: 'Gestor'), params.id])}"
            redirect(action: "index")
        } else {
            [gestor: gestor, cuentas: gestorContableService.cuentas]
        }
    }

    def editarGestor() {
        def gestor = Gestor.get(params.id)
        if (!gestor) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'Gestor.label', default: 'Gestor'), params.id])}"
            redirect(action: "index")
        } else {
            render(view: 'gestorForm', model: [GestorInstance: gestor])
        }
    }

    def deleteGestor() {
        def gestor = Gestor.get(params.id)
        if (!gestor) {
            flash.message = "No se ha encontrado el gestor a eliminar"
            return
        }

        def adquisiciones = Adquisiciones.findAllByGestor(gestor)
        def facturas = Factura.findAllByGestor(gestor)
        def procesos = Proceso.findAllByGestor(gestor)

        if (adquisiciones.size() == 0 && facturas.size() == 0 && procesos.size() == 0) {
            def generas = Genera.findAllByGestor(gestor)
            generas.each { gen ->
                try {
                    gen.delete(flush: true)
                } catch (e) {
                    println e.stackTrace
                }
            }
            try {
                gestor.delete(flush: true)
            } catch (e) {
                println e.stackTrace
            }
            redirect(action: "index")
        } else {
            def msn = "El gestor se utiliza en "
            if (adquisiciones.size() > 0) {
                msn += adquisiciones.size() + " adquisici" + (adquisiciones.size() == 1 ? "ón, " : "ones, ")
            }
            if (facturas.size() > 0) {
                msn += facturas.size() + " factura" + (facturas.size() == 1 ? ", " : "s, ")
            }
            if (procesos.size() > 0) {
                msn += procesos.size() + " proceso" + (procesos.size() == 1 ? ", " : "s, ")
            }
            msn += " por lo que no puede ser eliminado."
            return [msn: msn, gestor: gestor]
        }
    }

}
