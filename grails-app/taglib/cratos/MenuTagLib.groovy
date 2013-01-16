package cratos

import cratos.seguridad.Modulo
import cratos.seguridad.Prms
import cratos.seguridad.Accn
import cratos.seguridad.Tpac

class MenuTagLib {

    static namespace = 'mn'


    def horizontalDropDown = { attrs ->
//        println "MENUUU"
        def modulos = Modulo.findAllByOrdenLessThan(99, [sort: "orden"])
        def perfil = session.perfil
        def empresa = session.empresa
        def acciones = Prms.findAllByPerfil(perfil).accion.id

        def html = "<div style='height:31px;' class='ui-widget-header' role='navigation'>"
        html += '<ul class="sf-menu">'
        modulos.each { mdlo ->
            html += '<li class="current">'
            html += '<a href="#a">' + mdlo.descripcion + '</a>'
            html += '<ul>'
            Accn.findAllByModuloAndTipo(mdlo, Tpac.get(1), [sort: "accnDescripcion"]).each {
                if (acciones.contains(it.id)) {
                    html += '<li>'
                    html += '<a href="' + g.createLink(controller: it.control, action: it.accnNombre) + '">' + it.accnDescripcion + '</a>'
                    html += '</li>'
                }
            }

            html += '</ul>'
            html += '</li>'
        }

        html += '</ul>'

        html += '<div class="" style="float:right;">'

//        html += '<div id="empresa" style="float:left;">' + "Empresa: " + empresa + '</div>'

        html += '<div id="countdown" style="float:left;"></div>'

        html += '<ul class="sf-menu">'
        html += '<li>'
        html += '<a href="' + g.createLink(controller: 'login', action: 'logout') + '">Salir</a>'
        html += '</li>'
        html += '</ul>'

//        html += "hora"
        html += "</div>"

        html += "</div>"

        def js = "<script type='text/javascript'>"
        js += '$(function(){'

        js += '$(".sf-menu").supersubs({ '
        js += '   minWidth:    12,   '// minimum width of sub-menus in em units
        js += '   maxWidth:    27,   '// maximum width of sub-menus in em units
        js += '   extraWidth:  1     '// extra width can ensure lines don't sometimes turn over due to slight rounding differences and font-family
        js += '}).superfish({'
        js += '});'

        js += '});'
        js += "</script>"

        out << html
        out << js

    }

}
