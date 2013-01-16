
<%@ page import="cratos.ReporteCuenta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Reporte de Cuentas</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Reporte de Cuentas
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>

                </div>
            </div>

            <div id="list-reporteCuenta" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-reporteCuenta">
                    <thead>
                        <tr>
                            
                            <th><g:message code="reporteCuenta.empresa.label" default="Empresa" /></th>
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'reporteCuenta.descripcion.label', default: 'Descripción')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-reporteCuenta">
                        <g:each in="${reporteCuentaInstanceList}" status="i" var="reporteCuentaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${reporteCuentaInstance.id}">
                                
                                <td>${fieldValue(bean: reporteCuentaInstance, field: "empresa")}</td>
                                
                                <td>${fieldValue(bean: reporteCuentaInstance, field: "descripcion")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${reporteCuentaInstanceList.size() < reporteCuentaInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${reporteCuentaInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-reporteCuenta" class="contextMenu">
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

        <div id="dlg-reporteCuenta"></div>

        <div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
            Cargando.....Por favor espere......<br/><br/>
            <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
        </div>

        <script type="text/javascript">
            function openDlg(url, id, cont, ajax, title, buttons) {
                if (ajax) {
                $("#dlgLoad").dialog("open");
                    $.ajax({
                        async   : false,
                        type    : "POST",
                        url     : url,
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            $("#dlg-reporteCuenta").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-reporteCuenta").dialog("option", "width", 520);
                } else {
                $("#dlg-reporteCuenta").html(cont);
                }
                $("#dlg-reporteCuenta").dialog("option", "title", title);
                $("#dlg-reporteCuenta").dialog("option", "buttons", buttons);
                $("#dlg-reporteCuenta").dialog("open");
            }

            function submitForm() {
                if ($("#frm-reporteCuenta").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-reporteCuenta").serialize();
                    var url = $("#frm-reporteCuenta").attr("action");

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

                $("#dlg-reporteCuenta").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : "center"
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-reporteCuenta").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-reporteCuenta").find("tr").hover(function () {
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
                            var title = "Crear Reporte de Cuenta";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-reporteCuenta").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-reporteCuenta").find("tr").contextMenu({
                            menu : "menu-reporteCuenta"
                        },
                        function (action, el, pos) {
                            $("#dlg-reporteCuenta").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Reporte de Cuenta";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-reporteCuenta").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Reporte de Cuenta";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-reporteCuenta").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Reporte de Cuenta";
                                    buttons = {
                                        "Aceptar"  : function () {
                                            $("#dlgLoad").dialog("open");
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(action:'delete')}",
                                                data    : {
                                                    id : id
                                                },
                                                success : function (msg) {
                                                    location.reload(true);
                                                }
                                            });
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-reporteCuenta").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Reporte de Cuenta?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-reporteCuenta").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
