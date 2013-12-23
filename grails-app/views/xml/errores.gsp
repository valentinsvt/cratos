<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 12/23/13
  Time: 12:31 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Errores</title>

        <style type="text/css">
        .message {
            padding : 10px;
        }

        .btn {
            color : #e3e3e3 !important;
        }
        </style>
    </head>

    <body>
        <g:if test="${params.tipo == '1'}">
            <div class="message" role="status">
                Ya existe un archivo XML para el periodo ${params.periodo}.<br/>
                Si desea sobreescribir el archivo existente, haga click en el botón 'Sobreescribir'<br/>
                Si desea descargar un archivo previamente generado, haga cilck en el botón 'Descargas'<br/><br/>

                <g:link class="btn btnBack" action="xml">Regresar</g:link>
                <g:link class="btn btnOverride" action="printXml" params="[mes: params.mes, anio: params.anio, override: 1]" style="margin-left:15px;">Sobreescribir</g:link>
                <g:link class="btn btnDownload" action="downloads" style="margin-left:15px;">Descargas</g:link>
            </div>
        </g:if>
        <g:elseif test="${params.tipo == '2'}">
            <div class="message" role="status">
                No se encontró el archivo XML solicitado.
                Si desea descargar un archivo previamente generado, haga cilck en el botón 'Descargas'<br/><br/>

                <g:link class="btn btnBack" action="xml">Regresar</g:link>
                <g:link class="btn btnDownload" action="downloads" style="margin-left:15px;">Descargas</g:link>
            </div>
        </g:elseif>
        <g:else>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
        </g:else>

        <script type="text/javascript">
            $(function () {
                $(".btnBack").button({
                    icons : {
                        primary : "ui-icon-arrowthick-1-w"
                    }
                });
                $(".btnOverride").button({
                    icons : {
                        primary : "ui-icon-pencil"
                    }
                });
                $(".btnDownload").button({
                    icons : {
                        primary : "ui-icon-arrowstop-1-s"
                    }
                });
            });
        </script>
    </body>
</html>