package cratos

class Reportes3Controller {

    def dbConnectionService
    def cuentasService
    def buscadorService
    def kerberosoldService

    def reporteComprobante() {
        def contabilidad = params.cont
        def numComp = params.num
        def tipoComp = params.tipo

        def comp = Comprobante.withCriteria {
            proceso {
                eq("contabilidad", Contabilidad.get(contabilidad))
            }
            eq("numero", numComp)
            eq("tipo", TipoComprobante.get(tipoComp))
        }
        if (comp) {
            if (comp.size() == 1) {
                render comp[0].procesoId
            } else {
                render "NO_Se encontró más de un comprobante"
            }
        } else {
            render "NO_No se encontró el comprobante"
        }
    }

    /*Reporte de cuentas por pagar
    * Sale de la tabla de axlr (plan de pagos)
    * Las pagas en teoria crean un registro en la tabla pagos
    * */

    def reporteCxP() {
//        println "reporte cxp "+params
//        params.empresa=1
//        params.fechaInicio="01/03/2013"
//        params.fechaFin="31/04/2013"
        def fechaInicio = new Date().parse("yyyy-MM-dd", params.fechaInicio)
        def fechaFin = new Date().parse("yyyy-MM-dd", params.fechaFin)
        def empresa = Empresa.get(params.empresa)
        def axl = Auxiliar.findAllByFechaPagoBetweenAndDebeGreaterThan(fechaInicio, fechaFin, 0, [sort: "fechaPago"])
        def cxp = []
        def valores = [:]
        axl.each { a ->
            if (a.asiento.cuenta.empresa.id.toInteger() == params.empresa.toInteger()) {
                def pagos = PagoAux.findAllByAuxiliar(a)
                def pagado = 0
                pagos.each { p ->
                    pagado += p.monto
                }
                if (pagado < a.debe) {
                    cxp.add(a)
                    valores.put(a.id, a.debe - pagado)
                }
            }
        }
        [cxp: cxp, empresa: empresa, fechaInicio: fechaInicio, fechaFin: fechaFin, valores: valores]

    }

    def auxiliarPorCliente() {
//        println "\n\n\n\n"
//        println params

        if (!params.cli) {
            params.cli = "-1"
        }

//        params.cont = 1
//        params.per = 10
//        params.cli = -1
//        params.emp = 1
//
//        println params
//        println "\n\n\n\n"
        def html = "", header = ""
        if (!params.per || !params.cli || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.cli) {
                html += "<li>Seleccione un cliente</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)
            def cliente = Proveedor.get(params.cli)
            if (params.cli == "-1" || params.cli == -1) {
                cliente = Proveedor.list()
            }
            if (!empresa || !periodo || !cliente) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += "<li>No se encontró el periodo " + params.per + "</li>"
                }
                if (!cliente) {
                    html += "<li>No se encontró el cliente " + params.cli + "</li>"
                }
                if (!empresa) {
                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                }
                html += "</ul>"
                html += "</div>"
            } else {

                header += "<h1>" + empresa.nombre + "</h1>"
                header += "<h2>AUXILIAR POR CLIENTES</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def cn = dbConnectionService.getConnection()
                def cn2 = dbConnectionService.getConnection()

                def sql = "select\n" +
                        "        u.cnta__id              cuenta_id,\n" +
                        "        u.cntanmro              cuenta_num,\n" +
                        "        u.cntadscr              cuenta_desc,\n" +
                        "        r.prve__id              cli_id,\n" +
                        "        r.prve_ruc              cli_ruc,\n" +
                        "        r.prvenmbr              cli_nombre,\n" +
                        "        r.prvenbct              cli_nombrecontacto,\n" +
                        "        r.prveapct              cli_apellidocontacto,\n" +
                        "        x.axlrfcrg              fecha,\n" +
                        "        p.prcs__id              trans,\n" +
                        "        c.cmpr__id              comp,\n" +
                        "        t.tpcpdscr              tipocomp,\n" +
                        "        x.axlrdscr              descripcion,\n" +
                        "        x.axlrdebe              debe,\n" +
                        "        x.axlrhber              haber,\n" +
                        "        x.axlrdebe-x.axlrhber   saldo\n" +
                        "  from axlr x,\n" +
                        "          asnt s,\n" +
                        "          cmpr c,\n" +
                        "          prcs p,\n" +
                        "          tpcp t,\n" +
                        "          cnta u,\n" +
                        "          prve r\n" +
                        "  where x.asnt__id = s.asnt__id\n" +
                        "          and s.cmpr__id = c.cmpr__id\n" +
                        "          and c.prcs__id = p.prcs__id\n" +
                        "          and c.tpcp__id = t.tpcp__id\n" +
                        "          and s.cnta__id = u.cnta__id\n" +
                        "          and x.prve__id = r.prve__id\n" +
                        "          and u.empr__id = ${params.emp}\n" +
                        "          and c.cmprrgst = 'S'"
                "          and\n" +
                        "          c.cmprfcha >=\n" +
                        "                  (select prdofcin from prdo where prdo__id = ${params.per})\n" +
                        "          and\n" +
                        "          c.cmprfcha <=\n" +
                        "                  (select prdofcfn from prdo where prdo__id = ${params.per})"

//                println sql

                if (params.cli != -1 && params.cli != "-1") {
                    sql += "          and r.prve__id = ${params.cli}\n"
                }
                sql += " order by cuenta_id asc, cli_nombre asc, fecha asc"


                def cuentaId = null, cliId = null
                cn.eachRow(sql) { rs ->

//            println rs
                    def b = false
                    if (rs["cuenta_id"] != cuentaId) {
                        if (html != "") {
                            html += "</table>"
                        }
                        html += "<h1 class='cuenta'>Cuenta contable: " + rs["cuenta_num"] + " " + rs["cuenta_desc"] + "</h1>"
                        html += "<table border='1'>"
                        cuentaId = rs["cuenta_id"]
                        b = true
                    }
                    if (rs["cli_id"] != cliId || b) {

                        if (b) {
                            html += "<tr>"
                            html += "<th>Fecha</th>"
                            html += "<th>Trans.</th>"
                            html += "<th>Comp.</th>"
                            html += "<th>Tipo</th>"
                            html += "<th>Descripción</th>"
                            html += "<th>Debe</th>"
                            html += "<th>Haber</th>"
                            html += "<th>Saldo</th>"
                            html += "</tr>"
                        }

                        def sql2 = "select\n" +
                                "        u.cnta__id                    cuenta_id,\n" +
                                "        x.prve__id                    cli_id,\n" +
                                "        sum(x.axlrdebe-x.axlrhber)    saldo\n" +
                                "  from axlr x,\n" +
                                "          asnt s,\n" +
                                "          cmpr c,\n" +
                                "          prcs p,\n" +
                                "          cnta u\n" +
                                "  where x.asnt__id = s.asnt__id\n" +
                                "          and s.cmpr__id = c.cmpr__id\n" +
                                "          and c.prcs__id = p.prcs__id\n" +
                                "          and s.cnta__id = u.cnta__id\n" +
                                "          and u.empr__id = ${params.emp}\n" +
                                "          and x.prve__id = ${rs['cli_id']}\n" +
                                "          and u.cnta__id = ${rs['cuenta_id']}\n" +
                                "          and\n" +
                                "          c.cmprfcha <\n" +
                                "                  (select prdofcin from prdo where prdo__id=10)\n" +
                                "  group by cuenta_id, cli_id\n" +
                                "  order by cuenta_id asc;"

                        html += "<tr class='cliente'>"
                        html += "<th colspan='5'>"
                        html += "<b>Persona:</b> " + rs["cli_ruc"]
                        if (rs["cli_nombre"]) {
                            html += " " + rs["cli_nombre"]
                        }
                        html += " (" + rs["cli_nombrecontacto"] + " " + rs["cli_apellidocontacto"] + ")"
                        html += "</th>"

                        html += "<th colspan='2' class='right'>Saldo inicial:</th>"

                        html += "<th class='right'>"
                        def b2 = false
                        cn2.eachRow(sql2) { r ->
                            html += r["saldo"]
                            b2 = true
                        }
                        if (!b2) {
                            html += "0.00"
                        }
                        html += "</th>"

                        html += "</tr>"
                        cliId = rs["cli_id"]
                    }

                    html += "<tr>"
                    html += "<td width='80'>" + rs["fecha"].format("dd-MM-yyyy") + "</td>"
                    html += "<td width='80'>" + rs["trans"] + "</td>"
                    html += "<td width='80'>" + rs["comp"] + "</td>"
                    html += "<td width='80'>" + rs["tipocomp"] + "</td>"
                    html += "<td width='180'>" + rs["descripcion"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["debe"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["haber"] + "</td>"
                    html += "<td width='80' class='right'>" + rs["saldo"] + "</td>"
                    html += "</tr>"
                }
                if (html != "") {
                    println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + html.contains("<table")
                    if (html.contains("<table")) {
                        html += "</table>"
                    }
                } else {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para el reporte"
                    html += "</div>"
                }
                cn.close()
                cn2.close()
            }
        }

        html = header + html
//        println html
        return [html: html]
    }

    def getCuentas(html, cuenta, per) {
//        println cuenta
        html += "<tr class='cuenta'>"
        html += "<td class='numero'>" + cuenta.numero + "</td>"
        html += "<td class='nombre'>" + cuenta.descripcion + "</td>"
        html += "<td class='valor ${cuenta.nivel.descripcion.trim().toLowerCase()}'>"
        def saldos = SaldoMensual.findAllByCuentaAndPeriodo(cuenta, per)
        def saldoInit = 0
        saldos.each {
            it.refresh()
            saldoInit += (it.saldoInicial + it.debe - it.haber)
        }
        html += g.formatNumber(number: saldoInit, maxFractionDigits: 2, minFractionDigits: 2)
        html += "</td>"
        html += "</tr>"

//        println "\t" + cuenta.movimiento
        if (cuenta.movimiento == "0") {
//            println "\t "+Cuenta.countByPadre(cuenta)
            Cuenta.findAllByPadre(cuenta).each { cuentaHija ->
                html = getCuentas(html, cuentaHija, per)
            }
        } else {
//            println "\t"+Asiento.countByCuenta(cuenta)
            Asiento.findAllByCuenta(cuenta).each { asiento ->
                html += "<tr class='asiento'>"
                html += "<td class='numero'> </td>"
                html += "<td class='nombre'>"
                if (asiento.comprobante.proceso?.proveedor) {
                    if (asiento.comprobante.proceso?.proveedor?.nombre) {
                        html += asiento.comprobante.proceso?.proveedor?.nombre
                    } else if (asiento.comprobante.proceso?.proveedor?.nombreContacto) {
                        html += asiento.comprobante.proceso?.proveedor?.nombreContacto + " " + asiento.comprobante.proceso?.proveedor?.apellidoContacto
                    } else {
                        html += ""
                    }
                } else {
                    html += ""
                }

                html += "</td>"
                html += "<td class='valor asiento'>"
                html += g.formatNumber(number: asiento.debe - asiento.haber, minFractionDigits: 2, maxFractionDigits: 2)
                html += "</td>"
                html += "</tr>"
            }
        }

        return html
    }


    def balanceGeneralAuxiliares() {
//        println params
//        params.emp = 1
//        params.per = 10

        def html = "", header = ""

        if (!params.per || !params.emp || params.per == "undefined") {
            html += "<div class='errorReporte'>"
            html += "Faltan datos para generar el reporte: <ul>"
            if (!params.per || params.per == "undefined") {
                html += "<li>Seleccione un periodo</li>"
            }
            if (!params.emp) {
                html += "<li>Verifique su sesión</li>"
            }
            html += "</ul>"
            html += "</div>"
        } else {
            def empresa = Empresa.get(params.emp)
            def periodo = Periodo.get(params.per)

            if (!empresa || !periodo) {
                html += "<div class='errorReporte'>"
                html += "Error de datos al generar el reporte: <ul>"
                if (!periodo) {
                    html += "<li>No se encontró el periodo " + params.per + "</li>"
                }
                if (!empresa) {
                    html += "<li>No se econtró la empresa " + params.emp + "</li>"
                }
                html += "</ul>"
                html += "</div>"
            } else {

                def sp = kerberosoldService.ejecutarProcedure("saldos", periodo.contabilidadId)

                header += "<h1>" + empresa.nombre + "</h1>"
                header += "<h2>ESTADO DE SITUACION FINANCIERA (BALANCE GENERAL CON AUXILIARES)</h2>"
                header += "<h3>Movimiento desde " + periodo.fechaInicio.format("dd-MM-yyyy") + "    hasta " + periodo.fechaFin.format("dd-MM-yyyy") + "</h3>"

                def tabla = ""

                Cuenta.findAllByEmpresaAndNivel(empresa, Nivel.get(1)).each { cuenta ->
                    tabla = getCuentas(tabla, cuenta, periodo)
                }

                if (tabla == "") {
                    html += "<div class='errorReporte'>"
                    html += "No se encontraron datos para generar el reporte"
                    html += "</div>"
                } else {
                    html = "<table border='1'>"
                    html += tabla

                    def dos = valores(empresa, "2", periodo)
                    def tres = valores(empresa, "3", periodo)
                    def cuatro = valores(empresa, "4", periodo)
                    def cinco = valores(empresa, "5", periodo)
                    def seis = valores(empresa, "6", periodo)
                    def siete = valores(empresa, "7", periodo)

                    html += "<tr class='resultado'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>RESULTADO DEL EJERCICIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: ((cuatro + seis) - (cinco + siete)), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "<tr class='total'>"
                    html += "<td class='numero'> </td>"
                    html += "<td class='nombre'>TOTAL PASIVO + PATRIMONIO</td>"
                    html += "<td class='valor'>"
                    html += g.formatNumber(number: (dos + tres), maxFractionDigits: 2, minFractionDigits: 2)
                    html += "</td>"
                    html += "</tr>"

                    html += "</table>"

                }
            }
        }


        html = header + html
//        println html
        return [html: html]
    }

    def valores(empresa, nivel, periodo) {
        def valor = SaldoMensual.withCriteria {
            eq("cuenta", Cuenta.findByEmpresaAndNumero(empresa, nivel))
            eq("periodo", periodo)
        }
        if (valor.size() == 1) {
            valor = valor[0]
            valor.refresh()
            valor = valor.saldoInicial + valor.debe - valor.haber
            return valor
        } else if (valor.size() == 0) {
            return 0
        } else {
            println "HAY MAS DE 1 SALDO INICIAL PARA " + nivel
            return 0
        }
    }

    def imprimirRetencion() {
        def empresa = Empresa.get(params.empresa)
        def proceso = Proceso.get(params.id)
        def retencion = Retencion.findByProceso(proceso)

        def meses = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]

        [empresa: empresa, retencion: retencion, meses: meses, proceso: proceso]
    }

}