package cratos

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Paragraph
import com.lowagie.text.Phrase
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import java.awt.Color

class ReporteRolController {

    def dbConnectionService

    def imprimirLista() {
//        println "impr rol " + params
        def mes, periodo, roles
        def anio = new Date().format("yyyy").toInteger()
        if (params.mes) {
            mes = Mes.get(params.mes)
            if (params.periodo) {
                periodo = Periodo.get(params.periodo)
                roles = RolPagos.findAllByMessAndPeriodo(mes, periodo)
            }
            if (params.anio) {
                def fecha = new Date().parse("dd-MM-yyyy", "01-01-" + params.anio)
                def cont = Contabilidad.findAllByInstitucionAndFechaInicioGreaterThanEquals(session.empresa, fecha)
//                println "cont " + cont + " anio " + anio
                def periodos = []
                Periodo.findAllByContabilidadInList(cont).each { p ->
                    if (p.fechaInicio.format("yyyy") == params.anio)
                        periodos.add(p)
                }
//                println "periodos " + periodos
                roles = RolPagos.findAllByMessAndPeriodoInList(mes, periodos)
//                println "roles " + roles
            }
//            anio=periodo.fechaInicio.format("YYYY")
        }
        def rol = null
        def cn

        roles.each {
            if (!rol)
                if (it.periodo.contabilidad.institucion.id.toInteger() == session.empresa.id.toInteger()) {
                    rol = it
                    anio = it.periodo.fechaInicio.format("YYYY")
                }
        }
        def datos = []
        if (rol) {
            def sql = "SELECT e.empl__id,p.prsnnmbr||' ' || p.prsnapll ,c.crgodscr,t.tpctdscr ,sum(d.dtpgvlor) from rlpg r,dtpg d,empl e,prsn p,crgo c, tpct t where r.rlpg__id=${rol.id} and r.rlpg__id=d.rlpg__id and d.empl__id=e.empl__id and e.prsn__id=p.prsn__id and e.crgo__id=c.crgo__id and e.tpct__id=t.tpct__id  group by 1,2,3,4 order by 2;"
            cn = dbConnectionService.getConnection()
            cn.eachRow(sql.toString()) { r ->
                datos.add(r.toRowResult())
            }
        }

        def baos = new ByteArrayOutputStream()
        def name = "rol_pagos_${rol?.mess.descripcion?.toLowerCase()}_${params.anio}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
//        println "name " + name

        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontInfo = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)

        Font fontTh = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontTd = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL)

        Document document = new Document();
        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        document.addTitle("Rol de pagos de  ${rol?.mess.descripcion} ${params.anio}" + " " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, cratos," + params.titulo);
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        addEmptyLine(preface, 1);
        preface.add(new Paragraph("Rol de pagos del mes de ${rol?.mess.descripcion} ${params.anio}", fontTitulo));
        preface.add(new Paragraph("Generado por el usuario: " + session.usuario + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), fontInfo))
        addEmptyLine(preface, 1);
        document.add(preface);

        PdfPTable tablaDatos = new PdfPTable(4);
        tablaDatos.setWidthPercentage(100);
//        tablaDatos.setWidths(arregloEnteros([12, 24, 10, 12, 24]))
        tablaDatos.setSpacingAfter(10f)

        addCellTabla(tablaDatos, new Paragraph("Empleado", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaDatos, new Paragraph("Cargo", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaDatos, new Paragraph("Contrato", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaDatos, new Paragraph("A recibir", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        datos.each { d ->
            addCellTabla(tablaDatos, new Paragraph(d[1], fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaDatos, new Paragraph(d[2], fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaDatos, new Paragraph(d[3], fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaDatos, new Paragraph(numero(d[4], 2), fontTd), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
        }

        addCellTabla(tablaDatos, new Paragraph("TOTAL", fontTh), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 3])
        addCellTabla(tablaDatos, new Paragraph(numero(rol?.pagado, 2), fontTh), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])

        document.add(tablaDatos)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def imprimirDetalle() {
//        println "print detalle " + params
        def rol = RolPagos.get(params.rol)
        def emp = Empleado.get(params.emp)
        def detalle = DetallePago.findAllByEmpleadoAndRolPagos(emp, rol)

        def anio = rol.periodo.fechaInicio.format("yyyy")

        def baos = new ByteArrayOutputStream()
        def name = "rol_pagos_detalle_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
//        println "name " + name

        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontInfo = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)

        Font fontTh = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontTd = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL)

        Document document = new Document();
        def pdfw = PdfWriter.getInstance(document, baos);

        document.open();
        document.addTitle("Detalle de rol de pagos " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, cratos," + params.titulo);
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        addEmptyLine(preface, 1);
        preface.add(new Paragraph("Detalle del rol de pagos del mes de ${rol?.mess.descripcion.toLowerCase()} ${anio} de ${emp.persona.nombre} ${emp.persona.apellido}", fontTitulo));
        preface.add(new Paragraph("Generado por el usuario: " + session.usuario + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), fontInfo))
        addEmptyLine(preface, 1);
        document.add(preface);

        PdfPTable tablaEmp = new PdfPTable(4);
        tablaEmp.setWidthPercentage(100);
        tablaEmp.setSpacingAfter(15f)

        addCellTabla(tablaEmp, new Paragraph("Nombres", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("${emp.persona.nombre} ${emp.persona.apellido}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("Cédula", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("${emp.persona.cedula}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaEmp, new Paragraph("Cargo", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("${emp.cargo?.descripcion}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("Tipo de contrato", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaEmp, new Paragraph("${emp.tipoContrato?.descripcion}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        document.add(tablaEmp)

        PdfPTable tablaDatos = new PdfPTable(3);
        tablaDatos.setWidthPercentage(100);
//        tablaDatos.setWidths(arregloEnteros([12, 24, 10, 12, 24]))
        tablaDatos.setSpacingAfter(10f)

        addCellTabla(tablaDatos, new Paragraph("Rubro", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaDatos, new Paragraph("Tipo", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaDatos, new Paragraph("Valor", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

        def total = 0
        detalle.each { d ->
            if (d.rubroTipoContrato) {
                addCellTabla(tablaDatos, new Paragraph(d.rubroTipoContrato.rubro.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                addCellTabla(tablaDatos, new Paragraph(d.rubroTipoContrato.rubro.tipoRubro.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE,])
            } else {
                if (d.descripcion) {
                    addCellTabla(tablaDatos, new Paragraph(d.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                } else {
                    addCellTabla(tablaDatos, new Paragraph("SUELDO", fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                }
                addCellTabla(tablaDatos, new Paragraph("", fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            }
            addCellTabla(tablaDatos, new Paragraph(numero(d.valor, 2), fontTd), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
            total += d.valor
        }

        addCellTabla(tablaDatos, new Paragraph("TOTAL", fontTh), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
        addCellTabla(tablaDatos, new Paragraph(numero(total, 2), fontTh), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])

        document.add(tablaDatos)

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def imprimirDetalles() {
//        println "impr rol " + params
        def mes, periodo, roles
        def anio = new Date().format("yyyy").toInteger()
        if (params.mes) {
            mes = Mes.get(params.mes)
            if (params.periodo) {
                periodo = Periodo.get(params.periodo)
                roles = RolPagos.findAllByMessAndPeriodo(mes, periodo)
            }
            if (params.anio) {
                def fecha = new Date().parse("dd-MM-yyyy", "01-01-" + params.anio)
                def cont = Contabilidad.findAllByInstitucionAndFechaInicioGreaterThanEquals(session.empresa, fecha)
//                println "cont " + cont + " anio " + anio
                def periodos = []
                Periodo.findAllByContabilidadInList(cont).each { p ->
                    if (p.fechaInicio.format("yyyy") == params.anio)
                        periodos.add(p)
                }
//                println "periodos " + periodos
                roles = RolPagos.findAllByMessAndPeriodoInList(mes, periodos)
//                println "roles " + roles
            }
//            anio=periodo.fechaInicio.format("YYYY")
        }
        def rol = null

        roles.each {
            if (!rol)
                if (it.periodo.contabilidad.institucion.id.toInteger() == session.empresa.id.toInteger()) {
                    rol = it
                    anio = it.periodo.fechaInicio.format("YYYY")
                }
        }
        def empleados = DetallePago.findAllByRolPagos(rol).empleado.unique().sort { it.persona.apellido }

        def baos = new ByteArrayOutputStream()
        def name = "rol_pagos_detallado_${rol?.mess.descripcion?.toLowerCase()}_${params.anio}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
//        println "name " + name

        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontInfo = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL)
        Font fontFooter = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)

        Font fontTh = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font fontTd = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL)

        Document document = new Document();
        def pdfw = PdfWriter.getInstance(document, baos);

//        // headers and footers must be added before the document is opened
//        HeaderFooter footer1 = new HeaderFooter(new Phrase("Rol de pagos detallado de ${rol?.mess.descripcion.toLowerCase()} ${params.anio}       pág.", fontFooter), true);
//        // true aqui pone numero de pagina
//        footer1.setBorder(Rectangle.NO_BORDER);
//        footer1.setBorder(Rectangle.TOP);
//        footer1.setAlignment(Element.ALIGN_CENTER);
//        document.setFooter(footer1);

        document.open();
        document.addTitle("Rol de pagos detallado de ${rol?.mess.descripcion} ${params.anio}" + " " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema Cratos");
        document.addKeywords("reporte, cratos," + params.titulo);
        document.addAuthor("Cratos");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
        addEmptyLine(preface, 1);
        preface.add(new Paragraph("Rol de pagos detallado del mes de ${rol?.mess.descripcion} ${params.anio}", fontTitulo));
//        preface.add(new Paragraph("Generado por el usuario: " + session.usuario + "   el: " + new Date().format("dd/MM/yyyy hh:mm"), fontInfo))
        addEmptyLine(preface, 1);
//        document.add(preface);

        empleados.each { emp ->
            document.add(preface);
            def detalle = DetallePago.findAllByEmpleadoAndRolPagos(emp, rol)

            PdfPTable tablaEmp = new PdfPTable(4);
            tablaEmp.setWidthPercentage(100);
            tablaEmp.setSpacingBefore(15f)
            tablaEmp.setSpacingAfter(15f)

            addCellTabla(tablaEmp, new Paragraph("Nombres", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("${emp.persona.nombre} ${emp.persona.apellido}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("Cédula", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("${emp.persona.cedula}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

            addCellTabla(tablaEmp, new Paragraph("Cargo", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("${emp.cargo?.descripcion}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("Tipo de contrato", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaEmp, new Paragraph("${emp.tipoContrato?.descripcion}", fontTd), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

            document.add(tablaEmp)

            PdfPTable tablaDatos = new PdfPTable(3);
            tablaDatos.setWidthPercentage(100);
//        tablaDatos.setWidths(arregloEnteros([12, 24, 10, 12, 24]))
            tablaDatos.setSpacingAfter(10f)

            addCellTabla(tablaDatos, new Paragraph("Rubro", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaDatos, new Paragraph("Tipo", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaDatos, new Paragraph("Valor", fontTh), [border: Color.BLACK, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

            def total = 0
            detalle.each { d ->
                if (d.rubroTipoContrato) {
                    addCellTabla(tablaDatos, new Paragraph(d.rubroTipoContrato.rubro.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaDatos, new Paragraph(d.rubroTipoContrato.rubro.tipoRubro.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE,])
                } else {
                    if (d.descripcion) {
                        addCellTabla(tablaDatos, new Paragraph(d.descripcion, fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    } else {
                        addCellTabla(tablaDatos, new Paragraph("SUELDO", fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    }
                    addCellTabla(tablaDatos, new Paragraph("", fontTd), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                }
                addCellTabla(tablaDatos, new Paragraph(numero(d.valor, 2), fontTd), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
                total += d.valor
            }

            addCellTabla(tablaDatos, new Paragraph("TOTAL", fontTh), [border: Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 2])
            addCellTabla(tablaDatos, new Paragraph(numero(total, 2), fontTh), [border: Color.BLACK, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])

            document.add(tablaDatos)

            PdfPTable tablaFirma = new PdfPTable(3);
            tablaFirma.setWidthPercentage(100);
            tablaFirma.setWidths(arregloEnteros([30, 40, 30]))
            tablaFirma.setSpacingBefore(40f)
            tablaFirma.setSpacingAfter(70f)
            addCellTabla(tablaFirma, new Paragraph("", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaFirma, new Paragraph("${emp.persona.nombre} ${emp.persona.apellido}", fontTh), [border: Color.WHITE, bct: Color.BLACK, bwt: 0.1, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaFirma, new Paragraph("", fontTh), [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

            document.add(tablaFirma)

            document.add(tablaEmp)
            document.add(tablaDatos)
            document.add(tablaFirma)

            document.newPage()
        }

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }

        return ia
    }

    private String numero(num, decimales, cero) {
        if (num == 0 && cero.toString().toLowerCase() == "hide") {
            return " ";
        }
        if (decimales == 0) {
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec")
        } else {
            def format
            if (decimales == 2) {
                format = "##,##0"
            } else if (decimales == 3) {
                format = "##,###0"
            }
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec", format: format)
        }
    }

    private String numero(num, decimales) {
        return numero(num, decimales, "show")
    }

    private String numero(num) {
        return numero(num, 3)
    }

    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }

        table.addCell(cell);
    }
}
