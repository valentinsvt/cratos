<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Balance General</title>

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
        %{--<p>${empresa}</p>--}%

    </div>
    <div style="width: 95%;margin-top: 20px;">

        <div>ACTIVO</div>

        <div> Fondos Disponibles</div>

        <table>
            <tr>
                <td style="font-weight: bold">
                 Caja General

                </td>
                <td>


                </td>
                <td style="font-weight: bold">
                 Banco Internacional

                </td>
                <td>


                </td>
            </tr>


        </table>

        <div>Cuentas por Cobrar</div>

        <table>
            <tr>

                <td style="font-weight: bold">
                    Caja General

                </td>
                <td>


                </td>


            </tr>

        </table>


    </div>

</div>
</body>
</html>