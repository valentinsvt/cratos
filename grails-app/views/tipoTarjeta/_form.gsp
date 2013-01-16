<%@ page import="cratos.TipoTarjeta" %>



<div class="fieldcontain ${hasErrors(bean: tipoTarjetaInstance, field: 'descripcion', 'error')} required ">
	<label for="descripcion">
		<g:message code="tipoTarjeta.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="31" style="width: 230px " class="field ui-widget-content ui-corner-all required" value="${tipoTarjetaInstance?.descripcion}"/>
</div>

