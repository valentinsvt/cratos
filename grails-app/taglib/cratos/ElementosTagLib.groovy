package cratos

import java.text.DateFormatSymbols
import org.springframework.web.servlet.support.RequestContextUtils

class ElementosTagLib {

    static namespace = 'elm'

    /**
     * Dump out attributes in HTML compliant fashion.
     */
    void outputAttributes(attrs, writer) {
        attrs.remove('tagName') // Just in case one is left
        attrs.each { k, v ->
            writer << k
            writer << '="'
            writer << v.encodeAsHTML()
            writer << '" '
        }
    }

    /**
     * renders attributes in HTML compliant fashion returning them in a string
     */
    String renderAttributes(attrs) {
        def ret = ""
        attrs.remove('tagName') // Just in case one is left
        attrs.each { k, v ->
            ret += k
            ret += '="'
            if (v) {
                ret += v.encodeAsHTML()
            } else {
                ret += ""
            }
            ret += '" '
        }
        return ret
    }

    def datePicker = { attrs ->
        def str = ""
        def clase = attrs.remove("class")
        def name = attrs.remove("name")
        def id = attrs.id ? attrs.remove("id") : name

        def value = attrs.remove("value")
        if (value.toString() == 'none') {
            value = null
        }
        else if (!value) {
            value = null
        }

        def format = attrs.format ? attrs.remove("format") : "dd-MM-yyyy"
        def formatJs = format
        formatJs = formatJs.replaceAll("M", "m")
        formatJs = formatJs.replaceAll("yyyy", "yy")

        str += "<input type='text' class='datepicker " + clase + "' name='" + name + "' id='" + id + "' value='" + g.formatDate(date: value, format: format) + "'"
        str += renderAttributes(attrs)
        str += "/>"

        def js = "<script type='text/javascript'>"
        js += '$(function() {'
        js += '$("#' + id + '").datepicker({'
        js += 'dateFormat: "' + formatJs + '",'
        js += 'changeMonth: true,'
        js += 'changeYear: true,'
        js += 'autoOpen: false,'
        js += '});'
        js += '});'
        js += "</script>"

        out << str
        out << js
    }

}
