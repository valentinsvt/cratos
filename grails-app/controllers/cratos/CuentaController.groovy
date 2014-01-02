package cratos

import org.springframework.dao.DataIntegrityViolationException

class CuentaController extends cratos.seguridad.Shield {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", delete: "GET"]

    def index() {
        redirect(action: "list", params: params)
    }

    def cuentaResultados() {
        def cuentas = Cuenta.findAllByNumeroLikeAndMovimiento("3%", "1", [sort: "numero"])
        Cuenta.findAll("from Cuenta where numero like '3%' and movimiento='1' order by numero ")
        def cuentaS = Cuenta.findByResultadoAndEmpresa("S", session.empresa)
        def cuentaD = Cuenta.findByResultado("D", session.empresa)
        [cuentas: cuentas, cuentaS: cuentaS, cuentaD: cuentaD]
    }

    def grabarCuentaResultado() {
        println "grabar cuentas resultado " + params
        def sup = Cuenta.get(params.super)
        def deficit = Cuenta.get(params.deficit)
        sup.resultado = "S"
        deficit.resultado = "D"
        sup.save(flush: true)
        deficit.save(flush: true)
        flash.message = "Datos guardados"
        redirect(action: 'cuentaResultados')
    }


    def loadForm() {

//        println ">>>>  " + params

        def padreId = params.padre
        def id = params.id

        def cuenta = new Cuenta()
        def padre

        if (id) {
//            println "1"
            cuenta = Cuenta.get(id)
            padre = cuenta.padre
        }
        if (padreId) {
//            println "2"
            padre = Cuenta.get(padreId)
            cuenta.padre = padre
        }

//        println cuenta
//        println cuenta.nivel

        return [cuentaInstance: cuenta]
    }

    String makeBasicTree(id) {
        String tree = "", clase = "", rel = ""
        Cuenta[] hijos

        def padre = Cuenta.get(id)
        if (padre) {
            hijos = Cuenta.findAllByPadre(padre, [sort: "numero"])
        } else {
            hijos = Cuenta.findAllByNivel(Nivel.get(1), [sort: "numero"])
        }

        println("id: " + id)
        println("padre:" + padre)
        println("hijos " + hijos)

        if (padre || hijos.size() > 0) {
            tree += "<ul>"

            hijos.each { hijo ->
                def hijosH = Cuenta.findAllByPadre(hijo, [sort: "numero"])

                def gestores = Genera.findAllByCuenta(hijo)
                def asientos = Asiento.findAllByCuenta(hijo)

                clase = (hijosH.size() > 0) ? "jstree-closed hasChildren" : ""
                rel = (hijosH.size() > 0) ? "padre" : "hijo"

                if (hijosH.size() > 0 || gestores.size() > 0 || asientos.size() > 0) {
                    clase += " ocupado "
                    if (gestores.size() > 0) {
                        clase += " conGestores "
                    }
                    if (asientos.size() > 0) {
                        clase += " conAsientos "
                    }
                }

                tree += "<li id='li_" + hijo.id + "' class='" + clase + "' rel='" + rel + "' level='" + hijo.nivel.id + "'>"
                tree += "<a href='#' class='label_arbol'>" + hijo + "</a>"
                tree += "</li>"
            }

            tree += "</ul>"
        }

        return tree
    }

    def loadTreePart() {
        render(makeBasicTree(params.id))
    }

    def ajaxSearch() {
//        println "ajax search"
//        println params
        def search = params.search_string
        def ret = "["
        def cuentas
        if (search.size() >= 3) {
            ret += '"#root",'
//            println "BUSCA"
            cuentas = Cuenta.findAllByDescripcionIlikeOrNumeroIlike("%" + search + "%", "%" + search + "%")
//            println "cuentas: " + cuentas
            cuentas.each { cuenta ->
                def p = cuenta.padre
                while (p) {
                    ret += '"#li_' + p.id + '",'
//                    println "\t" + ret
                    p = p.padre
                }
//                ret += '"#li_' + cuenta.id + '",'
//                println ret
            }

            if (ret != "[") {
                ret = ret[0..ret.size() - 2]
            }
        }
        ret += "]"
//        println ret
        render ret
    }

    def list() {

    }

    def editCuenta = {
        println "edit cuenta " + params
        def id = params.id
        def lvl = params.level.toInteger()
        def tipo = params.type

        def cuentaInstance
        def cuentaPadre
        def hijos = 0

        if (tipo == "create") {
            cuentaInstance = new Cuenta()
            cuentaPadre = Cuenta.get(id)
            lvl = lvl + 1
        } else {
            cuentaInstance = Cuenta.get(id)
            cuentaPadre = cuentaInstance.padre
            hijos = Cuenta.findAllByPadre(cuentaInstance).size()
        }

        return [cuentaInstance: cuentaInstance, cuentaPadre: cuentaPadre, lvl: lvl, hijos: hijos]
    }

    def list_loadAll() {
        def lvl1 = Cuenta.findAllByNivel(Nivel.get(1), [sort: "numero"]).id

        def res = ""
        res += "<ul>"
        lvl1.each {
            res += imprimeHijos(it)
        }
        res += "</ul>"

        return [res: res]
    }

    def imprimeHijos(padre) {
        def band = true
        def t = ""
        def txt = ""

        def cuenta = Cuenta.get(padre)
        def valor = 0
        def l = Cuenta.findAllByPadre(cuenta);
        l.each {
            band = false;
            t += imprimeHijos(it.id)
        }

        if (!band) {
            def clase = "jstree-open"
            if (cuenta.nivel.id >= 3) {
                clase = "jstree-closed"
            }

            if (l.size() > 0) {
                clase += " hasChildren "
            }

            txt += "<li id='li_" + cuenta.id + "' class='padre " + clase + "' rel='padre'>"
            txt += "<a href='#' class='label_arbol'>" + cuenta + "</a>"
            txt += "<ul>"
            txt += t
            txt += "</ul>"
        } else {
//            println "si band"
            txt += "<li id='li_" + cuenta.id + "' class='hijo jstree-leaf' rel='hijo'>"
            txt += "<a href='#' class='label_arbol'>" + cuenta + "</a>"
        }
        txt += "</li>"
        return txt
    }

    def create() {
        [cuentaInstance: new Cuenta(params)]
    }

    def saveAjax() {
        if (!params.estado) {
            params.estado = 'A'
        }

        println "***" + params

        if (params.impuesto.id) {
            params.retencion = "S"
        }

        def cuentaInstance = new Cuenta(params)

        if (params.id) {
            cuentaInstance = Cuenta.get(params.id)
            cuentaInstance.properties = params
        }
        cuentaInstance.empresa = Empresa.get(session.empresa.id)

        if (!cuentaInstance.save(flush: true)) {
            println cuentaInstance.errors
            render "NO_Error al guardar. Por favor espere...."
        } else {
            def padre = cuentaInstance.padre
            if (padre) {
                padre.movimiento = 0
                padre.auxiliar = 'N'
                if (!padre.save(flush: true)) {
                    println "error al poner movimiento=0 en el padre con id " + padre.id
                }
            }
            if (params.id) {
                render "OK_Cuenta actualizada. Por favor espere...."
            } else {
                render "OK_Cuenta creada. Por favor espere...."
            }
        }
    }

    def save() {
        def cuentaInstance = new Cuenta(params)

        if (params.id) {
            cuentaInstance = Cuenta.get(params.id)
            cuentaInstance.properties = params
        }

        cuentaInstance.empresa = Empresa.get(session.empresa.id)

        if (!cuentaInstance.save(flush: true)) {
            if (params.id) {
                render(view: "edit", model: [cuentaInstance: cuentaInstance])
            } else {
                render(view: "create", model: [cuentaInstance: cuentaInstance])
            }
            return
        }

        if (params.id) {
            flash.message = "Cuenta actualizado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        } else {
            flash.message = "Cuenta creado"
            flash.clase = "success"
            flash.ico = "ss_accept"
        }
        redirect(action: "show", id: cuentaInstance.id)
    }

    def show() {
        def cuentaInstance = Cuenta.get(params.id)
        if (!cuentaInstance) {
            flash.message = "No se encontró Cuenta con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [cuentaInstance: cuentaInstance]
    }

    def edit() {
        def cuentaInstance = Cuenta.get(params.id)
        if (!cuentaInstance) {
            flash.message = "No se encontró Cuenta con id " + params.id
            flash.clase = "error"
            flash.ico = "ss_delete"
            redirect(action: "list")
            return
        }

        [cuentaInstance: cuentaInstance]
    }

    def deleteCuenta() {
        def cuentaInstance = Cuenta.get(params.id)
        if (!cuentaInstance) {
            render("NO_" + "No se encontró cuenta con id " + params.id)
            return
        }

        try {
            cuentaInstance.delete(flush: true)
            render("OK")
        }
        catch (DataIntegrityViolationException e) {
            render("NO_" + "No se pudo eliminar la cuenta con id " + params.id)
        }
    }

    def cargarCuentas() {
        def file = new File("/home/svt/cuentas4-9.csv")
        def empresa = Empresa.get(1)
        file.eachLine {
            def parts = it.split("&")

            // println "parts "+parts
            def cuenta = new Cuenta()
            cuenta.auxiliar = "S"
            cuenta.numero = parts[1].trim()
            cuenta.descripcion = parts[0].trim()
            if (parts[0].trim() == "")
                cuenta.descripcion = "CAMBIAR DESCRIPCION"
            cuenta.estado = "A"
            if (parts[2]) {
                cuenta.padre = Cuenta.findByNumero(parts[2].trim())
                if (!cuenta.padre) {
                    println "no encontro padre wtf"
                }
            } else {
                cuenta.padre = null
            }
            cuenta.movimiento = parts[4]
            cuenta.empresa = empresa
            cuenta.nivel = Nivel.get(Math.ceil(parts[1].size() / 2))
            if (!cuenta.save(flush: true)) {
                println "error " + cuenta.errors
            } else {
                println "save " + cuenta
            }


        }
    }
}
