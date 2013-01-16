
<%@ page import="cratos.DocumentosProceso" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de DocumentosProcesos</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de DocumentosProcesos
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-documentosProceso" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-documentosProceso">
                    <thead>
                        <tr>
                            
                            <th><g:message code="documentosProceso.proceso.label" default="Proceso" /></th>
                            
                            <th><g:message code="documentosProceso.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" /></th>
                            
                            <th><g:message code="documentosProceso.tipoComprobanteId.label" default="Tipo Comprobante Id" /></th>
                            
                            <g:sortableColumn property="documentosProcesoSerie01" title="${message(code: 'documentosProceso.documentosProcesoSerie01.label', default: 'Documentos Proceso Serie01')}" />
                            
                            <g:sortableColumn property="documentosProcesoSerie02" title="${message(code: 'documentosProceso.documentosProcesoSerie02.label', default: 'Documentos Proceso Serie02')}" />
                            
                            <g:sortableColumn property="secuencial" title="${message(code: 'documentosProceso.secuencial.label', default: 'Secuencial')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-documentosProceso">
                        <g:each in="${documentosProcesoInstanceList}" status="i" var="documentosProcesoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${documentosProcesoInstance.id}">
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "proceso")}</td>
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "tipoDocumentoProveedor")}</td>
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "tipoComprobanteId")}</td>
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "documentosProcesoSerie01")}</td>
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "documentosProcesoSerie02")}</td>
                                
                                <td>${fieldValue(bean: documentosProcesoInstance, field: "secuencial")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${documentosProcesoInstanceList.size() < documentosProcesoInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${documentosProcesoInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-documentosProceso" class="contextMenu">
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

        <div id="dlg-documentosProceso"></div>

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
                            $("#dlg-documentosProceso").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-documentosProceso").dialog("option", "width", 420);
                } else {
                $("#dlg-documentosProceso").html(cont);
                }
                $("#dlg-documentosProceso").dialog("option", "title", title);
                $("#dlg-documentosProceso").dialog("option", "buttons", buttons);
                $("#dlg-documentosProceso").dialog("open");
            }

            function submitForm() {
                if ($("#frm-documentosProceso").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-documentosProceso").serialize();
                    var url = $("#frm-documentosProceso").attr("action");

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

                $("#dlg-documentosProceso").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-documentosProceso").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-documentosProceso").find("tr").hover(function () {
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
                            var title = "Crear DocumentosProceso";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-documentosProceso").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-documentosProceso").find("tr").contextMenu({
                            menu : "menu-documentosProceso"
                        },
                        function (action, el, pos) {
                            $("#dlg-documentosProceso").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar DocumentosProceso";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-documentosProceso").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver DocumentosProceso";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-documentosProceso").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar DocumentosProceso";
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
                                            $("#dlg-documentosProceso").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este DocumentosProceso?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-documentosProceso").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
