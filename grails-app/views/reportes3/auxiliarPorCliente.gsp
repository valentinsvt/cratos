<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/10/12
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Auxiliar por clientes</title>

        <style type="text/css">
        @page {
            size   : 29.7cm 21cm;  /*width height */
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
        </style>

    </head>

    <body>
        <div class="hoja">
            ${html}
        </div>
    </body>
</html>