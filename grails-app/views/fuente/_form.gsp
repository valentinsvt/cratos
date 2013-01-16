<%@ page import="cratos.Fuente" %>



<div class="fieldcontain ${hasErrors(bean: fuenteInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="fuente.descripcion.label" default="Descripción" />

	</label>
	<g:textField name="descripcion" maxlength="40" style="width: 300px" class="field ui-widget-content ui-corner-all required"
                 value="${fuenteInstance?.descripcion}"/>
</div>

