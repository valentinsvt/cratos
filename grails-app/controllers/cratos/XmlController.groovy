package cratos

import groovy.xml.MarkupBuilder

class XmlController extends cratos.seguridad.Shield {
    def test1() {
        def writer = new StringWriter()
//        def xml = new MarkupBuilder(writer)

        def xml = new MarkupBuilder(writer)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")

        xml.records() {
            car(name: 'HSV Maloo', make: 'Holden', year: 2006) {
                country('Australia')
                record(type: 'speed', 'Production Pickup Truck with speed of 271kph')
            }
            car(name: 'P50', make: 'Peel', year: 1962) {
                country('Isle of Man')
                record(type: 'size', 'Smallest Street-Legal Car at 99cm wide and 59 kg in weight')
            }
            car(name: 'Royale', make: 'Bugatti', year: 1931) {
                country('France')
                record(type: 'price', 'Most Valuable Car at $15 million')
            }
        }

        println writer.toString()
        render writer.toString()
    } //test1

    def xml() {
        def hoy = new Date()
        def anioFin = hoy.format("yyyy").toInteger()
        def anios = []
        5.times {
            def p = getPeriodosByAnio(anioFin - it)
            if (p.size() > 0) {
                anios.add(anioFin - it)
            }
        }
        def per = Periodo.withCriteria {
            ge("fechaInicio", new Date().parse("dd-MM-yyyy", "01-01-" + hoy.format("yyyy")))
            le("fechaFin", getLastDayOfMonth(hoy))
            order("fechaInicio", "asc")
        }
        def periodos = []
        per.each { p ->
            def key = p.fechaInicio.format("MM")
            def val = fechaConFormato(p.fechaInicio, "MMMM yyyy").toUpperCase()
            def m = [:]
            m.id = key
            m.val = val
            periodos.add(m)
        }
        return [anios: anios, periodos: periodos]
    }

    def getPeriodos() {
        println "getPeriodos " + params
        def periodos = getPeriodosByAnio(params.anio)
        render g.select(name: "mes", from: periodos, optionKey: "id", optionValue: "val")
    }

    def getPeriodosByAnio(anio) {
        def per = Periodo.withCriteria {
            ge("fechaInicio", new Date().parse("dd-MM-yyyy", "01-01-" + anio))
            le("fechaFin", new Date().parse("dd-MM-yyyy", "31-12-" + anio))
            order("fechaInicio", "asc")
        }
        def periodos = []
        per.each { p ->
            def key = p.fechaInicio.format("MM")
            def val = fechaConFormato(p.fechaInicio, "MMMM yyyy").toUpperCase()
            def m = [:]
            m.id = key
            m.val = val
            periodos.add(m)
        }
        return periodos
    }

    def errores() {
        return [params: params]
    }


    def createXml() {
        def primero = new Date().parse("dd-MM-yyyy", "01-${params.mes}-" + params.anio)

        def override = false
        def sobreescribe = [1, "1", true, "true"]
        if (sobreescribe.contains(params.override)) {
            override = true
        }

        def per = Periodo.withCriteria {
            ge("fechaInicio", primero)
            le("fechaFin", getLastDayOfMonth(primero))
            order("fechaInicio", "asc")
        }

        def empresa = Empresa.get(session.empresa.id)

//        def fechaInicio = new Date().parse("dd-MM-yyyy", "01-11-2013")
//        def fechaFin = new Date().parse("dd-MM-yyyy", "30-11-2013")

//        def fechaInicio = new Date().parse("dd-MM-yyyy", "01-12-2013")
//        def fechaFin = new Date().parse("dd-MM-yyyy", "31-12-2013")

//        def periodo = Periodo.get(24) //noviembre 2013
//        def periodo = Periodo.get(25) //diciembre 2013
        def periodo

        if (per.size() == 1) {
            periodo = per.first()
        } else if (per.size() == 0) {
            flash.message = "No se encontró un periodo para generar el archivo XML"
            redirect(action: "errores")
            return
        } else {
            flash.message = "Ha ocurrido un error grave: se encontraron ${per.size()} periodos para ${params.mes}-${params.anio}"
            redirect(action: "errores")
            return
        }

        def procesos = Proceso.withCriteria {
            ge("fecha", periodo.fechaInicio)
            le("fecha", periodo.fechaFin)
        }// todos los procesos entre fecha ini y fecha fin

        def writer = new StringWriter()

        def xml = new MarkupBuilder(writer)
        xml.mkp.xmlDeclaration(version: "1.0", encoding: "UTF-8", standalone: "no")

        xml.iva() {
            TipoIDInformante('R')
            IdInformante(empresa.ruc)
            razonSocial(empresa.nombre)
            Anio(periodo.fechaInicio.format("yyyy"))
            Mes(periodo.fechaInicio.format("MM"))
            totalVentas(0.00)
            codigoOperativo("IVA")
            compras() {
                procesos.each { proceso ->
                    def retencion = Retencion.findByProceso(proceso)
                    def detalleRetencion = []
                    def ice = null, bns = null, srv = null
                    def local = "01"
                    if (retencion) {
                        detalleRetencion = DetalleRetencion.findByRetencion(retencion)
                        detalleRetencion.each { dr ->
                            if (dr.impuesto?.sri == 'ICE') {
                                ice = dr
                            } else if (dr.impuesto?.sri == 'BNS') {
                                bns = dr
                            } else if (dr.impuesto?.sri == 'SRV') {
                                srv = dr
                            }
                        }
                        local = retencion.tipoPago
                    }
                    detalleCompras() {
                        codSustento(proceso.sustentoTributario?.codigo)
                        tpIdProv(proceso.proveedor?.tipoIdentificacion?.codigoSri)
                        idProv(proceso.proveedor?.ruc)
                        tipoComprobante(proceso.tipoComprobanteSri?.codigo)
                        fechaRegistro(fechaConFormato(proceso.fechaIngresoSistema))
                        establecimiento(proceso.facturaEstablecimiento)
                        puntoEmision(proceso.facturaPuntoEmision)
                        secuencial(proceso.facturaSecuencial)
                        fechaEmision(fechaConFormato(proceso.fecha))
                        autorizacion(proceso.proveedor?.autorizacionSri)
                        baseNoGraIva(numero(proceso.baseImponibleNoIva))
                        baseImponible(numero(proceso.baseImponibleIva0))
                        baseImpGrav(numero(proceso.baseImponibleIva))
                        montoIce(numero(ice?.total ?: 0))
                        montoIva(numero(proceso?.ivaGenerado ?: 0))
                        valorRetBienes(numero(bns?.total))
                        valorRetServicios(srv?.porcentaje == 100 ? numero(0) : numero(srv?.total ?: 0))
                        valRetServ100(srv?.porcentaje == 100 ? numero(srv?.total ?: 0) : numero(0))
                        pagoExterior() {
                            pagoLocExt(local)
                            if (local == "01") {
                                paisEfecPago("NA")
                                aplicConvDobTrib("NA")
                                pagExtSujRetNorLeg("NA")
                            } else {
                                paisEfecPago(retencion.pais?.codigo)
                                aplicConvDobTrib(retencion.convenio)
                                pagExtSujRetNorLeg(retencion.normaLegal)
                            }
                        }
                        estabRetencion1(retencion?.numeroEstablecimiento)
                        ptoEmiRetencion1(retencion?.numeroPuntoEmision)
                        secRetencion1(retencion?.numeroSecuencial)
                        autRetencion1(retencion?.numeroAutorizacionComprobante)
                        fechaEmiRet1(fechaConFormato(retencion?.fechaEmision))
                    }
                }
            }
        }

        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa.id + "/"  //web-app/xml
        def fileName = "AnexoTransaccional_" + fechaConFormato(periodo.fechaInicio, "MM_yyyy")
        def ext = ".xml"
        def path = pathxml + fileName + ext

        new File(pathxml).mkdirs()

        def file = new File(path)

        def cont = true
        if (file.exists()) {
            cont = false
        }

        if (!cont && !override) {
//            redirect(action: "errores", params: [tipo: 1, periodo: periodo.toString(), mes: params.mes, anio: params.anio])
            render "NO_1"
        } else {
//            file.append(writer.toString())
            file.write(writer.toString())
            render "OK"
//            def output = response.getOutputStream()
//            def header = "attachment; filename=" + fileName;
//            response.setContentType("application/xml")
//            response.setHeader("Content-Disposition", header);
//            output.write(file.getBytes());
        }
    }

    def downloadFile() {
//        println "DownloadFile: " + params
        def mes = params.mes
        def anio = params.anio

        def empresa = Empresa.get(session.empresa.id)
        def pathxml = servletContext.getRealPath("/") + "xml/" + empresa.id + "/"  //web-app/xml
        def fileName = "AnexoTransaccional_" + mes + "_" + anio
        def ext = ".xml"
        def path = pathxml + fileName + ext
        new File(pathxml).mkdirs()
        def file = new File(path)

        if (file.exists()) {
            def b = file.getBytes()
            response.setContentType("application/xml")
            response.setHeader("Content-disposition", "attachment; filename=" + fileName + ext)
            response.setContentLength(b.length)
            response.getOutputStream().write(b)

        } else {
            redirect(action: "errores", params: [tipo: 2])
        }
    }

    def downloads() {
        def empresa = Empresa.get(session.empresa.id)
        def baseFolder = servletContext.getRealPath("/") + "xml/" + empresa.id + "/"  //web-app/xml
        def baseDir = new File(baseFolder)
        def list = []
        baseDir.eachFileMatch(~/.*.xml/) { file ->
            def m = [:]
            m.file = file.name
            def parts = m.file.split("\\.")
            parts = parts[0].split("_")
            def mes = parts[1]
            def anio = parts[2]
            m.mes = mes
            m.anio = anio
            m.fecha = new Date().parse("dd-MM-yyyy", "01-" + mes + "-" + anio)
            m.modified = new Date(file.lastModified()).format('dd-MM-yyyy hh:mm:ss')
            list << m
        }

        list = list.sort { it.fecha }
        return [list: list, empresa: empresa]
    }

    def getLastDayOfMonth(fecha) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(fecha);

        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.add(Calendar.DATE, -1);

        Date lastDayOfMonth = calendar.getTime();
        return lastDayOfMonth
    }

    private String fechaConFormato(fecha, formato) {
        def meses = ["", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
        def mesesLargo = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def strFecha = ""
//        println ">>" + fecha + "    " + formato
        if (fecha) {
            switch (formato) {
                case "dd/MM/yyyy":
                    strFecha = "" + fecha.format("dd/MM/yyyy")
                    break;
                case "MMM-yy":
                    strFecha = meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                    break;
                case "dd-MM-yyyy":
                    strFecha = "" + fecha.format("dd-MM-yyyy")
                    break;
                case "dd-MMM-yyyy":
                    strFecha = "" + fecha.format("dd") + "-" + meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yyyy")
                    break;
                case "dd-MMM-yy":
                    strFecha = "" + fecha.format("dd") + "-" + meses[fecha.format("MM").toInteger()] + "-" + fecha.format("yy")
                    break;
                case "dd MMMM yyyy":
                    strFecha = "" + fecha.format("dd") + " de " + mesesLargo[fecha.format("MM").toInteger()] + " de " + fecha.format("yyyy")
                    break;
                case "MMMM_yyyy":
                    strFecha = "" + mesesLargo[fecha.format("MM").toInteger()] + "_" + fecha.format("yyyy")
                    break;
                case "MM_yyyy":
                    strFecha = "" + fecha.format("MM") + "_" + fecha.format("yyyy")
                    break;
                case "MMMM yyyy":
                    strFecha = "" + mesesLargo[fecha.format("MM").toInteger()] + " " + fecha.format("yyyy")
                    break;
                default:
                    strFecha = "Formato " + formato + " no reconocido"
                    break;
            }
        }
//        println ">>>>>>" + strFecha
        return strFecha
    }

    private String fechaConFormato(fecha) {
        return fechaConFormato(fecha, "dd/MM/yyyy")
    }

    private String numero(number, decimales, cero) {
        def attrs = [:]
        attrs.number = number
        def dec = decimales.toInteger()

        attrs["format"] = "##,##0"
        if (dec > 0) {
            attrs["format"] += "."
        }
        dec.times {
            attrs["format"] += "#"
        }

        attrs.maxFractionDigits = dec
        attrs.minFractionDigits = dec

        if (cero == "false" || cero == false || cero == "hide") {
            if (number) {
                if (number.toDouble() == 0.toDouble()) {
                    return ""
                }
            } else {
                return ""
            }
        }
        return g.formatNumber(attrs)
    }

    private String numero(number) {
        numero(number, 2, "show")
    }

}