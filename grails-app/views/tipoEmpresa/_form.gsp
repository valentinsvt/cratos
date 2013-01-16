<%@ page import="cratos.TipoEmpresa" %>



<div class="fieldcontain ${hasErrors(bean: tipoEmpresaInstance, field: 'descripcion', 'error')} required ">
	<label for="descripcion">
		<g:message code="tipoEmpresa.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all required" style="width: 230px" value="${tipoEmpresaInstance?.descripcion}"/>
</div>

