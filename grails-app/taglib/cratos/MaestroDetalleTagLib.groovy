package cratos

class MaestroDetalleTagLib {

    static namespace = 'md'

    def detalle = { attrs ->
        def html = "", js = ""
        def title = attrs.title ?: ""
        def id = attrs.id ?: "detalles"

        def headers = attrs.headers ?: ["Item", "Código", "Precio unitario", "Cantidad", "Descuento", "Precio total", "Observaciones", ""]

        html += '<fieldset style="margin: 10px;" id="fs_' + id + '">'
        if (title != "") {
            html += "<legend>" + title + "</legend>"
        }

        html += '<table class="bg" id="tbl_' + id + '">'
        html += '<tr>'
        headers.each { h ->
            html += '<td class="label">'
            html += h
            html += '</td>'
        }
        html += '</tr>'

        html += '<tr>'
        html += '<td id="tdItem_' + id + '">'
        html += '<input type="hidden" id="txtId_' + id + '"/>'
        html += '<input type="text" class="ui-widget-content ui-corner-all" id="txtItem_' + id + '" style="width: 170px;"/>'
        html += '</td>'
        html += '<td id="tdCodigo_' + id + '">'

        html += '</td>'
        html += '<td id="tdPrecioU_' + id + '">'
        html += '<input type="number" class="ui-widget-content ui-corner-all updatable" id="txtPrecio_' + id + '" style="width: 75px; text-align:right;"/>'
        html += '</td>'
        html += '<td id="tdCantidad_' + id + '">'
        html += '<input type="number" class="ui-widget-content ui-corner-all updatable" id="txtCantidad_' + id + '" style="width: 75px; text-align:right;"/>'
        html += '</td>'
        html += '<td id="tdDescuento_' + id + '">'
        html += '<input type="number" min="0" max="100" id="txtDescuento_' + id + '" class="ui-widget-content ui-corner-all updatable" value="0" style="width: 36px; text-align:right;"/>%'
        html += '</td>'
        html += '<td id="tdPrecioT_' + id + '">'

        html += '</td>'
        html += '<td id="tdObservaciones_' + id + '">'
        html += '<textarea id="txaObservaciones_' + id + '" class="ui-widget-content ui-corner-all updatable" rows="10" cols="10" style="width: 150px; height: 19px;"></textarea>'
        html += '</td>'
        html += '<td>'
        html += '<a href="#" id="btnAdd_' + id + '">Agregar</a>'
        html += '</td>'
        html += '</tr>'
        html += '</table>'

        html += '</fieldset>'


        html += '<div id="dlgBuscar_' + id + '" title="Buscar item">'
        html += '<div style="height: 40px;">'
        html += '<input type="text" id="txtBuscar_' + id + '" class="span-6 ui-widget-content ui-corner-all"/>'
        html += '<span class="span-1">'
        html += '<a href="#" id="btnItem_' + id + '">Buscar</a>'
        html += '</span>'
        html += '</div>'
        html += '<div id="area_' + id + '" style="width: 500px; max-height: 500px; overflow-y: auto; overflow-x: hidden;">'
        html += '</div>'
        html += '</div>'


        js = "<script type='text/javascript'>"
        js += '$("#btnAdd_' + id + '").button({'
        js += 'icons : {'
        js += 'primary : "ui-icon-plusthick"'
        js += '},'
        js += 'text  : false'
        js += '}).click(function () {'
//            addItem();
        js += '});'

        js += '$("#txtItem_' + id + '").focus(function () {'
        js += '$(".selected").removeClass("selected");'
//            search();
        js += '$("#dlgBuscar_' + id + '").dialog("open");'
        js += 'return false;'
        js += '});'

        js += '$("#btnItem_' + id + '").button({'
        js += 'text  : false,'
        js += 'icons : {'
        js += 'primary : "ui-icon-search"'
        js += '}'
        js += '}).click(function () {'
//            search();
        js += 'return false;'
        js += '});'

        js += '$("#dlgBuscar_' + id + '").dialog({'
        js += 'autoOpen : false,'
        js += 'width    : 525,'
        js += 'height   : 600,'
        js += 'modal    : true'
        js += '});'


        js += "</script>"

        out << html + js
    }

}
