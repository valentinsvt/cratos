<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Situacion financiera</title>
        <style type="text/css">
        @page {
            size   : 21cm 29.7cm;  /*width height */
            margin : 2cm;
        }

        html {
            font-family : Verdana, Arial, sans-serif;
            font-size   : 15px;
        }

        .hoja {
            width : 16cm;
            /*background : #d8f0fa;*/
        }

        h1, h2, h3 {
            text-align : center;
        }

        table {
            border-collapse : collapse;
            width           : 100%;
        }

        th, td {
            vertical-align : middle;
        }

        th {
            background : #bbb;
        }

        .even {
            background : #ddd;
        }

        .odd {
            background : #efefef;
        }

        .Uno {
            background : #DDDDC0;
            /*color      : #FFF;*/
        }

        .Dos {
            background : #DDDDD0;
        }

        .Tres {
            background : #EDEDE0;
        }

        .Cuatro {
            background : #DDDDF0;
        }

        .Cinco {
            background : #DDEDFF;
        }

        .Seis {
            background : #EDDDFF;
        }

        .saldo {
            text-align : right;
        }

        .Uno .saldo {
            margin-right : 0;
        }

        .Dos .saldo {
            padding-right : 20px;
        }

        .Tres .saldo {
            padding-right : 40px;
        }

        .Cuatro .saldo {
            padding-right : 60px;
        }

        .Cinco .saldo {
            padding-right : 80px;
        }

        .Seis .saldo {
            padding-right : 100px;
        }

        .Uno .numero {
            margin-left : 0;
        }

        .Dos .numero {
            padding-left : 20px;
        }

        .Tres .numero {
            padding-left : 40px;
        }

        .Cuatro .numero {
            padding-left : 60px;
        }

        .Cinco .numero {
            padding-left : 80px;
        }

        .Seis .numero {
            padding-left : 100px;
        }
        </style>

    </head>

    <body>
        <div class="hoja">
            <h1>Periodo ${periodo.numero}</h1>

            <h2>Situación financiera</h2>

            <h3>***Periodo del ${periodo.fechaInicio.format('dd-MM-yyyy')} a ${periodo.fechaFin.format('dd-MM-yyyy')}</h3>

            <table border='1'>
                <thead>
                    <tr>
                        <th width="15%">Número</th>
                        <th width="55%">Cuenta</th>
                        <th width="30%">Saldo</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${datos}" var="dato" status="i">
                        <tr class="${dato.cuenta.nivel.descripcion}">
                            <td class="numero">
                                ${dato.cuenta.numero}
                            </td>
                            <td>
                                ${dato.cuenta.descripcion}
                            </td>
                            <td class="saldo">
                                <g:formatNumber number="${dato.debe - dato.haber}" maxFractionDigits="2" minFractionDigits="2" type="number"/>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>

    </body>
</html>