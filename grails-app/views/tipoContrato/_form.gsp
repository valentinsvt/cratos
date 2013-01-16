<%@ page import="cratos.TipoContrato" %>



<div class="fieldcontain ${hasErrors(bean: tipoContratoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="tipoContrato.descripcion.label" default="Descripcion" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" class="field ui-widget-content ui-corner-all" value="${tipoContratoInstance?.descripcion}" style="width: 300px"/>
</div>

