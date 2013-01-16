<%@ page import="cratos.Nivel" %>



<div class="fieldcontain ${hasErrors(bean: nivelInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="nivel.descripcion.label" default="Descripción" />
		</label>
	<g:textField name="descripcion" maxlength="16" style="width: 130px" class="field ui-widget-content ui-corner-all required" value="${nivelInstance?.descripcion}"/>
</div>

