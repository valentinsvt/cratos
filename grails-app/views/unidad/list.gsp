
<%@ page import="cratos.Unidad" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Unidades</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Unidades
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-unidad" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-unidad">
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="codigo" title="${message(code: 'unidad.codigo.label', default: 'Código')}" />
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'unidad.descripcion.label', default: 'Descripción')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-unidad">
                        <g:each in="${unidadInstanceList}" status="i" var="unidadInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${unidadInstance.id}">
                                
                                <td>${fieldValue(bean: unidadInstance, field: "codigo")}</td>
                                
                                <td>${fieldValue(bean: unidadInstance, field: "descripcion")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${unidadInstanceList.size() < unidadInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${unidadInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-unidad" class="contextMenu">
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

        <div id="dlg-unidad"></div>

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
                            $("#dlg-unidad").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-unidad").dialog("option", "width", 550);
                } else {
                $("#dlg-unidad").html(cont);
                }
                $("#dlg-unidad").dialog("option", "title", title);
                $("#dlg-unidad").dialog("option", "buttons", buttons);
                $("#dlg-unidad").dialog("open");
            }

            function submitForm() {
                if ($("#frm-unidad").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-unidad").serialize();
                    var url = $("#frm-unidad").attr("action");

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

                $("#dlg-unidad").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : "center"
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-unidad").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-unidad").find("tr").hover(function () {
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
                            var title = "Crear Unidad";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-unidad").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-unidad").find("tr").contextMenu({
                            menu : "menu-unidad"
                        },
                        function (action, el, pos) {
                            $("#dlg-unidad").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Unidad";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-unidad").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Unidad";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-unidad").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Unidad";
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
                                            $("#dlg-unidad").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Unidad?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-unidad").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
