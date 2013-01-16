package cratos

class IncludesTagLib {
    def includeJQuery = { atr ->
        def archivo = atr.archivo ? "<script type='text/javascript' src='${createLinkTo(dir: 'js/aplicacion', file: atr.archivo + '.js')}' ></script>" : null
        if (!atr.archivo) {
            def theme = atr.tema ?: "tema"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/js', file: 'jquery-1.4.2.min.js')}' ></script>"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/js', file: 'jquery-ui-1.8.1.custom.min.js')}' ></script>"

            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/aplicacion', file: 'funciones.js')}' ></script>"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/aplicacion', file: 'botones.js')}' ></script>"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}' ></script>"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.blockui.js')}' ></script>"
            out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}' ></script>"
        }
        else
            out << archivo
    }

    def jqueryForm = {
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.validate.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.maskedinput.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.calculator.js')}' ></script>"

        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.validate.validaciones.js')}' ></script>"

        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/i18n', file: 'datepicker_es.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/i18n', file: 'validate_es.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/i18n', file: 'calculator_es.js')}' ></script>"

        out << "<link rel='stylesheet' href='${createLinkTo(dir: 'js/jquery/css', file: 'jquery.calculator.css')}' />"
    }
    def colorPicker = {
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins/colopicker/js', file: 'colorpicker.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins/colopicker/js', file: 'eye.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins/colopicker/js', file: 'layout.js')}' ></script>"
        out << "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins/colopicker/js', file: 'utils.js')}' ></script>"
        out << "<link type='text/css' href='${createLinkTo(dir: 'js/jquery/plugins/colopicker/css', file: 'colorpicker.css')}' rel='stylesheet' />"
        out << "<link type='text/css' href='${createLinkTo(dir: 'js/jquery/plugins/colopicker/css', file: 'layout.css')}' rel='stylesheet' />"
    }
}
