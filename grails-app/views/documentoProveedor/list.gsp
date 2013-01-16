
<%@ page import="cratos.DocumentoProveedor" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de DocumentoProveedors</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de DocumentoProveedors
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-documentoProveedor" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-documentoProveedor">
                    <thead>
                        <tr>
                            
                            <th><g:message code="documentoProveedor.proceso.label" default="Proceso" /></th>
                            
                            <th><g:message code="documentoProveedor.tipoDepartamento.label" default="Tipo Departamento" /></th>
                            
                            <g:sortableColumn property="numero" title="${message(code: 'documentoProveedor.numero.label', default: 'Numero')}" />
                            
                            <g:sortableColumn property="autorizacionSRI" title="${message(code: 'documentoProveedor.autorizacionSRI.label', default: 'Autorizacion SRI')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-documentoProveedor">
                        <g:each in="${documentoProveedorInstanceList}" status="i" var="documentoProveedorInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${documentoProveedorInstance.id}">
                                
                                <td>${fieldValue(bean: documentoProveedorInstance, field: "proceso")}</td>
                                
                                <td>${fieldValue(bean: documentoProveedorInstance, field: "tipoDepartamento")}</td>
                                
                                <td>${fieldValue(bean: documentoProveedorInstance, field: "numero")}</td>
                                
                                <td>${fieldValue(bean: documentoProveedorInstance, field: "autorizacionSRI")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${documentoProveedorInstanceList.size() < documentoProveedorInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${documentoProveedorInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-documentoProveedor" class="contextMenu">
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

        <div id="dlg-documentoProveedor"></div>

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
                            $("#dlg-documentoProveedor").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-documentoProveedor").dialog("option", "width", 420);
                } else {
                $("#dlg-documentoProveedor").html(cont);
                }
                $("#dlg-documentoProveedor").dialog("option", "title", title);
                $("#dlg-documentoProveedor").dialog("option", "buttons", buttons);
                $("#dlg-documentoProveedor").dialog("open");
            }

            function submitForm() {
                if ($("#frm-documentoProveedor").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-documentoProveedor").serialize();
                    var url = $("#frm-documentoProveedor").attr("action");

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

                $("#dlg-documentoProveedor").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-documentoProveedor").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-documentoProveedor").find("tr").hover(function () {
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
                            var title = "Crear DocumentoProveedor";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-documentoProveedor").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-documentoProveedor").find("tr").contextMenu({
                            menu : "menu-documentoProveedor"
                        },
                        function (action, el, pos) {
                            $("#dlg-documentoProveedor").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar DocumentoProveedor";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-documentoProveedor").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver DocumentoProveedor";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-documentoProveedor").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar DocumentoProveedor";
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
                                            $("#dlg-documentoProveedor").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este DocumentoProveedor?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-documentoProveedor").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
