package cratos

class PagosController extends cratos.seguridad.Shield {

    def conciliacionBancaria() {
        def emp = Empresa.get(session.empresa.id)
        def pagos = PagoAux.withCriteria {
            eq("tipoDocumento", TipoDocumento.get(1)) //cheque
            auxiliar {
                proveedor {
                    eq("empresa", emp)
                }
            }
            or {
                ne("estado", "V")
                isNull("estado")
            }
            order("fecha", "asc")
        }
        return [pagos: pagos]
    }

    def validarPagoAux() {
        params.each { k, v ->
            if (!k.startsWith("_") && v == "on") {
                println k + "    " + v
                def pago = PagoAux.get(k)
                pago.estado = 'V'
                if (!pago.save(flush: true)) {
                    println "error al guardar el pago " + k
                }
            }
        }
        redirect(action: "conciliacionBancaria")
    }

}