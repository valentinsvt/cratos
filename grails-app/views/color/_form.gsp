<%@ page import="cratos.Color" %>



<div class="fieldcontain ${hasErrors(bean: colorInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="color.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all" value="${colorInstance?.descripcion}"/>
</div>

