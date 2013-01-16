
<%@ page import="cratos.DocumentosProveedor" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de DocumentosProveedors</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de DocumentosProveedors
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-documentosProveedor" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-documentosProveedor">
                    <thead>
                        <tr>
                            
                            <th><g:message code="documentosProveedor.proveedor.label" default="Proveedor" /></th>
                            
                            <th><g:message code="documentosProveedor.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" /></th>
                            
                            <g:sortableColumn property="documentosProveedorSerie01" title="${message(code: 'documentosProveedor.documentosProveedorSerie01.label', default: 'Documentos Proveedor Serie01')}" />
                            
                            <g:sortableColumn property="documentosProveedorSerie02" title="${message(code: 'documentosProveedor.documentosProveedorSerie02.label', default: 'Documentos Proveedor Serie02')}" />
                            
                            <g:sortableColumn property="fechaAutorizacionSRI" title="${message(code: 'documentosProveedor.fechaAutorizacionSRI.label', default: 'Fecha Autorizacion SRI')}" />
                            
                            <g:sortableColumn property="fechaValidoHasta" title="${message(code: 'documentosProveedor.fechaValidoHasta.label', default: 'Fecha Valido Hasta')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-documentosProveedor">
                        <g:each in="${documentosProveedorInstanceList}" status="i" var="documentosProveedorInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${documentosProveedorInstance.id}">
                                
                                <td>${fieldValue(bean: documentosProveedorInstance, field: "proveedor")}</td>
                                
                                <td>${fieldValue(bean: documentosProveedorInstance, field: "tipoDocumentoProveedor")}</td>
                                
                                <td>${fieldValue(bean: documentosProveedorInstance, field: "documentosProveedorSerie01")}</td>
                                
                                <td>${fieldValue(bean: documentosProveedorInstance, field: "documentosProveedorSerie02")}</td>
                                
                                <td><g:formatDate date="${documentosProveedorInstance.fechaAutorizacionSRI}" /></td>
                                
                                <td><g:formatDate date="${documentosProveedorInstance.fechaValidoHasta}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${documentosProveedorInstanceList.size() < documentosProveedorInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${documentosProveedorInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-documentosProveedor" class="contextMenu">
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

        <div id="dlg-documentosProveedor"></div>

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
                            $("#dlg-documentosProveedor").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-documentosProveedor").dialog("option", "width", 420);
                } else {
                $("#dlg-documentosProveedor").html(cont);
                }
                $("#dlg-documentosProveedor").dialog("option", "title", title);
                $("#dlg-documentosProveedor").dialog("option", "buttons", buttons);
                $("#dlg-documentosProveedor").dialog("open");
            }

            function submitForm() {
                if ($("#frm-documentosProveedor").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-documentosProveedor").serialize();
                    var url = $("#frm-documentosProveedor").attr("action");

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

                $("#dlg-documentosProveedor").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-documentosProveedor").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-documentosProveedor").find("tr").hover(function () {
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
                            var title = "Crear DocumentosProveedor";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-documentosProveedor").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-documentosProveedor").find("tr").contextMenu({
                            menu : "menu-documentosProveedor"
                        },
                        function (action, el, pos) {
                            $("#dlg-documentosProveedor").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar DocumentosProveedor";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-documentosProveedor").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver DocumentosProveedor";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-documentosProveedor").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar DocumentosProveedor";
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
                                            $("#dlg-documentosProveedor").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este DocumentosProveedor?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-documentosProveedor").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
