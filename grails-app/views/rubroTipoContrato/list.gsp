
<%@ page import="cratos.RubroTipoContrato" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Lista de RubroTipoContratos</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
        <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}" type="text/css">

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

    </head>
    <body>
        <div class="ui-widget-content ui-corner-all cont">
            <div class="ui-widget-header ui-corner-all titulo">
                Lista de RubroTipoContratos
                <div class="fright">
                    <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
                </div>
            </div>

            <div id="list-rubroTipoContrato" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table id="tbl-rubroTipoContrato">
                    <thead>
                        <tr>
                            
                            <th><g:message code="rubroTipoContrato.tipoContrato.label" default="Tipo Contrato" /></th>
                            
                            <th><g:message code="rubroTipoContrato.rubro.label" default="Rubro" /></th>
                            
                            <g:sortableColumn property="porcentaje" title="${message(code: 'rubroTipoContrato.porcentaje.label', default: 'Porcentaje')}" />
                            
                            <g:sortableColumn property="editable" title="${message(code: 'rubroTipoContrato.editable.label', default: 'Editable')}" />
                            
                            <g:sortableColumn property="decimo" title="${message(code: 'rubroTipoContrato.decimo.label', default: 'Decimo')}" />
                            
                            <g:sortableColumn property="iess" title="${message(code: 'rubroTipoContrato.iess.label', default: 'Iess')}" />
                            
                        </tr>
                    </thead>
                    <tbody id="tb-rubroTipoContrato">
                        <g:each in="${rubroTipoContratoInstanceList}" status="i" var="rubroTipoContratoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${rubroTipoContratoInstance.id}">
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "tipoContrato")}</td>
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "rubro")}</td>
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "porcentaje")}</td>
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "editable")}</td>
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "decimo")}</td>
                                
                                <td>${fieldValue(bean: rubroTipoContratoInstance, field: "iess")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
                <g:if test="${rubroTipoContratoInstanceList.size() < rubroTipoContratoInstanceTotal}">
                    <div class="pagination">
                        <g:paginate total="${rubroTipoContratoInstanceTotal}"  prev="Ant." next="Sig." />
                    </div>
                </g:if>
            </div>
        </div>

        <ul id="menu-rubroTipoContrato" class="contextMenu">
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

        <div id="dlg-rubroTipoContrato"></div>

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
                            $("#dlg-rubroTipoContrato").html(msg);
                        },
                        complete : function () {
                            $("#dlgLoad").dialog("close");
                        }
                    });
                    $("#dlg-rubroTipoContrato").dialog("option", "width", 420);
                } else {
                $("#dlg-rubroTipoContrato").html(cont);
                }
                $("#dlg-rubroTipoContrato").dialog("option", "title", title);
                $("#dlg-rubroTipoContrato").dialog("option", "buttons", buttons);
                $("#dlg-rubroTipoContrato").dialog("open");
            }

            function submitForm() {
                if ($("#frm-rubroTipoContrato").valid()) {
                    $("#dlgLoad").dialog("open");
                    var data = $("#frm-rubroTipoContrato").serialize();
                    var url = $("#frm-rubroTipoContrato").attr("action");

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

                $("#dlg-rubroTipoContrato").dialog({
                    modal    : true,
                    autoOpen : false,
                    width    : 420,
                    zIndex   : 1000,
                    position : ["center", 10]
                });

                $("th").hover(function () {
                    $(this).addClass("hover");
                    var i = $(this).index();
                    $("#tb-rubroTipoContrato").find("tr").each(function () {
                        $(this).children().eq(i).addClass("hover");
                    });
                }, function () {
                    $(".hover").removeClass("hover");
                });

                $("#tb-rubroTipoContrato").find("tr").hover(function () {
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
                            var title = "Crear RubroTipoContrato";
                            var buttons = {
                                "Guardar"  : function () {
                                    submitForm();
                                },
                                "Cancelar" : function () {
                                    $("#dlg-rubroTipoContrato").dialog("close");
                                }
                            };
                            openDlg(url, id, "", true, title, buttons);
                            return false;
                        });

                $("#tb-rubroTipoContrato").find("tr").contextMenu({
                            menu : "menu-rubroTipoContrato"
                        },
                        function (action, el, pos) {
                            $("#dlg-rubroTipoContrato").html("");
                            var id = $(el).attr("id");
                            var title, buttons, url, cont;
                            switch (action) {
                                case "edit":
                                    title = "Editar RubroTipoContrato";
                                    buttons = {
                                        "Guardar"  : function () {
                                            submitForm();
                                        },
                                        "Cancelar" : function () {
                                            $("#dlg-rubroTipoContrato").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'edit')}/" + id;
                                    break;
                                case "show":
                                    title = "Ver RubroTipoContrato";
                                    buttons = {
                                        "Aceptar" : function () {
                                            $("#dlg-rubroTipoContrato").dialog("close");
                                        }
                                    };
                                    url = "${createLink(action:'show')}/" + id;
                                    break;
                                case "delete":
                                    title = "Eliminar RubroTipoContrato";
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
                                            $("#dlg-rubroTipoContrato").dialog("close");
                                        }
                                    };
                                    cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este RubroTipoContrato?";
                                    cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                                    $("#dlg-rubroTipoContrato").dialog("option", "width", 360);
                                    break;
                            }
                            openDlg(url, id, cont, action != "delete", title, buttons);
                        });
            });
        </script>
    </body>
</html>
