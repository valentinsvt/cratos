<%@ page import="cratos.Grupo" %>



<div class="fieldcontain ${hasErrors(bean: grupoInstance, field: 'codigo', 'error')} ">
	<label for="codigo">
		<g:message code="grupo.codigo.label" default="Código" />
		
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all"
                 value="${grupoInstance?.codigo}" style="width: 40px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: grupoInstance, field: 'cuenta', 'error')} ">
	<label for="cuenta">
		<g:message code="grupo.cuenta.label" default="Cuenta" />
		
	</label>
	<g:select id="cuenta" name="cuenta.id" from="${cratos.Cuenta.list()}" optionKey="id" class="many-to-one ui-widget-content ui-corner-all"
              value="${grupoInstance?.cuenta?.id}" noSelection="['null': '']" style="width: 400px;" />
</div>

<div class="fieldcontain ${hasErrors(bean: grupoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion">
		<g:message code="grupo.descripcion.label" default="Descripción" />
		
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all"
                 value="${grupoInstance?.descripcion}" style="width: 400px;"/>
</div>

