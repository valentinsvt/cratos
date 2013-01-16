<%@ page import="cratos.Unidad" %>



<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="unidad.codigo.label" default="Código" />

	</label>
	<g:textField name="codigo" maxlength="8" style="width: 80px" class="field ui-widget-content ui-corner-all required" value="${unidadInstance?.codigo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: unidadInstance, field: 'descripcion', 'error')} required ">
	<label for="descripcion">
		<g:message code="unidad.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 200px" class="field ui-widget-content ui-corner-all required" value="${unidadInstance?.descripcion}"/>
</div>

