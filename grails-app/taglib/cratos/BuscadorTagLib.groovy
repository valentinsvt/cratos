package cratos

class BuscadorTagLib {

    static namespace = 'bsc'

    def operacion = {atr->

        //println "atr 2 "+atr
        def propiedad = atr.propiedad
        def registro = atr.registro
        def operacion = atr.funcion.keySet().toArray().getAt(0)
        def parametros = atr.funcion[operacion].clone()
        //println " reg "+registro+" op "+operacion+" par "+parametros+" prop "+propiedad
        parametros.eachWithIndex{it,i->
            if(it=="?")
                parametros[i]=registro[propiedad]
            if (it =="&")
                parametros[i]=registro
        }
        def result
        if (operacion!="closure"){
            switch (parametros.size()){
                case 1:
                    result = registro[propiedad]."$operacion"(parametros[0])
                    break
                case 2:
                    result = registro[propiedad]."$operacion"(parametros[0],parametros[1])
                case 3:
                    result = registro[propiedad]."$operacion"(parametros[0],parametros[1],parametros[2])
                    break
                default:
                    result=""
            }
        }else{
            //println "closure "+parametros[0]
            def cl = parametros[0]
            parametros.remove(0)
            result=cl parametros[0]
        }


        //println "return "+result
        //println "----------------------------"
        out << result
    }

    def buscador = {atr ->
        def name = atr.name ? atr.name : " "
        def value = atr.value
        def campos
        campos = atr.campos
        def controlador = atr.controlador
        def accion = atr.accion
        def label = atr.label
        def tipo = atr.tipo
        switch (tipo){
            case "buscador":
                out << listaHtml(name, value, campos, controlador, accion, label, false)
                break;
            case "lista":
                out<<lista(name, value, campos, controlador, accion)
                break;
            default:
                out << listaHtml(name, value, campos, controlador, accion, label, false)
                break;
        }
        //println "accion " + accion + "    controlador " + controlador

    }

    def lista(name, value, campos, controlador, accion){
        def salida = ""
        salida += '<div style="border:1px solid black;margin-top:10px;float:left" class="ui-corner-all">'
        salida += '<div class="filaBuscador ui-corner-all" style="margin-left:15px;margin-top:10px;" >'
        salida += '<div id="campo" style="float: left; margin-right:  5px;">'
        salida += 'Buscar por: <select name="campo" id="campo" style="width: 100px;" >'
        def i = 0
        campos.each {
            if (i == 0)
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '" selected>' + it.value.get(0) + '</option>'
            else
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '">' + it.value.get(0) + '</option>'
            i++
        }
        salida += '</select>'
        salida += '</div>'
        salida += '<div id="Doperador" style="float: left; margin-right: 5px;">'
        salida += '<select name="operador" style="width: 100px;" id="operador"></select>'
        salida += '</div>'
        salida += '<input type="hidden" name="tipoCampo" id="tipoCampo" value="string">'
        salida += 'Criterio:<input type="text" size="8" style="margin-right:5px" name="criterio" id="criterio">'
        salida += 'Ordenado por: <select name="campoOrdn" id="campoOrdn" style="width: 100px;" >'
        i = 0
        campos.each {
            if (i == 0)
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '" selected>' + it.value.get(0) + '</option>'
            else
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '">' + it.value.get(0) + '</option>'
            i++
        }
        salida += '</select>'
        salida += '<select name="orden" id="orden" style="width: 100px;" ><option value="asc" selected>Ascendente</option><option value="desc">Descendente</option></select>'
        salida += '<a href="#" id="mas" style="margin-left:5px">Agregar condición</a>'
        salida += '<a href="#" id="reset" style="margin-left:5px">Resetear</a>'
        salida += '<input id="buscarDialog" type="button" value="Buscar" style="width:80px;margin-left:10px" class="tbbtn fg-button ui-state-default fg-button-icon-left ui-corner-all" >'
        salida += '</div>'
        salida += '<div id="criterios" style="width:850px;height:35px;float:left"></div>'
        salida += '<div class="contenidoBuscador  ui-corner-all" id="contenidoBuscador" style="float:left;width:860px;margin-top:5px;margin-left:10px;"></div>'
        salida += '<a href="#" id="btn_reporte" style="margin:10px;margin-left:20px;color:white">Reporte</a>'
        salida += '</div>'
        salida += "<script type='text/javascript' src='${createLinkTo(dir: 'js/aplicacion', file: 'buscador.js')}' ></script>"
        salida += "<script type='text/javascript'>"

        salida += 'function enviar() {'
        salida += 'var data = "";'

        salida +='$(".crit").each(function(){'
        salida += 'data+="&campos="+$(this).attr("campo");'
        salida += 'data+="&operadores="+$(this).attr("operador");'
        salida += 'data+="&criterios="+$(this).attr("criterio");'
        salida +='});'
        salida +='if(data.length<2){'
        salida += 'data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()'
        salida += '}'
        salida += 'data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();'
        if (controlador) {
            salida += '$.ajax({type: "POST",url: "' + controlador +'/' + accion + '",'
        } else {
            salida += '$.ajax({type: "POST",url: "' + accion + '",'
        }

        salida += 'data: data,'

        salida += 'success: function(msg){'
        salida += '$(".contenidoBuscador").html(msg).show("slide");'
        salida += '}'
        salida += '});'
        salida += '};'
        salida += 'cambiaOperador();'
        salida += '$("#buscarDialog").click(function(){'
        salida += ' enviar();'
        salida += '});'




        salida += '</script>'

        return salida
    }


    String listaHtml(name, value, campos, controlador, accion, label = '', lsta = false) {
        def salida = ""
        if (!lsta) {
            salida += '<div class=" filaEntera ui-corner-all barra"   > '
            salida += ' ' + label + ': <input type="text" class=" ui-widget-content ui-corner-all" id="txtValor" disabled> <input id="buscar" type="button" value="Buscar" class="tbbtn fg-button ui-state-default fg-button-icon-left ui-corner-all"><input type="hidden" name="' + name + '" value="' + value + '" id="hidVal">'
            salida += '</div>'
            salida += ' <div class="buscador" id="DivBuscador">'
//            salida += '<form class="buscadorForm">'
        }
        salida += '<div class="filaBuscador" style="margin-left:15px">'
        salida += '<div id="campo" style="float: left; margin-right:  5px;">'
        salida += 'Buscar por: <select name="campo" id="campo" style="width: 100px;" >'
        def i = 0
        campos.each {
            if (i == 0)
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '" selected>' + it.value.get(0) + '</option>'
            else
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '">' + it.value.get(0) + '</option>'
            i++
        }
        salida += '</select>'
        salida += '</div>'
        salida += '<div id="Doperador" style="float: left; margin-right: 5px;">'
        salida += '<select name="operador" style="width: 100px;" id="operador"></select>'
        salida += '</div>'
        salida += '<input type="hidden" name="tipoCampo" id="tipoCampo" value="string">'
        salida += 'Criterio:<input type="text" size="8" style="margin-right:5px" name="criterio" id="criterio">'
        salida += 'Ordenado por: <select name="campoOrdn" id="campoOrdn" style="width: 100px;" >'
        i = 0
        campos.each {
            if (i == 0)
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '" selected>' + it.value.get(0) + '</option>'
            else
                salida += ' <option value="' + it.key + '" tipo="' + it.value.get(1) + '">' + it.value.get(0) + '</option>'
            i++
        }
        salida += '</select>'
        salida += '<select name="orden" id="orden" style="width: 100px;" ><option value="asc" selected>Ascendente</option><option value="desc">Descendente</option></select>'
        salida += '<a href="#" id="mas" style="margin-left:5px">Agregar condición</a>'
        salida += '<a href="#" id="reset" style="margin-left:5px">Resetear</a>'
        salida += '<input id="buscarDialog" type="button" value="Buscar" style="width:80px;margin-left:10px" class="tbbtn fg-button ui-state-default fg-button-icon-left ui-corner-all" >'
        salida += '</div>'
        salida += '<div id="criterios" style="width:750px;height:25px"></div>'
        salida += '<div class="contenidoBuscador  ui-corner-all" id="contenidoBuscador" style="float:left;width:860px;margin-top:5px"></div>'
        if (!lsta) {
//            salida += '</form>'
        }
        salida += '</div>'
        salida += "<script type='text/javascript' src='${createLinkTo(dir: 'js/jquery/plugins', file: 'jquery.livequery.js')}' ></script>"
        salida += "<script type='text/javascript' src='${createLinkTo(dir: 'js/aplicacion', file: 'buscador.js')}' ></script>"
        salida += "<script type='text/javascript'>"

        salida += 'function enviar() {'
        salida += 'var data = "";'

        salida +='$(".crit").each(function(){'
        salida += 'data+="&campos="+$(this).attr("campo");'
        salida += 'data+="&operadores="+$(this).attr("operador");'
        salida += 'data+="&criterios="+$(this).attr("criterio");'
        salida +='});'
        salida +='if(data.length<2){'
        salida += 'data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()'
        salida += '}'
        salida += 'data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();'
        if (controlador) {
            salida += '$.ajax({type: "POST",url: "' + controlador +'/' + accion + '",'
        } else {
            salida += '$.ajax({type: "POST",url: "' + accion + '",'
        }

        salida += 'data: data,'

        salida += 'success: function(msg){'
        salida += '$(".contenidoBuscador").html(msg).show("slide");'
        salida += '}'
        salida += '});'
        salida += '};'
        salida += 'cambiaOperador();'
        salida += '$("#buscarDialog").unbind("click");'
        salida += '$("#buscarDialog").bind("click",function(){'
        salida += ' enviar();'
        salida += '});'




        salida += '</script>'

        return salida
    }




}
