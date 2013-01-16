<%@ page import="cratos.Estado" %>



<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="estado.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="1" style="width: 30px" class="field ui-widget-content ui-corner-all required" value="${estadoInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="estado.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="63" style="width: 300px " class="field ui-widget-content ui-corner-all required" value="${estadoInstance?.descripcion}"/>
</div>

