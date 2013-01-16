<%@ page import="cratos.DetalleAdquisicion; cratos.Adquisiciones" %>
<!doctype html>
<html>
<<<<<<< BEGIN MERGE CONFLICT: local copy shown first <<<<<<<<<<<<<<<
<head>
    <meta name="layout" content="main">
    <title>Lista de Adquisiciones</title>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}"
          type="text/css">

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

</head>

<body>
<div class="ui-widget-content ui-corner-all cont">
    <div class="ui-widget-header ui-corner-all titulo">
        Lista de Adquisiciones
        <div class="fright">
            <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
        </div>
    </div>

    <div id="list-adquisiciones" class="content scaffold-list" role="main">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table id="tbl-adquisiciones">
            <thead>
            <tr>
                <g:sortableColumn property="id" title="${message(code: 'id', default: '#')}" style="width: 50px"/>
                <g:sortableColumn property="proveedor"
                                  title="${message(code: 'adquisiciones.proveedor.label', default: 'Proveedor')}"/>
                <g:sortableColumn property="fecha"
                                  title="${message(code: 'adquisiciones.fecha.label', default: 'Fecha')}"/>
                <g:sortableColumn property="total"
                                  title="${message(code: 'adquisicionesInstance.total.label', default: 'Valor')}"/>
            </tr>
            </thead>
            <tbody id="tb-adquisiciones">
            <g:each in="${adquisicionesInstanceList}" status="i" var="adquisicionesInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${adquisicionesInstance.id}">
                    <td style="width: 50px;">${adquisicionesInstance.id}</td>
                    <td>${adquisicionesInstance.proveedor}</td>
                    <td>${adquisicionesInstance.fecha.format("yyyy-MM-dd")}</td>
                    <td><g:formatNumber number="${adquisicionesInstance.totalAdq()}" format="###,##0"
                                        minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <g:if test="${adquisicionesInstanceList.size() < adquisicionesInstanceTotal}">
            <div class="pagination">
                <g:paginate total="${adquisicionesInstanceTotal}" prev="Ant." next="Sig."/>
======= COMMON ANCESTOR content follows ============================
    <head>
        <meta name="layout" content="main">
        <title>Lista de Adquisiciones</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>

    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Adquisiciones
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-adquisiciones" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-adquisiciones">
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'id', default: '#')}" style="width: 50px"  />
                            <g:sortableColumn property="proveedor" title="${message(code: 'adquisiciones.proveedor.label', default: 'Proveedor')}"/>
                            <g:sortableColumn property="fecha" title="${message(code: 'adquisiciones.fecha.label', default: 'Fecha')}"/>
                            <g:sortableColumn property="total" title="${message(code: 'adquisicionesInstance.total.label', default: 'Valor')}"/>
                        </tr>
                    </thead>
                    <tbody id="tb-adquisiciones">
                        <g:each in="${adquisicionesInstanceList}" status="i" var="adquisicionesInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${adquisicionesInstance.id}">
                                <td style="width: 50px;">${adquisicionesInstance.id}</td>
                                <td>${adquisicionesInstance.proveedor}</td>
                                <td>${adquisicionesInstance.fecha.format("yyyy-MM-dd")}</td>
                                <td><g:formatNumber number="${adquisicionesInstance.totalAdq()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${adquisicionesInstanceList.size() < adquisicionesInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${adquisicionesInstanceTotal}" prev="Ant." next="Sig."/>
                    </div>
                </g:if>
======= MERGED IN content follows ==================================
    <head>
        <meta name="layout" content="main">
        <title>Lista de Adquisiciones</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>

    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Adquisiciones
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-adquisiciones" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-adquisiciones">
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'id', default: '#')}" style="width: 50px"  />
                            <g:sortableColumn property="proveedor" title="${message(code: 'adquisiciones.proveedor.label', default: 'Proveedor')}"/>
                            <g:sortableColumn property="fecha" title="${message(code: 'adquisiciones.fecha.label', default: 'Fecha')}"/>
                            <g:sortableColumn property="total" title="${message(code: 'adquisicionesInstance.total.label', default: 'Valor')}"/>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody id="tb-adquisiciones">
                        <g:each in="${adquisicionesInstanceList}" status="i" var="adquisicionesInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${adquisicionesInstance.id}">
                                <td style="width: 50px;">${adquisicionesInstance.id}</td>
                                <td>${adquisicionesInstance.proveedor}</td>
                                <td>${adquisicionesInstance.fecha.format("yyyy-MM-dd")}</td>
                                <td><g:formatNumber number="${adquisicionesInstance.totalAdq()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                <td>${(adquisicionesInstance.estado=="R")?"Registrada":"No registrada"}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${adquisicionesInstanceList.size() < adquisicionesInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${adquisicionesInstanceTotal}" prev="Ant." next="Sig."/>
                    </div>
                </g:if>
>>>>>>> END MERGE CONFLICT >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            </div>
        </g:if>
    </div>
</div>

<ul id="menu-adquisiciones" class="contextMenu">
    <li class="show">
        <a href="#show">Ver</a>
    </li>
    <li class="revisar">

        <a href="#revisarAdquisicion">Revisar</a>
    </li>
    %{--<li class="edit">--}%
    %{--<a href="#edit">Editar</a>--}%
    %{--</li>--}%
    %{--<li class="delete">--}%
    %{--<a href="#delete">Eliminar</a>--}%
    %{--</li>--}%
</ul>

<div id="dlg-adquisiciones" style="width: 960px;height: 470px"></div>

<div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
    Cargando.....Por favor espere......<br/><br/>
    <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
</div>

<script type="text/javascript">
    function openDlg(url, id, cont, ajax, title, buttons) {
        if (ajax) {
            $("#dlgLoad").dialog("open");
            $.ajax({
                async:false,
                type:"POST",
                url:url,
                data:{
                    id:id
                },
                success:function (msg) {
                    $("#dlg-adquisiciones").html(msg);
                },
                complete:function () {
                    $("#dlgLoad").dialog("close");
                }
            });
            $("#dlg-adquisiciones").dialog("option", "width", 960);
        } else {
            $("#dlg-adquisiciones").html(cont);
        }
        $("#dlg-adquisiciones").dialog("option", "title", title);
        $("#dlg-adquisiciones").dialog("option", "buttons", buttons);
        $("#dlg-adquisiciones").dialog("open");
    }

    function submitForm() {
        if ($("#frm-adquisiciones").valid()) {
            $("#dlgLoad").dialog("open");
            var data = $("#frm-adquisiciones").serialize();
            var url = $("#frm-adquisiciones").attr("action");

            $.ajax({
                type:"POST",
                url:url,
                data:data,
                success:function (msg) {
                    location.reload(true);
                }
            });
        }
    }

    $(function () {
        $("#dlgLoad").dialog({
            modal:true,
            autoOpen:false,
            closeOnEscape:false,
            draggable:false,
            resizable:false,
            zIndex:9000,
            open:function (event, ui) {
                $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
            }
        });

        $("#dlg-adquisiciones").dialog({
            modal:true,
            autoOpen:false,
            width:960,
            zIndex:1000,
            position:"center"
        });

        $("th").hover(function () {
            $(this).addClass("hover");
            var i = $(this).index();
            $("#tb-adquisiciones").find("tr").each(function () {
                $(this).children().eq(i).addClass("hover");
            });
        }, function () {
            $(".hover").removeClass("hover");
        });

        $("#tb-adquisiciones").find("tr").hover(function () {
            $(this).addClass("hover");
        }, function () {
            $(".hover").removeClass("hover");
        });

//                $(".btnNew").button({
//                    icons : {
//                        primary : "ui-icon-document"
//                    }
//                }).click(function () {
//                            var id = $(this).attr("id");
//                            var url = $(this).attr("href");
//                            var title = "Crear Adquisiciones";
//                            var buttons = {
//                                "Guardar"  : function () {
//                                    submitForm();
//                                },
//                                "Cancelar" : function () {
//                                    $("#dlg-adquisiciones").dialog("close");
//                                }
//                            };
//                            openDlg(url, id, "", true, title, buttons);
//                            return false;
//                        });

        $(".btnNew").button({
            icons:{

                primary:"ui-icon-document"
            }

        });

        $("#tb-adquisiciones").find("tr").contextMenu({
                    menu:"menu-adquisiciones"
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
                                "Aceptar":function () {
//                                            $("#dlg-adquisiciones").dialog("close");

                                }
                            };
                            url = "${createLink(controller: 'adquisiciones', action:'show')}/" + id;

                            location.href = url;

                            break;

                        case "revisarAdquisicion":

                                console.log ("entra")

                            title = "Revisar Adquisiciones";

                            buttons = {

                                "Aceptar":function () {

                                }

                            };

                            url = "${createLink (controller: 'adquisiciones', action: 'revisarAdquisicion')}/" +id;
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
</body>
</html>
