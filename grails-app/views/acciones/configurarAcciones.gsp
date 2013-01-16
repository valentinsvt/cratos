<%@ page import="cratos.seguridad.Prfl; cratos.seguridad.Accn;cratos.seguridad.Tpac;" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Configuracion del menu</title>
    <meta name="layout" content="main"/>
</head>

<body>
<div>
    <g:if test="${flash.message}">
        <div class="message ui-state-highlight ui-corner-all">
            <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
        </div>
    </g:if>
    <g:hasErrors bean="${personaInstance}">
        <div class="errors ui-state-error ui-corner-all">
            <g:renderErrors bean="${personaInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <div style="width: 800px; height: 40px;margin-bottom: 5px;margin-top: 10px;">
        <a href="#" id="verMenu">Ver Men&uacute;s de los M&oacute;dulos</a>
        <a href="#" id="verProceso">Ver Procesos de los M&oacute;dulos</a>
        <a href="#" id="nuevoMod">Nuevo Modulo</a>
        <a href="#" id="editaMod">Editar Modulo</a>
        <a href="#" id="borraMod">Borrar Modulo</a>
    </div>

    <h1>${titulo}</h1>

    <div id="tabs" style="height: 300px;overflow-y: auto;min-width: 800px;">
        <ul>
            <g:each in="${modulos}" var="mod" status="i">
                <li><a href="#tabs-${i + 1}">${mod.nombre}</a></li>
            </g:each>
        </ul>

        <g:each in="${modulos}" var="mod" status="i">
            <div id="tabs-${i + 1}">
                <table style="width: 600px;" id="tabla_${mod.id}">
                    <thead>
                    <th width="150">Nombre</th>
                    <th width="250">Controlador</th>
                    <th width="130">Tipo</th>
                    <th width="150">Modulo</th>
                    </thead>
                    <tbody>
                    <g:each in="${Accn.findAllByModuloAndTipo(mod,Tpac.get(tipo_tpac),[sort:'control'])}" var="accn"
                            status="j">
                        <tr class="${(j % 2) == 0 ? 'odd' : 'even'}">
                            <td title="${accn.accnDescripcion}">${accn.accnNombre}</td>
                            <td>${accn.control}</td>
                            <td><g:select from="${cratos.seguridad.Tpac.list()}" optionKey="id" accn="${accn.id}"
                                          name="accn"
                                          value="${accn.tipo.id}" id="tipo_${accn.id}" class="combo"
                                          style="margin-left: 15px; width:100px;"/></td>
                            <td><g:select from="${modulos}" optionKey="id" mod="${mod.id}" accn="${accn.id}"
                                          name="modulo"
                                          value="${accn.modulo.id}" id="modulo_${accn.id}" class="comboModulo"
                                          style="margin-left: 15px; width:120px;"/></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </g:each>

    </div>

    <div id="" class="toolbar ui-widget-header ui-corner-all">
        <a id="btenviar" href="#">Enviar al m&oacute;dulo</a>
        <g:select optionKey="id" from="${cratos.seguridad.Modulo.list()}" name="modulo" value="${modulo?.id}"></g:select>
        <a id="btagregar" href="#">Agregar al m&oacute;dulo</a>
        <a id="btcambiar" href="#">Cambiar de Men&uacute; a Porceso o viceversa</a>
    </div>


    <h1>Por controladores</h1>

    <div id="tabs2" style="height: 450px;overflow-y: auto;min-width: 800px;">
        <ul>
            <li><a href="#tabs-1">Controladores</a></li>
        </ul>

        <div id="tabs-1">
            <table style="width: 600px;">
                <thead>
                <th width="450">Nombre</th>
                <th width="150">Modulo</th>
                </thead>
                <tbody>
                <g:each in="${controladores}" var="ct" status="j">
                    <tr class="${(j % 2) == 0 ? 'odd' : 'even'}">
                        <td title="${ct}">${ct}</td>
                        <td><g:select from="${modulos}" optionKey="id" name="modulo" class="comboModuloCtrl" ct="${ct}"
                                      style="margin-left: 15px; width:120px;" noSelection="${[0:'Seleccione']}"/></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>

    <div id="ajx_menu" style="width:400px;"></div>
</div>

<script type="text/javascript">

    $("#nada").button().click(function() {
        location.href = "#"
    });


    $("#verProceso").button().click(function() {
        //alert("clic en procesos")
        location.href = "${createLink(controller:'acciones',action:'procesos')}"
    });

    $("#verMenu").button().click(function() {
        location.href = "${createLink(controller:'acciones',action:'configurarAcciones')}"
    });

    $("#editaMod").button().click(function() {
        location.href = "${createLink(controller:'modulo',action:'create')}"
    });
    $("#borraMod").button().click(function() {
        location.href = "${createLink(controller:'modulo',action:'create')}"
    });


    %{-- TODO --}%
    %{-- implementar acciones y hacer el ingreso de etiqueta de acciones, algo pareceido a lo de finis con--}%
    %{--   el botón grabar alado--}%
    %{-- */--}%
    $("#btenviar").button().click(function() {
        location.href = "${createLink(controller:'hacer',action:'hacer')}"
    });
    $("#btagregar").button().click(function() {
        location.href = "${createLink(controller:'hacer',action:'hacer')}"
    });
    $("#btcambiar").button().click(function() {
        location.href = "${createLink(controller:'hacer',action:'hacer')}"
    });


    $("#tabs").tabs();
    $("#tabs2").tabs();
    $(".combo").change(function() {
        $.ajax({
            type: "POST",
            url: "${createLink(action:'cambiarTipo')}",
            data: {
                accn:$(this).attr("accn"),
                val:$(this).val()
            },
            success: function(msg) {

            }
        });
    });

    $(".comboModulo").change(function() {
        var sel = $(this);
        $.ajax({
            type: "POST",
            url: "${createLink(action:'cambiarModulo')}",
            data: {
                accn:$(this).attr("accn"),
                val:$(this).val()
            },
            success: function(msg) {
                if (msg == "ok") {
                    var tr = sel.parent().parent();
                    $("#tabla_" + sel.val()).prepend(tr);
                }
            }
        });
    });
    $(".comboModuloCtrl").change(function() {
        $.ajax({
            type: "POST",
            url: "${createLink(action:'cambiarModuloControlador')}",
            data: {
                ctrl:$(this).attr("ct"),
                val:$(this).val()
            },
            success: function(msg) {
                if (msg == "ok")
                    location.reload()
            }
        });
    });

    //módulos
    $("#nuevoMod").button().click(function() {
        if (confirm("Crear un nuevo módulo \n")) {
            $.ajax({
                type: "POST", url: "../creaMdlo",
                data: "&pdre=0",
                success: function(msg) {
                    $("#ajx_menu").html(msg).show("puff", 100)
                }
            });
            $("#ajx_menu").dialog("open");
        }
    });

    $("#ajx_menu").dialog({
        autoOpen: false,
        resizable:false,
        title: 'Crear un Módulo',
        modal:true,
        draggable:false,
        width:400,
        position: 'center',
        open: function(event, ui) {
            $(".ui-dialog-titlebar-close").hide();
        },
        buttons: {
            "Grabar": function() {
                $(this).dialog("close");
                $.ajax({
                    type: "POST", url: "../grabaMdlo",
                    data: "&nombre=" + $('#nombre').val() + "&descripcion=" + $('#descripcion').val() +
                            "&id=" + $('#id_mdlo').val() + "&orden=" + $('#orden').val(),
                    success: function(msg) {
                        $("#ajx").html(msg)
                        location.reload(true);

                    }
                });
            },
            "Cancelar": function() {
                $(this).dialog("close");
            }
        }
    });

</script>

</body>
</html>