<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/22/12
  Time: 4:40 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Balance general con auxiliares</title>

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
            width : 17cm;
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
            font-size       : 11px;
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

        td.numero {
            width : 3.5cm;
        }

        td.nombre {
            width : 12cm
        }

        td.valor {
            width      : 1.5cm;
            text-align : right;
        }

        td.uno {
            padding-right : 0;
        }

        td.dos {
            padding-right : 15px;
        }

        td.tres {
            padding-right : 30px;
        }

        td.cuatro {
            padding-right : 45px;
        }

        td.cinco {
            padding-right : 60px;
        }

        td.seis {
            padding-right : 75px;
        }

        td.asiento {
            padding-right : 90px;
        }

        tr.cuenta:nth-child(2n) {
            background : #eeeeff;
        }

        tr.cuenta:nth-child(2n+1) {
            background : #eeffee;
        }

        tr.asiento:nth-child(2n) {
            background : #aecff7;
        }

        tr.asiento:nth-child(2n+1) {
            background : #ffffee;
        }

        tr.resultado, tr.total {
            font-weight : bold;
        }

        </style>

    </head>

    <body>
        <div class="hoja">
            ${html}
        </div>
    </body>
</html>