<%@ page import="cratos.TipoCuenta" %>



<div class="fieldcontain ${hasErrors(bean: tipoCuentaInstance, field: 'tipoCuenta', 'error')} required">
	<label for="tipoCuenta">
		<g:message code="tipoCuenta.tipoCuenta.label" default="Tipo Cuenta" />

	</label>
	<g:textField name="tipoCuenta" maxlength="63" style="width: 300px" class="field ui-widget-content ui-corner-all required"
                 value="${tipoCuentaInstance?.tipoCuenta}"/>

</div>

