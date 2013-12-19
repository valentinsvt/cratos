
<%@ page import="cratos.SustentoTributario" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de SustentoTributarios</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de SustentoTributarios
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-sustentoTributario" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-sustentoTributario">
                    <thead>
                        <tr>
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'sustentoTributario.descripcion.label', default: 'Descripcion')}" />
                            
                            <g:sortableColumn property="codigo" title="${message(code: 'sustentoTributario.codigo.label', default: 'Codigo')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-sustentoTributario">
                        <g:each in="${sustentoTributarioInstanceList}" status="i" var="sustentoTributarioInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${sustentoTributarioInstance.id}">
                                
                                <td>${fieldValue(bean: sustentoTributarioInstance, field: "descripcion")}</td>
                                
                                <td>${fieldValue(bean: sustentoTributarioInstance, field: "codigo")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${sustentoTributarioInstanceList.size() < sustentoTributarioInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${sustentoTributarioInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-sustentoTributario" class="contextMenu">
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

        <div id="dlg-sustentoTributario"></div>

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
                            $("#dlg-sustentoTributario").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-sustentoTributario").dialog("option", "width", 420);
                } else {
                $("#dlg-sustentoTributario").html(cont);
                }
                $("#dlg-sustentoTributario").dialog("option", "title", title);
                $("#dlg-sustentoTributario").dialog("option", "buttons", buttons);
                $("#dlg-sustentoTributario").dialog("open");
            }

            function submitForm() {
                if ($("#frm-sustentoTributario").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-sustentoTributario").serialize();
                    var url = $("#frm-sustentoTributario").attr("action");

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

                $("#dlg-sustentoTributario").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-sustentoTributario").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-sustentoTributario").find("tr").hover(function () {
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
                            var title = "Crear SustentoTributario";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-sustentoTributario").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-sustentoTributario").find("tr").contextMenu({
                            menu : "menu-sustentoTributario"
                        },
                        function (action, el, pos) {
                            $("#dlg-sustentoTributario").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar SustentoTributario";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-sustentoTributario").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver SustentoTributario";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-sustentoTributario").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar SustentoTributario";
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
                                            $("#dlg-sustentoTributario").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este SustentoTributario?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-sustentoTributario").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
