package cratos

class CuentasService {
    static scope = "session"

    def getCuentas(contabilidadId, empresaId) {
        def empresa = Empresa.get(empresaId)

        def contabilidad = Contabilidad.get(contabilidadId)
        def cuentas = Cuenta.findAllByEmpresa(empresa, [sort: "numero"])

        CuentaContable.findAllByContabilidad(contabilidad).each { cc ->
            if (cuentas.contains(cc.antiguo)) {
                cuentas.remove(cc.antiguo)
            }
        }

        return cuentas
    } // getCuentas

    //presupuesto

    def getPresupuesto(contabilidadId, empresaId) {
        def empresa = Empresa.get(empresaId)

        def presupuestos = Presupuesto.findAllByEmpresa(empresa, [sort: "padre"])

            return presupuestos
    } // getPresupuesto

     //asignaciones
    def getAsignacion (presupuestoId){

        def presupuesto = Presupuesto.get(presupuestoId)

        def asignaciones = AsignacionPresupuestaria.findAllByPresupuesto(presupuesto, [sort: "id"])


        return asignaciones
    }

    //gestor Contable
    def getGestor (contabilidadId, empresaId){

        def empresa = Empresa.get(empresaId)

        def contabilidad = Contabilidad.get(contabilidadId)

        def gestores = Gestor.findAllByEmpresa(empresa, [sort: "id"])

        return gestores


}

    def getGenera (gestorId){

      def gestor = Gestor.get(gestorId)

        def genera = Genera.findAllByGestor(gestor, [sort: "id"])

       return genera
    }
    
     //reporte comprobante
     def getComprobante(procesoId){
         
         def proceso = Proceso.get(procesoId)

         def comprobantes = Comprobante.findAllByProceso(proceso, [sort: "id"])

         return comprobantes
         
     }

    def getAsiento (comprobanteId){

         def comprobante = Comprobante.get(comprobanteId)

         def asiento = Asiento.findAllByComprobante(comprobante, [sort: "id"])

        return asiento
    }


   }