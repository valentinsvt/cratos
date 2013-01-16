
<%@ page import="cratos.Rubro" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Rubros</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Rubros
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-rubro" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-rubro">
                    <thead>
                        <tr>
                            
                            <th><g:message code="rubro.tipoRubro.label" default="Tipo Rubro" /></th>
                            
                            <g:sortableColumn property="descripcion" title="${message(code: 'rubro.descripcion.label', default: 'Descripcion')}" />
                            
                            <g:sortableColumn property="porcentaje" title="${message(code: 'rubro.porcentaje.label', default: 'Porcentaje')}" />
                            
                            <g:sortableColumn property="editable" title="${message(code: 'rubro.editable.label', default: 'Editable')}" />
                            
                            <g:sortableColumn property="decimo" title="${message(code: 'rubro.decimo.label', default: 'Decimo')}" />
                            
                            <g:sortableColumn property="iess" title="${message(code: 'rubro.iess.label', default: 'Iess')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-rubro">
                        <g:each in="${rubroInstanceList}" status="i" var="rubroInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${rubroInstance.id}">
                                
                                <td>${fieldValue(bean: rubroInstance, field: "tipoRubro")}</td>
                                
                                <td>${fieldValue(bean: rubroInstance, field: "descripcion")}</td>
                                
                                <td>${fieldValue(bean: rubroInstance, field: "porcentaje")}</td>
                                
                                <td>${fieldValue(bean: rubroInstance, field: "editable")}</td>
                                
                                <td>${fieldValue(bean: rubroInstance, field: "decimo")}</td>
                                
                                <td>${fieldValue(bean: rubroInstance, field: "iess")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${rubroInstanceList.size() < rubroInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${rubroInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-rubro" class="contextMenu">
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

        <div id="dlg-rubro"></div>

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
                            $("#dlg-rubro").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-rubro").dialog("option", "width", 700);
                } else {
                $("#dlg-rubro").html(cont);
                }
                $("#dlg-rubro").dialog("option", "title", title);
                $("#dlg-rubro").dialog("option", "buttons", buttons);
                $("#dlg-rubro").dialog("open");
            }

            function submitForm() {
                if ($("#frm-rubro").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-rubro").serialize();
                    var url = $("#frm-rubro").attr("action");

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

                $("#dlg-rubro").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-rubro").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-rubro").find("tr").hover(function () {
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
                            var title = "Crear Rubro";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-rubro").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-rubro").find("tr").contextMenu({
                            menu : "menu-rubro"
                        },
                        function (action, el, pos) {
                            $("#dlg-rubro").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Rubro";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-rubro").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Rubro";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-rubro").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Rubro";
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
                                            $("#dlg-rubro").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Rubro?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-rubro").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
