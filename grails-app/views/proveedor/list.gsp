<%@ page import="cratos.Proveedor" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Proveedores</title>

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
        Lista de Proveedores
        <div class="fright">
            <g:link action="create" class="btnNew miniButton">Nuevo</g:link>
        </div>
    </div>

    <div id="list-proveedor" class="content scaffold-list" role="main">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <table id="tbl-proveedor">
            <thead>
            <tr>

                <th><g:message code="proveedor.ruc.label" default="Ruc"/></th>

                <th><g:message code="proveedor.nombre.label" default="Nombre Proveedor"/></th>

                <th><g:message code="proveedor.tipoProveedor.label" default="Tipo Proveedor"/></th>

                <th><g:message code="proveedor.nombreContacto.label" default="Nombre y Apellido de Contacto"/></th>

                <th><g:message code="proveedor.tipoPersona.label" default="Tipo Persona"/></th>

                <th><g:message code="proveedor.tipoIdentificacion.label" default="Tipo Identificacion"/></th>


                <g:sortableColumn property="pais" title="${message(code: 'proveedor.pais.label', default: 'Pais')}"/>

            </tr>
            </thead>
            <tbody id="tb-proveedor">
            <g:each in="${proveedorInstanceList}" status="i" var="proveedorInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" id="${proveedorInstance.id}">

                    <td>${fieldValue(bean: proveedorInstance, field: "ruc")}</td>

                    <td>${fieldValue(bean: proveedorInstance, field: "nombre")}</td>

                    <td>${fieldValue(bean: proveedorInstance, field: "tipoProveedor.descripcion")}</td>

                    <td>${fieldValue(bean: proveedorInstance, field: "nombreContacto")}
                        ${fieldValue(bean: proveedorInstance, field: "apellidoContacto")}</td>


                    <td>${fieldValue(bean: proveedorInstance, field: "tipoPersona.descripcion")}</td>

                    <td>${fieldValue(bean: proveedorInstance, field: "tipoIdentificacion.descripcion")}</td>



                    <g:if test="${proveedorInstance?.pais}">

                        <td>${country(code: fieldValue(bean: proveedorInstance, field: "pais"))}</td>

                    </g:if>

                    <g:else>

                        <td>N/A</td>
                    </g:else>

                </tr>
            </g:each>
            </tbody>
        </table>
        <g:if test="${proveedorInstanceList.size() < proveedorInstanceTotal}">
            <div class="pagination">
                <g:paginate total="${proveedorInstanceTotal}" prev="Ant." next="Sig."/>
            </div>
        </g:if>
    </div>
</div>

<ul id="menu-proveedor" class="contextMenu">
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

<div id="dlg-proveedor" style="width: 860px; height: 410px"></div>

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
                    $("#dlg-proveedor").html(msg);
                },
                complete:function () {
                    $("#dlgLoad").dialog("close");
                }
            });
            $("#dlg-proveedor").dialog("option", "width", 860);
        } else {
            $("#dlg-proveedor").html(cont);
        }
        $("#dlg-proveedor").dialog("option", "title", title);
        $("#dlg-proveedor").dialog("option", "buttons", buttons);
        $("#dlg-proveedor").dialog("open");
    }

    function submitForm() {
        if ($("#frm-proveedor").valid()) {
            $("#dlgLoad").dialog("open");
            var data = $("#frm-proveedor").serialize();
            var url = $("#frm-proveedor").attr("action");

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

        $("#dlg-proveedor").dialog({
            modal:true,
            autoOpen:false,
            width:860,
//                    height   : 450,
            zIndex:1000,
            position:"center"
        });

        $("th").hover(function () {
            $(this).addClass("hover");
            var i = $(this).index();
            $("#tb-proveedor").find("tr").each(function () {
                $(this).children().eq(i).addClass("hover");
            });
        }, function () {
            $(".hover").removeClass("hover");
        });

        $("#tb-proveedor").find("tr").hover(function () {
            $(this).addClass("hover");
        }, function () {
            $(".hover").removeClass("hover");
        });

        $(".btnNew").button({
            icons:{
                primary:"ui-icon-document"
            }
        }).click(function () {
                    var id = $(this).attr("id");
                    var url = $(this).attr("href");
                    var title = "Crear Proveedor";
                    var buttons = {
                        "Guardar":function () {
                            submitForm();
                        },
                        "Cancelar":function () {
                            $("#dlg-proveedor").dialog("close");
                        }
                    };
                    openDlg(url, id, "", true, title, buttons);
                    return false;
                });

        $("#tb-proveedor").find("tr").contextMenu({
                    menu:"menu-proveedor"
                },
                function (action, el, pos) {
                    $("#dlg-proveedor").html("");
                    var id = $(el).attr("id");
                    var title, buttons, url, cont;
                    switch (action) {
                        case "edit":
                            title = "Editar Proveedor";
                            buttons = {
                                "Guardar":function () {
                                    submitForm();
                                },
                                "Cancelar":function () {
                                    $("#dlg-proveedor").dialog("close");
                                }
                            };
                            url = "${createLink(action:'edit')}/" + id;
                            break;
                        case "show":
                            title = "Ver Proveedor";
                            buttons = {
                                "Aceptar":function () {
                                    $("#dlg-proveedor").dialog("close");
                                }
                            };
                            url = "${createLink(action:'show')}/" + id;
                            break;
                        case "delete":
                            title = "Eliminar Proveedor";
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
                                    $("#dlg-proveedor").dialog("close");
                                }
                            };
                            cont = "<span style='font-size: 16px;'> Est&aacute; seguro de querer eliminar este Proveedor?";
                            cont += "<br/>Esta acci&oacute;n es definitiva.</span>"
                            $("#dlg-proveedor").dialog("option", "width", 360);
                            break;
                    }
                    openDlg(url, id, cont, action != "delete", title, buttons);
                });
    });
</script>
</body>
</html>
