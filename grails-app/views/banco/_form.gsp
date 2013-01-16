<%@ page import="cratos.Banco" %>

%{--<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'empresa', 'error')} ">--}%
    %{--<label for="empresa">--}%
        %{--<g:message code="banco.empresa.label" default="Empresa" />--}%

    %{--</label>--}%
    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" class="many-to-one field ui-widget-content ui-corner-all"--}%
              %{--value="${bancoInstance?.empresa?.id}" noSelection="['null': '']"/>--}%
%{--</div>--}%


<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="banco.codigo.label" default="Código" />

	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required" value="${bancoInstance?.codigo}" style="width: 40px"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bancoInstance, field: 'descripcion', 'error')} required">
    <label for="descripcion">
        <g:message code="banco.descripcion.label" default="Descripción" />

    </label>
    <g:textField name="descripcion" maxlength="40" class="field ui-widget-content ui-corner-all required" value="${bancoInstance?.descripcion}" style="width: 320px"/>
</div>

