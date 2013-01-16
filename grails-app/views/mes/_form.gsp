<%@ page import="cratos.Mes" %>



<div class="fieldcontain ${hasErrors(bean: mesInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="mes.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="15" class="field ui-widget-content ui-corner-all" value="${mesInstance?.descripcion}"/>
</div>

