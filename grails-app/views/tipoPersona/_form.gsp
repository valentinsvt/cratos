<%@ page import="cratos.TipoPersona" %>



<div class="fieldcontain ${hasErrors(bean: tipoPersonaInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoPersona.codigo.label" default="Código" />

	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${tipoPersonaInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoPersonaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoPersona.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="15" style="width: 150px" class="field ui-widget-content ui-corner-all required" value="${tipoPersonaInstance?.descripcion}"/>
</div>

