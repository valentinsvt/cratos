<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main"/>
    <title>Comprobante ${comp.prefijo+comp.numero} ${(comp.registrado=="B")?" Anulado":""}</title>
    <style type="text/css">
    .etiqueta {
        width       : 100px;
        height      : 20px;
        line-height : 20px;
        font-weight : bold;
        display     : inline-block;
    }
    </style>
</head>
<body>
<div class="container entero ui-corner-all">
    <a href="${g.createLink(action: 'procesosAnulados')}" id="regresar" style="float: left;width: 100px;height: 30px;color: white;margin-left: 25px;margin-bottom: 15px;">Regresar</a>
    <fieldset style="margin-left: 25px;width: 800px;float: left" class="ui-corner-all">
        <legend>Comprobante ${(comp.registrado=="B")?" Anulado":""}</legend>
        <div class="etiqueta">Número:</div> ${comp?.prefijo}${comp?.numero}<br>

        <div class="etiqueta">Descripción:</div> ${comp?.descripcion}     <br>

        <div class="etiqueta">Fecha:</div> ${comp?.fecha?.format('dd/MM/yyyy')}<br>
        <div class="etiqueta">Estado:</div><span style="color: red">${(comp.registrado=="B")?" Anulado":""}${(comp.registrado=="R")?" Mayorizado":""}${(comp.registrado!="R" && comp.registrado!="B" )?" No mayorizado":""}</span> <br>

        <table border="1" style="width: 600px;margin-top: 10px;border:1px solid black;padding:5px">

            <tr>
                <th style="width: 140px" align="center" class="ui-state-focus">
                    Número
                </th>
                <th style="width: 360px" align="center" class="ui-state-focus">
                    Cuenta
                </th>
                <th style="width: 60px" align="center" class="ui-state-focus">
                    Debe
                </th>
                <th style="width: 60px" align="center" class="ui-state-focus">
                    Haber
                </th>

            </tr>

            <g:set var="totalDebe"  value="${0}"/>
            <g:set var="totalHaber" value="${0}"/>

            <g:each in="${asientos}" var="asnt" status="j" >

                <tr>
                    <td>
                        ${asnt.cuenta.numero}
                    </td>
                    <td>
                        ${asnt.cuenta.descripcion}
                    </td>
                    <td style="text-align: right">
                        ${asnt.debe}
                    </td>
                    <td style="text-align: right">
                        ${asnt.haber}
                    </td>
                    <g:set var="totalDebe" value="${totalDebe + asnt.debe}"/>
                    <g:set var="totalHaber" value="${totalHaber +asnt.haber}"/>
                </tr>

            </g:each>

            <tr>
                <td>

                </td>

                <td align="center">
                    TOTAL:

                </td>

                <td style="text-align: right">
                    ${totalHaber.toDouble().round(2)}
                </td>
                <td style="text-align: right">
                    ${totalDebe.toDouble().round(2)}
                </td>
            </tr>

        </table>
    </fieldset>
</div>
   <script type="text/javascript">
       $("#regresar").button()
   </script>
</body>
</html>