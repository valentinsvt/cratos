<%@ page import="cratos.Cuenta" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'cuenta.label', default: 'Cuenta')}"/>
        <title>Lista de Cuentas</title>

        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree', file: 'jquery.jstree.js')}"></script>
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/jstree/_lib', file: 'jquery.cookie.js')}"></script>

    </head>

    <body>
        <a href="#list-cuenta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

        <div id="list-cuenta" class="content scaffold-list" role="main">
            <div class="ui-widget-header ui-corner-all nav navegacion">
                <ul style="margin-bottom:0;">
                    %{--<li><g:link class="create linkButton" action="create">Crear Cuenta</g:link></li>--}%
                </ul>
            </div>

            <div class="contenedor">
                <h1>Lista de Cuentas</h1>
                <g:if test="${flash.message}">
                    <div class="message ${flash.clase}" role="status"><span class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
                    </div>
                </g:if>

                <table>
                    <thead>
                        <tr>

                            <g:sortableColumn property="auxiliar" title="Auxiliar"/>

                            <g:sortableColumn property="movimiento" title="Movimiento"/>

                            <g:sortableColumn property="descripcion" title="Descripción"/>

                            <g:sortableColumn property="padre" title="Padre"/>

                            <g:sortableColumn property="numero" title="Número"/>

                            <th>Empresa</th>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cuentaInstanceList}" status="i" var="cuentaInstance">
                            <tr>

                                <td><g:link action="show" id="${cuentaInstance.id}">${fieldValue(bean: cuentaInstance, field: "auxiliar")}</g:link></td>

                                <td>${fieldValue(bean: cuentaInstance, field: "movimiento")}</td>

                                <td>${fieldValue(bean: cuentaInstance, field: "descripcion")}</td>

                                <td>${fieldValue(bean: cuentaInstance, field: "padre")}</td>

                                <td>${fieldValue(bean: cuentaInstance, field: "numero")}</td>

                                <td>${fieldValue(bean: cuentaInstance, field: "empresa")}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>

            <div class="ui-widget-header pagination" style="padding: 5px;">
                <g:paginate total="${cuentaInstanceTotal}" prev="Anterior" next="Siguiente" params="${params}"/>
            </div>

        </div>
    </body>
</html>
