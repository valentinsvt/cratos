<%@ page import="cratos.seguridad.Modulo" %>

<g:form>
    <g:hiddenField name="id" id="id_mdlo" value="${mdloInstance?.id}"/>
    <div class="dialog">
        <table>
            <tbody>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="descripcion"><g:message code="modulo.descripcion.label" default="Descripción"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mdloInstance, field: 'descripcion', 'errors')}">
                    <g:textField name="descripcion" id="descripcion" title="Descripción"
                                 class="field ui-widget-content ui-corner-all"
                                 value="${mdloInstance?.descripcion}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nombre"><g:message code="modulo.nombre.label" default="Nombre"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mdloInstance, field: 'nombre', 'errors')}">
                    <g:textField name="nombre" id="nombre" title="Nombre"
                                 class="field ui-widget-content ui-corner-all" value="${mdloInstance?.nombre}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="orden"><g:message code="modulo.orden.label" default="Orden"/></label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mdloInstance, field: 'orden', 'errors')}">
                    <g:textField class="field ui-widget-content ui-corner-all" name="orden" title="Orden"
                                 id="orden" value="${fieldValue(bean: mdloInstance, field: 'orden')}"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>

</g:form>

