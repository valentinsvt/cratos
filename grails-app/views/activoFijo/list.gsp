
<%@ page import="cratos.ActivoFijo" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de Activos Fijos</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de Activos Fijos
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-activoFijo" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-activoFijo">
                    <thead>
                        <tr>
                            

                            <g:sortableColumn property="item" title="${message(code: 'activoFijo.item.label', default: 'Item')}"/>


                            
                            <g:sortableColumn property="modelo" title="${message(code: 'activoFijo.modelo.label', default: 'Modelo')}" />
                            
                            <g:sortableColumn property="serie" title="${message(code: 'activoFijo.serie.label', default: 'Serie')}" />
                            
                            <g:sortableColumn property="periodoDepreciacion" title="${message(code: 'activoFijo.periodoDepreciacion.label', default: 'Periodo Depreciacion')}" />

                            <g:sortableColumn property="fechaInicio" title="${message(code: 'activoFijo.fechaInicio.label', default: 'Fecha Inicio')}" />
                            
                            <g:sortableColumn property="fechaAdquisicion" title="${message(code: 'activoFijo.fechaAdquisicion.label', default: 'Fecha Adquisicion')}" />
                            

                            
                        </tr>
                    </thead>
                    <tbody id="tb-activoFijo">
                        <g:each in="${activoFijoInstanceList}" status="i" var="activoFijoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${activoFijoInstance.id}">
                                

                                <td>${fieldValue(bean: activoFijoInstance, field: "item.nombre")}</td>


                                <td>${fieldValue(bean: activoFijoInstance, field: "modelo")}</td>
                                
                                <td>${fieldValue(bean: activoFijoInstance, field: "serie")}</td>
                                
                                <td>${fieldValue(bean: activoFijoInstance, field: "periodoDepreciacion")}</td>

                                <td><g:formatDate date="${activoFijoInstance.fechaInicio}" format="yyyy-MM-dd"/></td>
                                
                                <td><g:formatDate date="${activoFijoInstance.fechaAdquisicion}" format="yyyy-MM-dd"/></td>
                                
                                %{--<td>${fieldValue(bean: activoFijoInstance, field: "color")}</td>--}%
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${activoFijoInstanceList.size() < activoFijoInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${activoFijoInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-activoFijo" class="contextMenu">
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

        <div id="dlg-activoFijo"></div>

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
                            $("#dlg-activoFijo").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-activoFijo").dialog("option", "width", 750);
                } else {
                $("#dlg-activoFijo").html(cont);
                }
                $("#dlg-activoFijo").dialog("option", "title", title);
                $("#dlg-activoFijo").dialog("option", "buttons", buttons);
                $("#dlg-activoFijo").dialog("open");
            }

            function submitForm() {
                if ($("#frm-activoFijo").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-activoFijo").serialize();
                    var url = $("#frm-activoFijo").attr("action");

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

                $("#dlg-activoFijo").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-activoFijo").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-activoFijo").find("tr").hover(function () {
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
                            var title = "Crear Activo Fijo";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-activoFijo").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-activoFijo").find("tr").contextMenu({
                            menu : "menu-activoFijo"
                        },
                        function (action, el, pos) {
                            $("#dlg-activoFijo").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar Activo Fijo";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-activoFijo").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver Activo Fijo";

                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-activoFijo").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar Activo Fijo";
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
                                            $("#dlg-activoFijo").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este ActivoFijo?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-activoFijo").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
