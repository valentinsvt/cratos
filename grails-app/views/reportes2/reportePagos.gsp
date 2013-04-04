<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Reporte de Pagos</title>

    <style type="text/css">
    @page {
        size   : 21cm 29.7cm;  /*width height */
        margin : 2cm;
    }

    html {
        font-family : Verdana, Arial, sans-serif;
        font-size   : 11px;
    }

    .hoja {
        width : 25cm;
        /*background : #d8f0fa;*/
    }

    h1, h2, h3 {
        text-align : center;
    }

    h1 {
        font-size  : 16px;
        margin-top : 30px;
    }

    table {
        border-collapse : collapse;
        width           : 100%;
    }

    /*th, td {*/
        /*vertical-align : middle;*/
    /*}*/

    th {
        background : #bbb;
    }

    .even {
        background : #ddd;
    }

    .odd {
        background : #efefef;
    }

    .cliente th {
        background : #D1D1D1 !important;
    }

    .right {
        text-align : right;
    }

    .errorReporte {
        font-size   : 20px;
        font-weight : bold;
        padding     : 20px;
        text-align  : center;
        border      : solid 1px #a31b27;
        color       : #a31b27;
        background  : #ffcecf;
    }
    .titulo{
        font-size: 14px;
        font-weight: bold;
    }
    </style>

</head>

<body>
<div class="hoja">
    <div class="titulo">
        <p>${empresa}</p>
        <p>
            Reporte pagos desde ${fechaInicio?.format("dd-MM-yyyy")} hasta ${fechaFin?.format("dd-MM-yyyy")}
        </p>
    </div>
    <div style="width: 95%;margin-top: 20px;">

<g:each in="${auxiliar}" var="aux">

    <table>

        <tr>
           <td style="font-weight: bold">
            Fecha:
            </td>
            <td>
            ${aux?.fechaPago?.format("dd-MM-yyyy")}
            </td>
        </tr>
        <tr>
         <td style="font-weight: bold">
             Descripción:

         </td>
            <td>
                ${aux?.descripcion}
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold">
                Proveedor:
            </td>
            <td>
                ${aux?.proveedor}
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold">
                Debe:
            </td>
            <td style="margin-left: -100px">
                ${aux?.debe}
            </td>
        </tr>
        <tr style="margin-bottom: 10px">
            <td style="font-weight: bold">
                Haber:
            </td>
            <td>
                ${aux?.haber}
            </td>
        </tr>



    </table>


        <table border="1">


            <thead>

            <tr>
            <th>Fecha</th>
            <th>Factura</th>
            <th>Tipo de Documento</th>
            <th>Monto</th>

            </tr>

            </thead>

            %{--<g:each in="${pagos}" var="pago">--}%
            <tbody>
            <tr>
            <g:each in="${cratos.PagoAux.findAllByAuxiliar(aux)}" var="pago">

            <td style="text-align: left; width: 70px">${pago?.fecha?.format("dd-MM-yyyy")}</td>
            <td style="text-align: left; width: 70px">${pago?.factura}</td>
                <td style="text-align: left; width: 100px">${pago?.tipoDocumento?.descripcion}</td>
                <td style="text-align: left; width: 200px">${pago?.monto}</td>


            </g:each>

            </tr>

            </tbody>



        </table>


         <div style="margin-bottom: 40px"> </div>

        </g:each>

    </div>

</div>
</body>
</html>