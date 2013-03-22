package cratos.utilitarios

class FuncionesController extends cratos.seguridad.Shield{


    def arreglaCuentas(){
        def cuentas = cratos.Cuenta.findAllByEmpresa(session.empresa,[sort:"numero"])
        def arregladas =[]
        cuentas.each {c->
//            println "cuenta "+c.numero
            def hijos = cratos.Cuenta.findAllByPadre(c)
//            println "hijos "+hijos.size()
            if (hijos.size()>0){
                if (c.movimiento!="0"){
//                    println "es diferente "+c.movimiento
                    c.movimiento="0"
                    c.save(flush: true)
                    arregladas.add(c)
                }

            }else{
                if (c.movimiento!="1"){
//                    println "es diferente 1 "+c.movimiento
                    c.movimiento="1"
                    c.save(flush: true)
                    arregladas.add(c)
                }
            }

        }

        [arregladas:arregladas]
    }

    def gestorSaldos(){
        def gestor
        gestor = cratos.Gestor.findByNombreAndDescripcion("Saldos iniciales - cratos","Saldos iniciales - cratos")
        if (!gestor){
            gestor= new cratos.Gestor()
            gestor.nombre="Saldos iniciales - cratos"
            gestor.descripcion="Saldos iniciales - cratos"
            gestor.empresa=session.empresa
            gestor.estado="A"
            gestor.fecha=new Date()
            gestor.fuente=cratos.Fuente.get(1)
            gestor.observaciones="Saldos iniciales - cratos"
            if (!gestor.save(flush: true)){
               println "error al crear el gestor "+ gestor.errors
            }
        }

//        def gnra = cratos.Genera.findAllByGestor(gestor)
//        def cuentasGnra= gnra.cuenta
        def cuentas = cratos.Cuenta.findAllByMovimiento("1",[sort: "numero"])
        cuentas.each {c->
         def gnra = cratos.Genera.findByCuentaAndGestor(c,gestor)
            if (!gnra){
                gnra= new cratos.Genera()
                gnra.gestor=gestor
                gnra.cuenta=c
                gnra.porcentaje=0
                gnra.porcentajeImpuestos=0
                gnra.valor=0
                gnra.debeHaber="D"
                gnra.tipoComprobante=cratos.TipoComprobante.get(3)
                if (!gnra.save(flush: true)){
                    println "error save gnra "+gnra.errors
                }
            }
        }

        redirect(controller: 'gestorContable',action: 'nuevoGestor',params: [id:gestor.id])

    }



}
