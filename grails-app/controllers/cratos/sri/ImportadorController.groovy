package cratos.sri

import jxl.Cell
import jxl.Sheet
import jxl.Workbook

class ImportadorController {

    def importar() {
        def file = new File("/home/luz/Documents/cratos/tablasGato.xls")
        def htmlInfo = ""

        Workbook workbook = Workbook.getWorkbook(file)
        workbook.getNumberOfSheets().times { sheet ->
            Sheet s = workbook.getSheet(sheet)
            def campos = []
            def dominio = ""
            Class clazz

            if (!s.getSettings().isHidden()) {
//                println s.getName()
                htmlInfo += "<h2>Hoja " + (sheet + 1) + ": " + s.getName() + "</h2>"
                Cell[] row = null
                s.getRows().times { i ->
                    row = s.getRow(i)
                    if (row.length > 0) {
                        if (i == 0) {
                            row.length.times { j ->
                                if (!row[j].isHidden()) {
                                    htmlInfo += "<h3>Dominio: " + row[j].getContents() + "</h3>"
                                    dominio = row[j].getContents()
                                    clazz = grailsApplication.getDomainClass(dominio).clazz
                                }//if row ! hidden
                            } //foreach cell
//                            println cols
                        } // i==0: 1ra fila: nombre dominio
                        else if (i == 1) {
                            htmlInfo += "<h4>Campos: "
                            row.length.times { j ->
                                if (!row[j].isHidden()) {
                                    htmlInfo += row[j].getContents() + " "
                                    campos[j] = row[j].getContents()
                                } //cell ! hidden
                            } //foreach cell
                            htmlInfo += "</h4>"
                        } // i==1: 2da fila: nombres de campos
                        else {
                            htmlInfo += "linea " + (i + 1) + "<br/>"
                            def domainInstance = grailsApplication.getArtefact("Domain", dominio)?.getClazz()?.newInstance()
                            row.length.times { j ->
                                if (!row[j].isHidden()) {
                                    if (domainInstance[campos[j]] instanceof Double) {
                                        domainInstance[campos[j]] = row[j].getContents().toDouble()
                                    } else if (domainInstance[campos[j]] instanceof Integer) {
                                        domainInstance[campos[j]] = row[j].getContents().toInteger()
                                    } else {
                                        domainInstance[campos[j]] = row[j].getContents()
                                    }
                                    htmlInfo += "&nbsp;&nbsp;&nbsp;&nbsp;" + dominio + "." + campos[j] + ": " + row[j].getContents() + "<br/>"
                                }
                            }
                            if (!domainInstance.save(flush: true)) {
                                println "WTF " + domainInstance.errors
                            }
                        } // i > 1: los datos de la tabla
                    } //row no vacio
                } //para cada row
            } //no hidden la hoja
        } //foreach hoja
        render htmlInfo
    }

//    def importar2() {
//        def file = new File("/home/luz/Documents/tablasLuz.xls")
//        def htmlInfo = ""
//        Workbook workbook = Workbook.getWorkbook(file)
//        workbook.getNumberOfSheets().times { sheet ->
//            Sheet s = workbook.getSheet(sheet)
//            def cols = []
//            def mails = []
//            def datos = [][]
//            if (!s.getSettings().isHidden()) {
//                println s.getName()
//                htmlInfo += "<h2>Hoja " + (sheet + 1) + ": " + s.getName() + "</h2>"
//                Cell[] row = null
//                s.getRows().times { i ->
//                    row = s.getRow(i)
//                    if (row.length > 0) {
//                        if (i == 0) {
//                            row.length.times { j ->
//                                if (!row[j].isHidden()) {
//                                    cols[j] = row[j].getContents()
//                                }//if row ! hidden
//                            } //foreach cell
////                            println cols
//                        } //if i==0
//                        else {
//                            datos[i - 1] = []
//                            row.length.times { j ->
//                                if (!row[j].isHidden()) {
//                                    datos[i - 1][j] = row[j].getContents()
//                                    if (cols[j] =~ "mail") {
//                                        mails[i - 1] = row[j].getContents()
//                                    }
//                                } //cel ! hidden
//                            } //foreach cell
//                        } //i>0
//                    }//if row.length > 0
////                    print "\n"
//                }//foreach row
//
//                datos.eachWithIndex { dd, d ->
//                    def t = template
//                    cols.eachWithIndex { cc, c ->
////                        println cc + "  " + dd[c]
//                        t = t.replaceAll("&lt;" + cc + "&gt;", dd[c])
//                    }
//                    def t2 = t
//                    tipoCarta.imagenes.each { img ->
//                        t2 = t2.replaceAll(grailsAttributes.getApplicationUri(request) + "/imgs/" + img.path, "cid:" + img.cid)
//                    }
//                    t2 = t2.replaceAll('\\?_debugResources=[a-z]&[a-z;0-9=]+\\"', '"')
//                    println "SENDING " + (d + 1) + "/" + datos.size() + " TO: " + mails[d]
//                    def b = true
////
////                    mailService.sendMail {
////                        to "luzma_87@yahoo.com"
////                        subject "Hello"
////                        html '<b>Hello</b> World'
////                    }
//                    try {
//                        mailService.sendMail {
//                            multipart true
//                            to mails[d]
//                            subject subjectMail
////                            html t2
//                            html g.render(template: "mail", model: [t: t2])
//
//                            tipoCarta.imagenes.each { img ->
//                                attachBytes grailsAttributes.getApplicationUri(request) + "/imgs/" + img.path, 'image/jpg', new File(servletContext.getRealPath("/") + "imgs/" + img.path).readBytes()
//                                inline img.cid, 'image/jpg', new File(servletContext.getRealPath("/") + "imgs/" + img.path)
//                            }
//                        }
//                    } catch (e) {
//                        b = false
//                        println "error : " + e
//                    }
//
//                    println(b ? "SENT!" : "NOT SENT...")
//
//                    htmlInfo += "<div class='completo ui-widget-content ui-corner-all'>"
//                    htmlInfo += "<div class='mail open ui-widget-header ui-corner-top'>"
//                    htmlInfo += "Para: " + mails[d] + " ; Subject: " + subjectMail + " ; Estado: " + (b ? "Enviado" : "No enviado")
//                    htmlInfo += "</div>"
//                    htmlInfo += "<div class='text ui-widget-content ui-corner-bottom'>" + t + "</div>"
//                    htmlInfo += "</div>"
//
//                    def usu = Usuario.get(session.usuario.id)
//                    def env = new Envio()
//                    env.usuario = usu
//                    env.tipoCarta = tipoCarta
//                    env.texto = t
//                    env.enviado = b
//                    env.fecha = new Date()
//                    env.mail = mails[d]
//                    if (!env.save()) {
//                        println "error save env: " + env.errors
//                    }
//                }
//            } // sheet ! hidden
//        } //foreach sheet
//    }

}