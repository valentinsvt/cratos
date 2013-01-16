package cratos.seguridad

import org.codehaus.groovy.grails.plugins.codecs.MD5Codec
import cratos.InicioController
import cratos.Contabilidad


class LoginController {

    def loginService

    def index = {
//        println "index login"
    }

    def login = {

    }

    def validar = {

        def login
        def password

        login = params.login
        password = params.password?.encodeAsMD5()

//        println(params)

        def usuario = Usro.findWhere(login: login, password: password)


        if (usuario) {

            session.usuario = usuario
            session.empresa = usuario.persona.empresa
//            println "empresa "+session.empresa
            redirect(action: "perfiles")


        }
        else {

            redirect(action: "login")
            println "Usuario - Password Incorrecto"

            flash.message = 'Usuario o Password Incorrecto'
            flash.clase = "error"
            flash.ico = "ss_delete"
        }

    }

    def perfiles = {

        def usuarioLog = session.usuario

        def perfilesUsr = Sesn.findAllByUsuario(usuarioLog)

        return [perfilesUsr: perfilesUsr]

    }


    def savePer = {
//        println params


        def sesn = Sesn.get(params.perfiles)
        def perf = sesn.perfil
//        println perf

        if (perf) {

            def usuario = Usro.get(session.usuario.id)

            def empresa = usuario.persona.empresa

            session.empresa = empresa

//            println "login EMPRESA!! " + empresa
//            println "session empresa login: " + session.empresa

            session.perfil = perf
            def ahora = new Date()
            session.contabilidad = Contabilidad.findByFechaInicioLessThanEqualsAndFechaCierreGreaterThanEquals(ahora, ahora)
            if (!session.contabilidad) {
                def conts = Contabilidad.list([sort: "fechaCierre", order: "desc"])
                if (conts) {
                    session.contabilidad = conts[0]
                }
            }
//            println "contabilidad  " + session.contabilidad

            if (session.an && session.cn) {
//                println "si session url " + session.an + " " + session.cn
                redirect(controller: session.cn, action: session.an, params: session.pr)
            } else {
                redirect(controller: "inicio", action: "index")
            }
//            redirect(controller: 'inicio', action: "index")
        }
        else {
            redirect(action: "login")


        }
    }


    def logout = {
        if (session.usuario) {
            session.usuario = null
            session.perfil = null
            session.permisos = null
            session.menu = null
            session.an = null
            session.cn = null
            session.invalidate()
            redirect(controller: 'inicio', action: 'index')
        } else {
            redirect(controller: 'inicio', action: 'index')
        }
    }


}
