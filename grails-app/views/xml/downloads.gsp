<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/23/13
  Time: 12:54 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Archivos XML para descargar</title>
    </head>

    <body>
        <div class="container entero ui-widget-content ui-corner-all">
            <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;height: 30px;line-height: 30px;padding-left: 30px;margin-bottom: 20px;">
                Archivos XML del Anexo Transaccional SRI
            </h1>

            <div>
                A continuación se presentan los archivos XML previamente generados. Haga click en el nombre del archivo para descargarlo.
            </div>

            <table border="1">
                <thead>
                    <tr>
                        <th>Mes</th>
                        <th>Año</th>
                        <th>Fecha de creación</th>
                        <th>Descargar</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${list}" var="arch">
                        <tr>
                            <td>${arch.mes}</td>
                            <td>${arch.anio}</td>
                            <td>${arch.modified}</td>
                            <td>${arch.file}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>

        </div>
    </body>
</html>