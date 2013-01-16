<%@ page import="cratos.Profesion" %>



<div class="fieldcontain ${hasErrors(bean: profesionInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="profesion.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all required" value="${profesionInstance?.descripcion}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: profesionInstance, field: 'sigla', 'error')} required">
	<label for="sigla">
		<g:message code="profesion.sigla.label" default="Sigla" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="sigla" maxlength="7" class="field ui-widget-content ui-corner-all required" value="${profesionInstance?.sigla}"/>
</div>

