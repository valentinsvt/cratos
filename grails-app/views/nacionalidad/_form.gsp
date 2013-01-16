<%@ page import="cratos.Nacionalidad" %>



<div class="fieldcontain ${hasErrors(bean: nacionalidadInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="nacionalidad.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 250px" class="field ui-widget-content ui-corner-all required" value="${nacionalidadInstance?.descripcion}"/>
</div>

