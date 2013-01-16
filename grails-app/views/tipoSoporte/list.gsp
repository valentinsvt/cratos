
<%@ page import="cratos.TipoSoporte" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Tipo de Sustento Tributario</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de de Sustento Tributario
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-tipoSoporte" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-tipoSoporte">
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="codigo" title="${message(code: 'tipoSoporte.codigo.label', default: 'Codigo')}" />
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'tipoSoporte.descripcion.label', default: 'Descripcion')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-tipoSoporte">
                        <g:each in="${tipoSoporteInstanceList}" status="i" var="tipoSoporteInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${tipoSoporteInstance.id}">
                                
                                <td>${fieldValue(bean: tipoSoporteInstance, field: "codigo")}</td>
                                
                                <td>${fieldValue(bean: tipoSoporteInstance, field: "descripcion")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${tipoSoporteInstanceList.size() < tipoSoporteInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${tipoSoporteInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-tipoSoporte" class="contextMenu">
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

        <div id="dlg-tipoSoporte"></div>

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
                            $("#dlg-tipoSoporte").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-tipoSoporte").dialog("option", "width", 650);
                } else {
                $("#dlg-tipoSoporte").html(cont);
                }
                $("#dlg-tipoSoporte").dialog("option", "title", title);
                $("#dlg-tipoSoporte").dialog("option", "buttons", buttons);
                $("#dlg-tipoSoporte").dialog("open");
            }

            function submitForm() {
                if ($("#frm-tipoSoporte").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-tipoSoporte").serialize();
                    var url = $("#frm-tipoSoporte").attr("action");

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

                $("#dlg-tipoSoporte").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 620,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-tipoSoporte").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-tipoSoporte").find("tr").hover(function () {
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
                            var title = "Crear TipoSoporte";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-tipoSoporte").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-tipoSoporte").find("tr").contextMenu({
                            menu : "menu-tipoSoporte"
                        },
                        function (action, el, pos) {
                            $("#dlg-tipoSoporte").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar TipoSoporte";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-tipoSoporte").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver TipoSoporte";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-tipoSoporte").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar TipoSoporte";
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
                                            $("#dlg-tipoSoporte").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este TipoSoporte?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-tipoSoporte").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
