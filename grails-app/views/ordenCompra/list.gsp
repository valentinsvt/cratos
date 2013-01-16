<%@ page import="cratos.OrdenCompra" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Ordenes de Compra</title>

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}"
          type="text/css">

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

</head>

<body>
<div class="ui-widget-content ui-corner-all cont">
    <div class="ui-widget-header ui-corner-all titulo">
        Lista de Ordenes de Compra
        <div class="fright">
            <g:link action="create" class="btnNew miniButton">Nueva</g:link>
        </div>
    </div>

    <div id="list-ordenCompra" class="content scaffold-list" role="main">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table id="tbl-ordenCompra">
            <thead>
            <tr>

                <th><g:message code="ordenCompra.centroCosto.label" default="Centro Costo"/></th>

                <g:sortableColumn property="numero"
                                  title="${message(code: 'ordenCompra.numero.label', default: 'Número')}"/>

                <g:sortableColumn property="descripcion"
                                  title="${message(code: 'ordenCompra.descripcion.label', default: 'Descripcion')}"/>

                <g:sortableColumn property="valor"
                                  title="${message(code: 'ordenCompra.valor.label', default: 'Valor')}"/>

                <g:sortableColumn property="fecha"
                                  title="${message(code: 'ordenCompra.fecha.label', default: 'Fecha')}"/>

                <g:sortableColumn property="estado"
                                  title="${message(code: 'ordenCompra.estado.label', default: 'Estado')}"/>

                <g:sortableColumn property="observaciones"
                                  title="${message(code: 'ordenCompra.observaciones.label', default: 'Observaciones')}"/>

            </tr>
            </thead>
            <tbody id="tb-ordenCompra">
            <g:each in="${ordenCompraInstanceList}" status="i" var="ordenCompraInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${ordenCompraInstance.id}"
                    data-estado="${ordenCompraInstance.estado}">

                    <td>${ordenCompraInstance.centroCosto.nombre}</td>

                    <td>${ordenCompraInstance.numero}</td>

                    <td>${fieldValue(bean: ordenCompraInstance, field: "descripcion")}</td>

                    <td style="text-align:right;">
                        <g:formatNumber number="${ordenCompraInstance.valor}" maxFractionDigits="2" minFractionDigits="2"/>
                    </td>

                    <td><g:formatDate date="${ordenCompraInstance.fecha}" format="dd-MM-yyyy"/></td>

                    <g:if test="${ordenCompraInstance.estado == 'R'}">
                        <td>Registrado</td>
                    </g:if>
                    <g:else>
                    <g:if test="${ordenCompraInstance.estado == 'C'}">
                        <td>Comprado</td>

                    </g:if>
                    <g:else>
                        <td>No Registrado</td>
                    </g:else>
                    </g:else>
                    <td>${fieldValue(bean: ordenCompraInstance, field: "observaciones")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>
        <g:if test="${ordenCompraInstanceList.size() < ordenCompraInstanceTotal}">
            <div class="pagination">
                <g:paginate total="${ordenCompraInstanceTotal}" prev="Ant." next="Sig."/>
            </div>
        </g:if>
    </div>
</div>

<ul id="menu-ordenCompra" class="contextMenu">
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

<div id="dlg-ordenCompra"></div>

<div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
    Cargando.....Por favor espere......<br/><br/>
    <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
</div>

<script type="text/javascript">
    function openDlg(url, id, cont, ajax, title, buttons) {
        if (ajax) {
            $("#dlgLoad").dialog("open");
            $.ajax({
                async:false,
                type:"POST",
                url:url,
                data:{
                    id:id
                },
                success:function (msg) {
                    $("#dlg-ordenCompra").html(msg);
                },
                complete:function () {
                    $("#dlgLoad").dialog("close");
                }
            });
            $("#dlg-ordenCompra").dialog("option", "width", 420);
        } else {
            $("#dlg-ordenCompra").html(cont);
        }
        $("#dlg-ordenCompra").dialog("option", "title", title);
        $("#dlg-ordenCompra").dialog("option", "buttons", buttons);
        $("#dlg-ordenCompra").dialog("open");
    }

    function submitForm() {
        if ($("#frm-ordenCompra").valid()) {
            $("#dlgLoad").dialog("open");
            var data = $("#frm-ordenCompra").serialize();
            var url = $("#frm-ordenCompra").attr("action");

            $.ajax({
                type:"POST",
                url:url,
                data:data,
                success:function (msg) {
                    location.reload(true);
                }
            });
        }
    }

    $(function () {
        $("#dlgLoad").dialog({
            modal:true,
            autoOpen:false,
            closeOnEscape:false,
            draggable:false,
            resizable:false,
            zIndex:9000,
            open:function (event, ui) {
                $(event.target).parent().find(".ui-dialog-titlebar-close").remove();
            }
        });

        $("#dlg-ordenCompra").dialog({
            modal:true,
            autoOpen:false,
            width:420,
            zIndex:1000,
            position:["center", 10]
        });

        $("th").hover(function () {
            $(this).addClass("hover");
            var i = $(this).index();
            $("#tb-ordenCompra").find("tr").each(function () {
                $(this).children().eq(i).addClass("hover");
            });
        }, function () {
            $(".hover").removeClass("hover");
        });

        $("#tb-ordenCompra").find("tr").hover(function () {
            $(this).addClass("hover");
        }, function () {
            $(".hover").removeClass("hover");
        });

        $(".btnNew").button({
            icons:{
                primary:"ui-icon-document"
            }
        });
        /*.click(function () {
         var id = $(this).attr("id");
         var url = $(this).attr("href");
         var title = "Crear OrdenCompra";
         var buttons = {
         "Guardar"  : function () {
         submitForm();
         },
         "Cancelar" : function () {
         $("#dlg-ordenCompra").dialog("close");
         }
         };
         openDlg(url, id, "", true, title, buttons);
         return false;
         });*/

        $("#tb-ordenCompra").find("tr").contextMenu({
                    menu:"menu-ordenCompra"
                },
                function (action, el, pos) {
                    $("#dlg-ordenCompra").html("");


                    var id = $(el).attr("id");
                    var estado = $(el).data("estado");
                    var title, buttons, url, cont;
                    switch (action) {
                        case "edit":

                            if (estado == 'R') {

                                url = "${createLink(action: 'show')}/" + id;
                                location.href = url;

                            }
                            else {
                                console.log("create");
                                url = "${createLink(action:'create')}/" + id;
                                location.href = url;
                            }
                            break;


                        case "show":
//                                    title = "Ver OrdenCompra";
//                                    buttons = {
//                                        "Aceptar" : function () {
//                                            $("#dlg-ordenCompra").dialog("close");
//                                        }
//                                    };
                            url = "${createLink(action:'show')}/" + id;
                            location.href = url;
                            break;
                        case "delete":
                            title = "Eliminar OrdenCompra";
                            buttons = {
                                "Aceptar":function () {
                                    $("#dlgLoad").dialog("open");
                                    $.ajax({
                                        type:"POST",
                                        url:"${createLink(action:'delete')}",
                                        data:{
                                            id:id
                                        },
                                        success:function (msg) {
                                            location.reload(true);
                                        }
                                    });
                                },
                                "Cancelar":function () {
                                    $("#dlg-ordenCompra").dialog("close");
                                }
                            };
                            cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este OrdenCompra?";
                            cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                            $("#dlg-ordenCompra").dialog("option", "width", 360);
                            break;
                    }
                    var open = action != "show" && action != "edit";
                    if (open) {
                        openDlg(url, id, cont, action != "delete", title, buttons);
                    }
                });
    });
</script>
</body>
</html>
