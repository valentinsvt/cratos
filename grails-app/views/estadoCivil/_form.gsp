<%@ page import="cratos.EstadoCivil" %>



<div class="fieldcontain ${hasErrors(bean: estadoCivilInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="estadoCivil.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="15" style="width: 130px" class="field ui-widget-content ui-corner-all required" value="${estadoCivilInstance?.descripcion}"/>
</div>

