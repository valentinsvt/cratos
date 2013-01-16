<%@ page import="cratos.Marca" %>



<div class="fieldcontain ${hasErrors(bean: marcaInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="marca.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 250px" class="field ui-widget-content ui-corner-all required" value="${marcaInstance?.descripcion}"/>
</div>

