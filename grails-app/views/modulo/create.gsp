<%@ page import="cratos.seguridad.Modulo" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'modulo.label', default: 'Modulo')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
    </span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label"
                                                                           args="[entityName]"/></g:link></span>
</div>

<div class="body">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${moduloInstance}">
        <div class="errors">
            <g:renderErrors bean="${moduloInstance}" as="list"/>
        </div>
    </g:hasErrors>
    <g:form action="save">
        <div class="dialog">
            <table>
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="descripcion"><g:message code="modulo.descripcion.label"
                                                            default="Descripcion"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: moduloInstance, field: 'descripcion', 'errors')}">
                        <g:textField name="descripcion" id="descripcion" title="Descripcion"
                                     class="6 field ui-widget-content ui-corner-all"
                                     value="${moduloInstance?.descripcion}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="nombre"><g:message code="modulo.nombre.label" default="Nombre"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: moduloInstance, field: 'nombre', 'errors')}">
                        <g:textField name="nombre" id="nombre" title="Nombre"
                                     class="6 field ui-widget-content ui-corner-all" value="${moduloInstance?.nombre}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="orden"><g:message code="modulo.orden.label" default="Orden"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: moduloInstance, field: 'orden', 'errors')}">
                        <g:textField class="17 field ui-widget-content ui-corner-all" name="orden" title="Orden"
                                     id="orden" value="${fieldValue(bean: moduloInstance, field: 'orden')}"/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="save"
                                                 value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
    </g:form>
</div>
</body>
</html>
