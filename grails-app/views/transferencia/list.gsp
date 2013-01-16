<%@ page import="cratos.Transferencia" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'transferencia.label', default: 'Transferencia')}"/>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <title>Lista de Transferencia</title>
    </head>

    <body>
        <a href="#list-transferencia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-transferencia" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="create linkButton" action="create" icon="ui-icon-document">Crear Transferencia</g:link></li>
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Transferencia</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="fecha" title="Fecha"/>
                            <th>Empresa</th>
                            <th>Bodega Sale</th>
                            <th>Bodega Recibe</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody id="tb-transferencias">
                        <g:each in="${transferenciaInstanceList}" status="i" var="transferenciaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${transferenciaInstance.id}">
                                <td><g:formatDate date="${transferenciaInstance.fecha}" format="yyyy-MM-dd"/></td>
                                <td>${fieldValue(bean: transferenciaInstance, field: "empresa")}</td>
                                <td>${fieldValue(bean: transferenciaInstance, field: "bodegaSale.descripcion")}</td>
                                <td>${fieldValue(bean: transferenciaInstance, field: "bodegaRecibe.descripcion")}</td>
                                <td>
                                    <g:formatBoolean boolean="${transferenciaInstance.estado == 'N'}" true="No registrado" false="Registrado"/>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>


            <ul id="menu-transferencias" class="contextMenu">
                <li class="show">
                    <a href="#show">Ver</a>
                </li>
                %{--<li class="edit">--}%
                %{--<a href="#edit">Editar</a>--}%
                %{--</li>--}%
                %{--<li class="delete">--}%
                %{--<a href="#delete">Eliminar</a>--}%
                %{--</li>--}%
            </ul>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${transferenciaInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

            <script type="text/javascript">
                $(function () {
                    $("#tb-transferencias").find("tr").contextMenu({
                                menu : "menu-transferencias"
                            },
                            function (action, el, pos) {
//                            $("#dlg-adquisiciones").html("");
                                var id = $(el).attr("id");
                                var title, buttons, url, cont;
                                switch (action) {
                                        %{--case "edit":--}%
                                        %{--title = "Editar Adquisiciones";--}%
                                        %{--buttons = {--}%
                                        %{--"Guardar"  : function () {--}%
                                        %{--submitForm();--}%
                                        %{--},--}%
                                        %{--"Cancelar" : function () {--}%
                                        %{--$("#dlg-adquisiciones").dialog("close");--}%
                                        %{--}--}%
                                        %{--};--}%
                                        %{--url = "${createLink(action:'edit')}/" + id;--}%
                                        %{--break;--}%
                                    case "show":
//
                                        title = "Ver Adquisiciones";
                                        buttons = {
                                            "Aceptar" : function () {
//                                            $("#dlg-adquisiciones").dialog("close");

                                            }
                                        };
                                        var url = "${createLink(controller: 'transferencia', action:'show')}/" + id;

                                        location.href = url;

                                        break;

                                        %{--case "delete":--}%
                                        %{--title = "Eliminar Adquisiciones";--}%
                                        %{--buttons = {--}%
                                        %{--"Aceptar"  : function () {--}%
                                        %{--$("#dlgLoad").dialog("open");--}%
                                        %{--$.ajax({--}%
                                        %{--type    : "POST",--}%
                                        %{--url     : "${createLink(action:'delete')}",--}%
                                        %{--data    : {--}%
                                        %{--id : id--}%
                                        %{--},--}%
                                        %{--success : function (msg) {--}%
                                        %{--location.reload(true);--}%
                                        %{--}--}%
                                        %{--});--}%
                                        %{--},--}%
                                        %{--"Cancelar" : function () {--}%
                                        %{--$("#dlg-adquisiciones").dialog("close");--}%
                                        %{--}--}%
                                        %{--};--}%
                                        %{--cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Adquisiciones?";--}%
                                        %{--cont += "<br/>Esta acci&oacute;n es definitiva.</span>"--}%
                                        %{--$("#dlg-adquisiciones").dialog("option", "width", 360);--}%
                                        %{--break;--}%
                                }
//                            openDlg(url, id, cont, action != "delete", title, buttons);

                            });
                });
            </script>

        </div>
    </body>
</html>
