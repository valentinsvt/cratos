<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Comprobante de retención</title>
        %{--<link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css"/>--}%
        <style type="text/css">
        @page {
            size   : 21cm 29.7cm ; /* width height */
            margin : 2cm;
        }

        .hoja {
            width : 25.7cm;
            /*background: #d8f0fa;*/
        }

        .even {
            background : #B7C4F7;
        }

        .odd {
            background : #FCFDFF
        }

        table {
            border-collapse : collapse;
        }

        .item {
            /*background: #e6e6fa;*/
            border-bottom : solid 2px #555;

        }

            /*.odd{*/
            /*background: #ffecd2;*/
            /*}*/
            /*.even{*/
            /*background: #e7e6ea;*/
            /*}*/
        </style>

    </head>

    <body>
        <div class="hoja">

            <div style="width: 600px;height: 400px; border: 1px black double;margin: 10px;">
                <div style="width: 594px;margin: 2px;height: 100px;">
                    <div style="width: 320px;height: 95px;margin-left: 5px;margin-top: 5px;text-align: center;float: left">
                        <span style="display: block;border-bottom: 1px solid black;font-size: 14px;font-weight: bold;">${empresa.nombre}.</span>
                        <span style="display: block;font-size: 11px;">
                            VENTA AL POR MAOYR DE MAQUINARIA DE EQUIPO DE OFICINA
                        </span>
                        <span style="display: block;font-size: 11px;">
                            Dirrección: ${empresa.direccion} <br>
                            tef: ${empresa.telefono}<br>
                            Quito - Ecuador
                        </span>
                    </div>

                    <div style="width: 260px;height: 70px;margin-left: 5px;margin-top: 5px;text-align: center;float: left">
                        <span style="display: block;font-size: 14px;">RUC: ${empresa.ruc}</span>
                        <span style="display: block;font-size: 11px;">
                            COMPROBANTE DE RENTENCIÓN
                        </span>
                        <span style="display: block;font-size: 11px;">
                            No. ${p.retencionSerie1}-${p.retencionSerie2}-${p.retencionSecuencial}<br>
                            AUT. SRI. ${p.retencionAutorizacion}
                        </span>
                    </div>
                </div>

                <div style="width: 594px;margin: 2px;height: 90px;">

                    <table width="590px" style="height: 88px;margin-left: 5px;">
                        <tr style="font-size: 11px">
                            <td style="width: 40px">Nombre:</td>
                            <td style="width: 220px">${ret.persona}</td>
                            <td style="width: 140px;">Fecha de emisión:</td>
                            <td style="width: 160px">${ret.fecha.format("dd/MM/yyyy")}</td>
                        </tr>
                        <tr style="font-size: 11px">
                            <td style="width: 40px">RUC:</td>
                            <td style="width: 220px">${ret.ruc}</td>
                            <td style="width: 140px;">Tipo de comprobante Vta:</td>
                            <td style="width: 160px"></td>
                        </tr>
                        <tr style="font-size: 11px">
                            <td style="width: 40px">Dirección:</td>
                            <td style="width: 220px">${ret.direccion}</td>
                            <td style="width: 140px;">No de comprobante Vta:</td>
                            <td style="width: 160px">${p.adquisicion.facturaSerie1 + " " + p.adquisicion.facturaSerie2 + " " + p.adquisicion.facturaNumero}</td>
                        </tr>
                    </table>

                </div>

                <div style="width: 594px;margin: 2px;height: 132px;">
                    <g:set var="total" value="${0}"></g:set>
                    <table style="width: 585px;height: 130px;margin-left: 5px;font-size: 11px;" border="1">
                        <thead>
                            <th>Ejercicio<br>Fiscal</th>
                            <th>Base impobible <br>para la retención</th>
                            <th>Código<br>impuesto</th>
                            <th>IMPUESTO</th>
                            <th>Porcentaje<br>Retención</th>
                            <th>Valor Retención</th>
                        </thead>
                        <tbody>
                            <g:each in="${det}" var="d">
                                <tr>
                                    <td style="text-align: center">${p.contabilidad}</td>
                                    <td style="text-align: center"><g:formatNumber number="${d.base}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <td style="text-align: center">${d.impuesto.codigo}</td>
                                    <td style="text-align: center">${d.impuesto.nombre}</td>
                                    <td style="text-align: center">${d.impuesto.retencion}</td>
                                    <td style="text-align: center"><g:formatNumber number="${d.base * (d.porcentaje / 100)}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                                    <g:set var="total" value="${total.toDouble() + d.base * (d.porcentaje / 100)}"></g:set>
                                </tr>
                            </g:each>
                            <tr>
                                <td colspan="5" style="font-size: 11px;text-align: right">Total de retención:</td>
                                <td style="text-align: center"><g:formatNumber number="${total}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div style="width: 594px;margin: 2px;height: 60px;">
                    <div style="width: 200px;height: 95px;margin-left: 20px;margin-top: 5px;text-align: center;float: left">
                        <span style="display: block;font-weight: bold;height: 40px"></span>
                        <span style="display: block;font-size: 11px;border-top: 1px solid black;">
                            Firma del agente de retención
                        </span>

                    </div>

                    <div style="width: 200px;height: 95px;margin-right: 20px;margin-top: 5px;text-align: center;float: right">
                        <span style="display: block;font-weight: bold;height: 40px"></span>
                        <span style="display: block;font-size: 11px;border-top: 1px solid black;">
                            Firma del sujeto pasivo retenido
                        </span>

                    </div>
                </div>
            </div>

        </div>
    </body>
</html>