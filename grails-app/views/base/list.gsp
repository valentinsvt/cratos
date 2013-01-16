
<%@ page import="cratos.Base" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Bases</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Bases
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-base" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-base">
                    <thead>
                        <tr>
                            
                            <th><g:message code="base.periodo.label" default="Periodo" /></th>
                            
                            <g:sortableColumn property="fraccionBasica" title="${message(code: 'base.fraccionBasica.label', default: 'Fraccion Basica')}" />
                            
                            <g:sortableColumn property="excesoHasta" title="${message(code: 'base.excesoHasta.label', default: 'Exceso Hasta')}" />
                            
                            <g:sortableColumn property="impuestosFraccion" title="${message(code: 'base.impuestosFraccion.label', default: 'Impuestos Fraccion')}" />
                            
                            <g:sortableColumn property="porcentaje" title="${message(code: 'base.porcentaje.label', default: 'Porcentaje')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-base">
                        <g:each in="${baseInstanceList}" status="i" var="baseInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${baseInstance.id}">
                                
                                <td>${fieldValue(bean: baseInstance, field: "periodo")}</td>
                                
                                <td>${fieldValue(bean: baseInstance, field: "fraccionBasica")}</td>
                                
                                <td>${fieldValue(bean: baseInstance, field: "excesoHasta")}</td>
                                
                                <td>${fieldValue(bean: baseInstance, field: "impuestosFraccion")}</td>
                                
                                <td>${fieldValue(bean: baseInstance, field: "porcentaje")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${baseInstanceList.size() < baseInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${baseInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-base" class="contextMenu">
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

        <div id="dlg-base"></div>

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
                            $("#dlg-base").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-base").dialog("option", "width", 420);
                } else {
                $("#dlg-base").html(cont);
                }
                $("#dlg-base").dialog("option", "title", title);
                $("#dlg-base").dialog("option", "buttons", buttons);
                $("#dlg-base").dialog("open");
            }

            function submitForm() {
                if ($("#frm-base").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-base").serialize();
                    var url = $("#frm-base").attr("action");

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

                $("#dlg-base").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-base").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-base").find("tr").hover(function () {
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
                            var title = "Crear Base";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-base").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-base").find("tr").contextMenu({
                            menu : "menu-base"
                        },
                        function (action, el, pos) {
                            $("#dlg-base").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Base";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-base").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Base";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-base").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Base";
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
                                            $("#dlg-base").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Base?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-base").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
