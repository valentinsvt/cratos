
<%@ page import="cratos.TipoComprobanteId" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de TipoComprobanteIds</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de TipoComprobanteIds
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-tipoComprobanteId" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-tipoComprobanteId">
                    <thead>
                        <tr>
                            
                            <th><g:message code="tipoComprobanteId.tipoIdentificacion.label" default="Tipo Identificacion" /></th>
                            
                            <th><g:message code="tipoComprobanteId.tipoComprobanteSri.label" default="Tipo Comprobante Sri" /></th>
                            
                        </tr>
                    </thead>
                    <tbody id="tb-tipoComprobanteId">
                        <g:each in="${tipoComprobanteIdInstanceList}" status="i" var="tipoComprobanteIdInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${tipoComprobanteIdInstance.id}">
                                
                                <td>${fieldValue(bean: tipoComprobanteIdInstance, field: "tipoIdentificacion")}</td>
                                
                                <td>${fieldValue(bean: tipoComprobanteIdInstance, field: "tipoComprobanteSri")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${tipoComprobanteIdInstanceList.size() < tipoComprobanteIdInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${tipoComprobanteIdInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-tipoComprobanteId" class="contextMenu">
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

        <div id="dlg-tipoComprobanteId"></div>

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
                            $("#dlg-tipoComprobanteId").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-tipoComprobanteId").dialog("option", "width", 700);
                } else {
                $("#dlg-tipoComprobanteId").html(cont);
                }
                $("#dlg-tipoComprobanteId").dialog("option", "title", title);
                $("#dlg-tipoComprobanteId").dialog("option", "buttons", buttons);
                $("#dlg-tipoComprobanteId").dialog("open");
            }

            function submitForm() {
                if ($("#frm-tipoComprobanteId").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-tipoComprobanteId").serialize();
                    var url = $("#frm-tipoComprobanteId").attr("action");

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

                $("#dlg-tipoComprobanteId").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-tipoComprobanteId").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-tipoComprobanteId").find("tr").hover(function () {
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
                            var title = "Crear TipoComprobanteId";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-tipoComprobanteId").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-tipoComprobanteId").find("tr").contextMenu({
                            menu : "menu-tipoComprobanteId"
                        },
                        function (action, el, pos) {
                            $("#dlg-tipoComprobanteId").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar TipoComprobanteId";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-tipoComprobanteId").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver TipoComprobanteId";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-tipoComprobanteId").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar TipoComprobanteId";
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
                                            $("#dlg-tipoComprobanteId").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este TipoComprobanteId?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-tipoComprobanteId").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
