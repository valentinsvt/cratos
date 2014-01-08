<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/8/14
  Time: 1:32 PM
--%>

<%@ page import="cratos.DetalleRetencion" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Retención</title>
        <style type="text/css">
        @page {
            /*size   : 29.7cm 21cm;  *//*width height */
            size   : 21cm 29.7cm;/*  width height*/
            margin : 1.5cm;
        }

        html {
            font-family : Verdana, Arial, sans-serif;
            font-size   : 11px;
        }

        .hoja {
            width      : 17cm;
            /*background : #d8f0fa;*/
        }

        .left {
            float      : left;
            min-height : 30px;
        }

        .right {
            float      : right;
            min-height : 30px;
        }

        table {
            font-size       : 11px;
            border-collapse : collapse;
        }

        .info {
            padding : 2px 0;
        }

        .tr {
            text-align : right;
        }

        .tc {
            text-align : center;
        }

        .tl {
            text-align : left;
        }
        </style>
    </head>

    <body>
        <div class="hoja">
            <div style="height: 150px;">
                <div class="left">
                    <h1>
                        ${empresa.nombre}
                    </h1>

                    <div class="info">Dirección: ${empresa.direccion}</div>

                    <div class="info">Teléfonos: ${empresa.telefono}</div>

                    <div class="info">${empresa.canton.nombre} - Ecuador</div>

                    <div class="info">R.U.C.: ${empresa.ruc}</div>
                </div>

                <div class="right" style="margin-top: 20px;">
                    <div class="info"><strong>Autorización del S.R.I.:</strong> ${retencion.numeroAutorizacionComprobante}</div>

                    <div class="info"><strong>COMPROBANTE DE RETENCIÓN</strong> ${retencion.numeroEstablecimiento}-${retencion.numeroPuntoEmision}</div>

                    <h3>N. ${retencion.numeroSecuencial}</h3>
                </div>
            </div>

            <div style="height: 90px;">
                <div class="left">
                    <div class="info"><strong>Sres.:</strong> ${proceso.proveedor.nombre}</div>

                    <div class="info"><strong>R.U.C.:</strong> ${proceso.proveedor.ruc}</div>

                    <div class="info"><strong>Dirección:</strong> ${proceso.proveedor.direccion}</div>

                    <div class="info"><strong>Teléfono:</strong> ${proceso.proveedor.telefono}</div>
                </div>

                <div class="right">
                    <div class="info"><strong>Lugar y fecha de emisión:</strong> Quito, ${retencion.fecha.format("dd")} de ${meses[retencion.fecha.format("MM").toInteger()]} del ${retencion.fecha.format("yyyy")}</div>

                    <div class="info"><strong>Tipo de comprobante de venta:</strong> ${proceso.tipoComprobanteSri.descripcion}</div>

                    <div class="info"><strong>No. de comprobante de venta:</strong> ${proceso.facturaEstablecimiento}-${proceso.facturaPuntoEmision}-${proceso.facturaSecuencial}</div>

                    <div class="info"><strong>Ejercicio fiscal:</strong> ${retencion.contabilidad.fechaInicio.format("yyyy")}</div>
                </div>
            </div>

            <div style="margin-top: 10px;">
                <table border="1" style="width:100%;" cellpadding="4">
                    <thead>
                        <tr>
                            <th class="tl">Retención</th>
                            <th class="tr" style="padding-right: 20px;">Base</th>
                            <th class="tl">Tipo</th>
                            <th class="tc">Cod Ret</th>
                            <th class="tr">% Ret</th>
                            <th class="tr">Valor Retenido</th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:set value="${0}" var="total"/>
                        <g:each in="${DetalleRetencion.findAllByRetencion(retencion)}" var="det">
                            <g:set value="${total + det.total}" var="total"/>
                            <tr>
                                <td class="tl">
                                    <g:if test="${det.conceptoRetencionImpuestoRenta}">
                                        (${det.conceptoRetencionImpuestoRenta?.codigo}) ${det.conceptoRetencionImpuestoRenta?.descripcion}
                                    </g:if>
                                </td>
                                <td class="tr" style="padding-right: 20px;">
                                    <g:formatNumber number="${det.base}" maxFractionDigits="2" minFractionDigits="2"/>
                                </td>
                                <td class="tl">
                                    ${det.impuesto.nombre}
                                </td>
                                <td class="tc">
                                    <g:if test="${det.conceptoRetencionImpuestoRenta}">
                                        ${det.conceptoRetencionImpuestoRenta?.codigo}
                                    </g:if>
                                </td>
                                <td class="tr">
                                    <g:formatNumber number="${det.porcentaje}" maxFractionDigits="2" minFractionDigits="2"/>%
                                </td>
                                <td class="tr">
                                    <g:formatNumber number="${det.total}" maxFractionDigits="2" minFractionDigits="2"/>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3"></th>
                            <th class="tr" colspan="2">TOTAL RETENIDO</th>
                            <th class="tr"><g:formatNumber number="${total}" maxFractionDigits="2" minFractionDigits="2"/></th>
                        </tr>
                    </tfoot>
                </table>
            </div>

        </div>

    </body>
</html>