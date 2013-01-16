<%@ page import="cratos.Transferencia" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'transferencia.label', default: 'Transferencia')}"/>
        <title>Detalle Transferencia</title>



        <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>

        <script type="text/javascript"
                src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>
        <link type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}"
              rel="stylesheet"/>

        <style type="text/css">

        .label {
            font-weight : bold;
        }

        .hover {
            background : #ffd125 !important;
            cursor     : pointer;
        }

        .selected {
            border     : #FF8010 solid 2px !important;
            background : #F7E7D9 !important;
        }




        </style>

    </head>

    <body>
        <a href="#show-transferencia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="show-transferencia" class="content scaffold-show" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    <li><g:link class="list linkButton" action="list">Lista</g:link></li>
                    <li><g:link class="create linkButton" action="create">Crear Transferencia</g:link></li>
                    <g:if test="${transferenciaInstance.estado == 'R'}">
                    %{--<li><g:link class="list linkButton" controller="reportes" action="retencion"--}%
                    %{--id="${adquisicionesInstance.id}" params="${[id: adquisicionesInstance.id, empr: adquisicionesInstance.empresa.id]}" target="_blank">Retención</g:link>--}%
                    %{--</li>--}%
                    </g:if>
                    <g:else>
                        <li>
                            <g:link action="create" class="linkButton" id="${transferenciaInstance.id}">Editar</g:link>
                        </li>
                        <li>
                            <a href="#" class="linkButton" id="registrar" adq="${transferenciaInstance.id}">Registrar</a>
                        </li>
                    </g:else>

                </ul>
            </div>

            <div class="contenedor" style="height: 450px; width: 900px">
                <h1>Detalle Transferencia</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <div class="container span-15">

                    <fieldset style="margin: 30px">

                        <legend>Transferencias</legend>


                        <div class="fila span-20">
                            <div class="span-3 label">
                                Gestor
                            </div>

                            <div class="span-6">

                                ${cratos.Proceso.findByTransferencia(transferenciaInstance)?.gestor?.descripcion}

                            </div>
                        </div>

                        <div class="fila span-20">

                            <g:if test="${transferenciaInstance?.id}">
                            %{--<div class="span-19">--}%
                                <div class="span-3 label">
                                    Transferencia
                                </div>

                                <div class="span-6">

                                    ${transferenciaInstance?.id}

                                </div>

                            %{--</div>--}%
                            </g:if>

                            <g:if test="${transferenciaInstance?.fecha}">
                            %{--<div class="span-19">--}%
                                <div class="span-3 prepend-1 label">
                                    Fecha
                                </div>

                                <div class="span-6">

                                    <g:formatDate date="${transferenciaInstance?.fecha}" format="yyyy-MM-dd"/>

                                </div>
                            %{--</div>--}%
                            </g:if>

                        </div>

                        <div class="fila span-20">
                            <g:if test="${transferenciaInstance?.bodegaSale}">

                                <div class="span-3 label">
                                    Centro costos Sale
                                </div>

                                <div class="span-6">
                                    ${transferenciaInstance.bodegaSale.centroCosto.nombre}
                                </div>

                            </g:if>

                            <g:if test="${transferenciaInstance?.bodegaRecibe}">

                                <div class="span-3 prepend-1  label">
                                    Centro costos recibe
                                </div>

                                <div class="span-6">
                                    ${transferenciaInstance?.bodegaRecibe.centroCosto.nombre}
                                </div>

                            </g:if>
                        </div>


                        <div class="fila span-20">

                            <g:if test="${transferenciaInstance?.bodegaSale}">

                                <div class="span-3 label">
                                    Bodega Sale
                                </div>

                                <div class="span-6">

                                    %{--<g:link controller="bodega" action="show" optionValue="descripcion" optionKey="id" id="${transferenciaInstance?.bodegaSale?.id}">${transferenciaInstance?.bodegaSale?.descripcion.encodeAsHTML()}</g:link>--}%

                                    <g:fieldValue bean="${transferenciaInstance}" field="bodegaSale.descripcion"/>
                                </div>

                            </g:if>
                            <g:if test="${transferenciaInstance?.bodegaRecibe}">

                                <div class="span-3 prepend-1  label">
                                    Bodega Recibe
                                </div>

                                <div class="span-6">

                                    %{--<g:link controller="bodega" action="show" optionValue="descripcion" optionKey="id" id="${transferenciaInstance?.bodegaRecibe?.id}">${transferenciaInstance?.bodegaRecibe?.descripcion.encodeAsHTML()}</g:link>--}%

                                    <g:fieldValue bean="${transferenciaInstance}" field="bodegaRecibe.descripcion"/>

                                </div>

                            </g:if>

                        </div>


                        <div class="fila span-20">
                            <g:if test="${transferenciaInstance?.empresa}">

                                <div class="span-3 label">
                                    Empresa
                                </div>

                                <div class="span-6">

                                    %{--<g:link controller="empresa" action="show" id="${transferenciaInstance?.empresa?.id}">${transferenciaInstance?.empresa?.encodeAsHTML()}</g:link>--}%

                                    <g:fieldValue bean="${transferenciaInstance}" field="empresa"/>

                                </div>

                            </g:if>

                        </div>

                        <g:if test="${transferenciaInstance?.observaciones}">

                            <div class="span-3 prepend-1 label">
                                Observaciones
                            </div>

                            <div class="">

                                <g:fieldValue bean="${transferenciaInstance}" field="observaciones"/>

                            </div>

                        </g:if>

                </div>

            </fieldset>

                <fieldset style="margin: 30px">

                    <legend>Items</legend>

                    <table id="tblItems" border="1" style="border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th width="50" class="cantidad">
                                    Cantidad
                                </th>
                                <th width="100">
                                    Código
                                </th>
                                <th width="300">
                                    Item
                                </th>
                                <th width="100" class="precioUnitario">
                                    Precio Unitario
                                </th>

                                <th width="200">
                                    Observaciones
                                </th>
                                %{--<th>--}%
                                %{--Bodega--}%

                                %{--</th>--}%
                            </tr>
                        </thead>
                        <tbody id="tbItems">
                            <g:each in="${cratos.DetalleTransferencia.findAllByTransferencia(transferenciaInstance)}" var="item">
                                <tr>
                                    <td>${item.cantidad}</td>
                                    <td>${item.item.codigo}</td>
                                    <td>${item.item.nombre}</td>
                                    <td>${item.precioUnitario}</td>


                                    <td>${item.item.observaciones}</td>
                                    <td>

                                    </td>

                                </tr>
                            </g:each>
                        </tbody>
                    </table>

                </fieldset>

            </div>

            <div class="ui-widget-header buttons" style="padding: 5px; text-align:right;">
                %{--<g:link class="delete linkButton">Eliminar</g:link>--}%
                %{--<g:link class="edit linkButton" action="edit" id="${transferenciaInstance?.id}">Editar</g:link>--}%
            </div>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".delete").click(function () {
                    $.box({
                        imageClass : "box_warning",
                        text       : "Está seguro de querer eliminar este registro?",
                        title      : "Confirmación",
                        iconClose  : false,
                        dialog     : {
                            resizable     : false,
                            draggable     : false,
                            closeOnEscape : false,
                            buttons       : {
                                "Aceptar"  : function () {
                                    location.href = "${createLink(action: 'delete', id: transferenciaInstance?.id)}";
                                },
                                "Cancelar" : function () {
                                    return false;
                                }
                            }
                        }
                    });
                    return false;
                });

                $("#registrar").click(function () {
                    if (confirm("Está seguro que desea registrar esta transferencia?. Una vez registrada no podrá modificarla")) {
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action: 'registrar')}",
                            data    : {
                                id : ${transferenciaInstance.id}
                            },
                            success : function (msg) {
                                if (msg == "OK") {
                                    window.location.reload(true)
                                } else {
                                    alert(msg);
                                }
                            }
                        });
                    }

                });

            });
        </script>

    </body>
</html>
