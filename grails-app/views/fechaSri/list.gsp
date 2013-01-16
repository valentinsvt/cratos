
<%@ page import="cratos.FechaSri" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Fecha SRI</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Fecha SRI
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-fechaSri" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-fechaSri">
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="numero" title="${message(code: 'fechaSri.numero.label', default: 'Número')}" />
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'fechaSri.descripcion.label', default: 'Descripción')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-fechaSri">
                        <g:each in="${fechaSriInstanceList}" status="i" var="fechaSriInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${fechaSriInstance.id}">
                                
                                <td>${fieldValue(bean: fechaSriInstance, field: "numero")}</td>
                                
                                <td>${fieldValue(bean: fechaSriInstance, field: "descripcion")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${fechaSriInstanceList.size() < fechaSriInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${fechaSriInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-fechaSri" class="contextMenu">
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

        <div id="dlg-fechaSri"></div>

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
                            $("#dlg-fechaSri").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-fechaSri").dialog("option", "width", 580);
                } else {
                $("#dlg-fechaSri").html(cont);
                }
                $("#dlg-fechaSri").dialog("option", "title", title);
                $("#dlg-fechaSri").dialog("option", "buttons", buttons);
                $("#dlg-fechaSri").dialog("open");
            }

            function submitForm() {
                if ($("#frm-fechaSri").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-fechaSri").serialize();
                    var url = $("#frm-fechaSri").attr("action");

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

                $("#dlg-fechaSri").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : "center"
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-fechaSri").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-fechaSri").find("tr").hover(function () {
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
                            var title = "Crear FechaSri";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-fechaSri").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-fechaSri").find("tr").contextMenu({
                            menu : "menu-fechaSri"
                        },
                        function (action, el, pos) {
                            $("#dlg-fechaSri").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar FechaSri";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-fechaSri").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver FechaSri";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-fechaSri").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar FechaSri";
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
                                            $("#dlg-fechaSri").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este FechaSri?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-fechaSri").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
