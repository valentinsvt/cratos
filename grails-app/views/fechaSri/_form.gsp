<%@ page import="cratos.FechaSri" %>



<div class="fieldcontain ${hasErrors(bean: fechaSriInstance, field: 'numero', 'error')} required">
	<label for="numero">
		<g:message code="fechaSri.numero.label" default="Número" />

	</label>
	<g:textField name="numero" maxlength="7" style="width: 70px" class="field ui-widget-content ui-corner-all required"
                 value="${fechaSriInstance?.numero}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: fechaSriInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="fechaSri.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="63" style="width: 300px" class="field ui-widget-content ui-corner-all required"
                 value="${fechaSriInstance?.descripcion}"/>
</div>

