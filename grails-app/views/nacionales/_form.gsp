<%@ page import="cratos.Nacionales" %>



<div class="fieldcontain ${hasErrors(bean: nacionalesInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="nacionales.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 200px" class="field ui-widget-content ui-corner-all required" value="${nacionalesInstance?.descripcion}"/>
</div>

