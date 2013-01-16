<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Comprobante</title>
    %{--<link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css"/>--}%
    <style type="text/css">
    @page {
        size: 21cm 29.7cm ; /* width height */
        margin: 2cm;
    }

    .hoja {
        width: 25.7cm;
        /*background: #d8f0fa;*/
    }

    .even {
        background: #B7C4F7;
    }

    .odd {
        background: #FCFDFF
    }

    table {
        border-collapse: collapse;
    }

    .item {
        /*background: #e6e6fa;*/
        border-bottom: solid 2px #555;

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
    <div style="width: 600px" align="center">Comprobante</div>


    <g:each in="${comp}" var="item">

        <g:set var="val" value="${item.value}"/>


    %{--<div class="item">--}%
        <table style="width: 600px;">
            <tr>
                <td width="400px" height="50px" >
                    <b>Número:</b> ${item.key}
                </td>

                <td>

                    <b>Fecha:</b>
                    <g:formatDate format="dd/MM/yyyy"  type="datetime" date="${val.fecha}"> </g:formatDate>

                </td>

            </tr>

            <tr>
                <td height="50px">
                    <b>Descripción:</b> ${val.descripcion}
                </td>
                <td>
                    <b>Tipo: </b>${val.tipo}
                </td>

            </tr>

        </table>

        <table border="1" style="width: 600px;">

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

            <g:each in="${val.items}" var="i" status="j" >

                <tr class="${(j%2==0)?'even':'odd'}">
                    <td>
                        ${i.cuenta}
                    </td>
                    <td>
                        ${i.descripcion}
                    </td>
                    <td align="right">
                        ${i.debe}
                    </td>
                    <td align="right">
                        ${i.haber}
                    </td>
                    <g:set var="totalDebe" value="${totalDebe + i.debe}"/>
                    <g:set var="totalHaber" value="${totalHaber +i.haber}"/>
                </tr>

            </g:each>

            <tr>
                <td>

                </td>

                <td align="center">
                    TOTAL:

                </td>

                <td align="right">
                    ${totalHaber}
                </td>
                <td align="right">
                    ${totalDebe}
                </td>
            </tr>

        </table>
    %{--</div>--}%

    </g:each>

</div>
</body>
</html>