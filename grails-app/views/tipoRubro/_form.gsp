<%@ page import="cratos.TipoRubro" %>



<div class="fieldcontain ${hasErrors(bean: tipoRubroInstance, field: 'codigo', 'error')} ">
	<label for="codigo">
		<g:message code="tipoRubro.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="1" class="field ui-widget-content ui-corner-all"
                 value="${tipoRubroInstance?.codigo}" style="width: 30px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoRubroInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="tipoRubro.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all"
                 value="${tipoRubroInstance?.descripcion}" style="width: 240px;"/>
</div>

