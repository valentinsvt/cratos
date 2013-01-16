<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/17/12
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Conciliación bancaria</title>


        <style type="text/css">
        th {
            text-align : center;
        }
        </style>
    </head>

    <body>
        <div class="container entero ui-widget-content ui-corner-all">
            <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">
                Conciliaci&oacute;n Bancaria
            </h1>

            <g:form action="validarPagoAux" name="frmValidarPagoAux">
                <table border="1">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Factura</th>
                            <th>Tipo Documento</th>
                            <th>Referencia</th>
                            <th>Valor</th>
                            <th>Validar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${pagos}" var="pago" status="i">
                            <tr class="${i % 2 == 0 ? 'even' : 'odd'}">
                                <td>
                                    <g:formatDate date="${pago.fecha}" format="dd-MM-yyyy"/>
                                </td>
                                <td>
                                    ${pago.factura}
                                </td>
                                <td>
                                    ${pago.tipoDocumento.descripcion}
                                </td>
                                <td>
                                    ${pago.referencia}
                                </td>
                                <td style="text-align:right;">
                                    <g:formatNumber number="${pago.monto}" minFractionDigits="2" maxFractionDigits="2"/>
                                </td>
                                <td style="text-align:center;">
                                    <g:checkBox name="${pago.id}"/>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>

                <div class="ui-widget-header buttons botones">
                    <a href="#" class="btnGuardar">Guardar</a>
                </div>
            </g:form>
        </div>

        <script type="text/javascript">
            $(function () {
                $(".btnGuardar").button({
                    icons : {
                        primary : "ui-icon-check"
                    }
                }).click(function () {
                            $("#frmValidarPagoAux").submit();
                        });
            });
        </script>

    </body>
</html>