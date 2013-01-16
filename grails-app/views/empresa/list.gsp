<%@ page import="cratos.Empresa" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Empresas</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>

    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Empresas
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-empresa" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-empresa">
                    <thead>
                        <tr>

                            <g:sortableColumn property="nombre" title="${message(code: 'empresa.nombre.label', default: 'Nombre')}"/>

                            <g:sortableColumn property="ruc" title="${message(code: 'empresa.ruc.label', default: 'Ruc')}"/>

                            <g:sortableColumn property="tipoEmpresa" title="${message(code: 'empresa.tipoEmpresa.label', default: 'TipoEmpresa')}"/>

                            <g:sortableColumn property="telefono" title="${message(code: 'empresa.telefono.label', default: 'Telefono')}"/>

                            <g:sortableColumn property="direccion" title="${message(code: 'empresa.direccion.label', default: 'Direccion')}"/>

                            <g:sortableColumn property="ordenCompra" title="${message(code: 'empresa.ordenCompra.label', default: 'Ordenes de compra')}"/>

                        </tr>
                    </thead>
                    <tbody id="tb-empresa">
                        <g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${empresaInstance.id}">

                                <td>${fieldValue(bean: empresaInstance, field: "nombre")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "ruc")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "tipoEmpresa")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "telefono")}</td>

                                <td>${fieldValue(bean: empresaInstance, field: "direccion")}</td>

                                <td>
                                    <g:formatBoolean boolean="${empresaInstance.ordenCompra == '1'}" true="Sí" false="No"/>
                                </td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${empresaInstanceList.size() < empresaInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${empresaInstanceTotal}" prev="Ant." next="Sig."/>
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-empresa" class="contextMenu">
            <li class="show">
                <a href="#show">Ver</a>
            </li>
            <li class="edit">
                <a href="#edit">Editar</a>
            </li>
            <li class="delete">
                <a href="#delete">Eliminar</a>
            </li>
        </ul>

        <div id="dlg-empresa" style="width: 690px; height: 470px"></div>

        <div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
            Cargando.....Por favor espere......<br/><br/>
            <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
        </div>

        <script type="text/javascript">
            function openDlg(url, id, cont, ajax, title, buttons) {
                if (ajax) {
                    $("#dlgLoad").dialog("open");
                    $.ajax({
                        async    : false,
                        type     : "POST",
                        url      : url,
                        data     : {
                            id : id
                        },
                        success  : function (msg) {
                            $("#dlg-empresa").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-empresa").dialog("option", "width", 690);
                } else {
                    $("#dlg-empresa").html(cont);
                }
                $("#dlg-empresa").dialog("option", "title", title);
                $("#dlg-empresa").dialog("option", "buttons", buttons);
                $("#dlg-empresa").dialog("open");
            }

            function submitForm() {
                if ($("#frm-empresa").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-empresa").serialize();
                    var url = $("#frm-empresa").attr("action");

                    $.ajax({
                        type    : "POST",
                        url     : url,
                        data    : data,
                        success : function (msg) {
                            location.reload(true);
                        }
                    });
                }
            }

            $(function () {
                $("#dlgLoad").dialog({
                    modal         : true,
                    autoOpen      : false,
                    closeOnEscape : false,
                    draggable     : false,
                    resizable     : false,
                    zIndex        : 9000,
                    open          : function (event, ui) {
                        $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
                    }
                });

                $("#dlg-empresa").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 690,
                    zIndex   : 1000,
                    position : "center"
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-empresa").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-empresa").find("tr").hover(function () {
                    $(this).addClass("hover");
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $(".btnNew").button({
                    icons : {
                        primary : "ui-icon-document"
                    }
                }).click(function () {
                            var id = $(this).attr("id");
                            var url = $(this).attr("href");
                            var title = "Crear Empresa";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-empresa").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-empresa").find("tr").contextMenu({
                            menu : "menu-empresa"
                        },
                        function (action, el, pos) {
                            $("#dlg-empresa").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Empresa";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-empresa").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Empresa";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-empresa").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Empresa";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlgLoad").dialog("open");
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(controller: 'empresa', action:'delete')}",
                                                data    : {
                                                    id : id
                                                },
                                                success : function (msg) {
                                                    location.reload(true);
                                                }
                                            });

                                        },

                                        "Cancelar" : function () {
                                            $("#dlg-empresa").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Empresa?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-empresa").dialog("option", "width", 360);
                                %{--url="${createLink(controller: 'empresa', action: 'delete')}"/ + id;--}%
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
