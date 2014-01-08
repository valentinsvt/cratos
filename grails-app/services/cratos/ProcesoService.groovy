package cratos

class ProcesoService {

    static transactional = true
    def dbConnectionService
    def kerberosoldService

    List registrar(proceso, perfil, usuario) {
        def lista = [true]
        def p = new Proceso()
        p = proceso
        def tipoComprobante = []
        def axc = [:] //asientos por comprobante
        def comprobantes = []
        def cc = ["actionName": "registroProceso", "controllerName": "proceso"] //campos comprobante
        def datosAsientos = []
        def asientos = []
        def ca = ["actionName": "registroProceso", "controllerName": "proceso"] //capos asiento
        println "movimientos " + p.gestor?.movimientos.toArray()
        def cont = 0
        def retencion = []
        def empresa = proceso.gestor.empresa
        //println "gestor "+p.gestor.id
        Genera.findAllByGestor(p.gestor).each {
            ca = ["actionName": "registroProceso", "controllerName": "proceso"]
            // println "add tpcp "+it.tipoComprobante +" id "+it.id
            if (!tipoComprobante.contains(it.tipoComprobante)) {
                tipoComprobante.add(it.tipoComprobante)
                axc.put(it.tipoComprobante.id, [cont])
            } else {
                axc[it.tipoComprobante.id].add(cont)
            }
            ca.put("cuenta.id", it.cuenta.id)


            def razon = ""
            if (it.debeHaber == "D") {
                razon = "debe"
            } else {
                razon = "haber"
            }
            def base = 0
            def valor = 0
            def porcentaje = 0
            if (it.valor > 0) {
                ca.put(razon, it.valor)
            } else {

                //println "porcentaje !!! "+it.porcentaje+"   valor  "+p.valor
                if (it.porcentaje > 0) {
                    valor += p.valor * (it.porcentaje / 100)
                    base = p.valor
                    porcentaje = it.porcentaje
                }
                if (it.porcentajeImpuestos > 0) {
                    valor += p.impuesto * (it.porcentajeImpuestos / 100)
                    base = p.impuesto
                    porcentaje = it.porcentajeImpuestos
                }
                // println "fin "+valor
                ca.put(razon, valor.toDouble().round(2))
            }

            if (it.cuenta.retencion == "S") {
                def tmp = [cuenta: it.cuenta.id, valor: valor, base: base, porcentaje: porcentaje]
                retencion.add(tmp)
            }

            //println "Asiento====> "+ca
            datosAsientos.add(ca)
            ca = []
            cont++
        }
        //println "axc "+axc
        tipoComprobante.each {
            def cn = dbConnectionService.getConnection()
            def num = null
            def sql = "SELECT max(CAST( c.cmprnmro AS int )) from cmpr c,prcs p,gstr g where c.prcs__id=p.prcs__id and p.gstr__id=g.gstr__id and g.empr__id=${empresa.id} and c.tpcp__id=${it.id}"
            // println "sql "+sql
            cn.eachRow(sql) { rs ->
                num = rs[0]
                //println "--> num "+num
            }

            if (num == null)
                num = 0

            switch (it.descripcion.trim()) {
                case "Diario":
                    cc.put("prefijo", empresa.prefijoDiario)
                    break;
                case "Egreso":
                    cc.put("prefijo", empresa.prefijoEgreso)
                    break;
                case "Ingreso":
                    cc.put("prefijo", empresa.prefijoIngreso)
                    break;
            }
            //println "prefijo "+cc["prefijo"]
            cc.put("tipo", it)
            cc.put("proceso", p)
            cc.put("numero", num + 1)
            cc.put("descripcion", p.descripcion)

            cc.put("fecha", proceso.fecha)
            // cc.put("factura",p.factura)
            cc.put("registrado", "N")
//            kerberosService.save(cc,Comprobante,perfil,usuario)
            def comprobante = new Comprobante(cc)
            comprobante.save(flush: true)
            // println "errores  comprobante "+comprobante.errors
            if (comprobante.errors.getErrorCount() != 0) {
                lista[0] = false
            } else {
                cont = 1
                comprobantes.add(comprobante)
                def debe = 0
                def haber = 0
                axc[comprobante.tipo.id].each { pos ->
                    datosAsientos[pos].put("comprobante.id", comprobante.id)
                    datosAsientos[pos].put("numero", cont)
                    //println "datosAsientos "+ datosAsientos[pos]+"----------------------- \n"
                    cont++
                    if (datosAsientos[pos].debe) {
                        debe += datosAsientos[pos].debe.toDouble()
                    }

                    if (datosAsientos[pos].haber) {
                        haber += datosAsientos[pos].haber.toDouble()
                    }


                    if (pos == datosAsientos.size() - 1) {
                        def indice = pos
                        def cuadrado = true
                        def tot = (proceso.valor + proceso.impuesto).toDouble().round(2)
                        haber = (tot - haber).toDouble().round(2)
                        debe = (tot - debe).toDouble().round(2)
                        println "cuadra ? " + debe + "  " + haber
                        if (Math.abs(haber) >= 0.01) {
                            cuadrado = false
                            println "mayor haber " + datosAsientos[indice].haber + "  indice " + indice
                            while (!cuadrado) {
                                if (datosAsientos[indice].haber) {
                                    println "encontro--> indice " + indice + " " + datosAsientos[indice].haber
                                    datosAsientos[indice].haber += haber
                                    println "cambio--> indice " + indice + " " + datosAsientos[indice].haber
                                    cuadrado = true
                                } else {
                                    indice--
                                }
                            }
//
//                            if(datosAsientos[indice].haber)
//                                datosAsientos[indice].haber+=haber
//                            else
//                                datosAsientos[indice].haber=haber
                            println "mayor debe " + datosAsientos[indice].haber + "  indice " + indice
                        }
                        if (Math.abs(debe) >= 0.01) {
                            cuadrado = false
                            println "menor " + datosAsientos[pos].debe + "  indice " + indice
                            while (!cuadrado) {
                                if (datosAsientos[indice].debe) {
                                    println "encontro--> indice " + indice + " " + datosAsientos[indice].debe
                                    datosAsientos[pos].debe += debe
                                    println "cambio--> indice " + indice + " " + datosAsientos[indice].debe
                                    cuadrado = true
                                } else {
                                    indice--
                                }
                            }
//                            if(datosAsientos[pos].debe)
//                                datosAsientos[pos].debe+=debe
//                            else
//                                datosAsientos[pos].debe=debe
                            println "menor despues" + datosAsientos[indice].debe + "  indice " + indice
                        }
                    }

                    //println "asientos!! "+datosAsientos[pos]+" pos "+pos+" size "+datosAsientos.size()+" dif "+dif


                }
                datosAsientos.each {
                    def asiento = new Asiento(it)
                    asiento.save(flush: true)
                    // println "errores asiento "+asiento.errors
                    if (asiento.errors.getErrorCount() != 0)
                        lista[0] = false
                    else
                        asientos.add(asiento)
                }
            }

        }


        if (lista[0] != false) {
            println "RETENCION "
            println retencion
            if (retencion.size() > 0) {
                def rt = new Retencion()
                rt.proceso = p
                rt.contabilidad = p.contabilidad
                rt.empresa = p.gestor.empresa
                rt.fecha = new Date()
                def l = Retencion.list([sort: "id", order: "desc", max: 3])

                /* TODO: ellos tienen que meter los numeros */
                def num
                if (l.size() > 0) {
                    num = l[0].numero.toInteger() + 1
                } else {
                    num = 1
                }

                rt.numero = num
                rt.numeroComprobante = ""
                rt.proveedor = p.proveedor
                if (p.proveedor.nombre)
                    rt.persona = p.proveedor.nombre
                else {
                    rt.persona = "" + p.proveedor.nombreContacto + " " + p.proveedor.apellidoContacto
                }
                rt.direccion = p.proveedor.direccion
                rt.telefono = p.proveedor.telefono
                rt.ruc = p.proveedor.ruc
                if (rt.save(flush: true)) {
                    retencion.each { dr ->
                        def detalle = new DetalleRetencion()
                        def cuenta = Cuenta.get(dr.cuenta)
                        detalle.retencion = rt
                        detalle.base = dr.base
                        detalle.cuenta = cuenta
                        detalle.porcentaje = dr.porcentaje
                        detalle.impuesto = cuenta.impuesto
                        detalle.total = (detalle.porcentaje/100)*detalle.base
                        if (!detalle.save(flush: true))
                            println "error detalle retencion " + detalle.errors
                    }
                } else {
                    println "error al generar elcomprobante " + rt.errors
                }
            }
            lista.add(comprobantes)
            lista.add(asientos)
            p.estado = "N"
            p.save()
        }


        return lista
    }


    def contabilizar(proceso) {
        def comprobantes = Comprobante.findAllByProceso(proceso)
        def msg = ""
        comprobantes.each {
            msg += kerberosoldService.ejecutarProcedure("mayorizar", [it.id, 1]) + ";"
            println "resultado mayorizar " + msg
            it.registrado = "S"
            it.save(flush: true)
        }
        proceso.estado = "R"
        proceso.save(flush: true)
        return msg
    }

    def desContabilizar(proceso) {
        def comprobantes = Comprobante.findAllByProceso(proceso)
        def msg = ""
        comprobantes.each {
            msg += kerberosoldService.ejecutarProcedure("mayorizar", [it.id, 0]) + ";"
            println "resultado mayorizar " + msg
            it.registrado = "N"
        }
        proceso.estado = "N"
        proceso.save(flush: true)
        return msg
    }

}
