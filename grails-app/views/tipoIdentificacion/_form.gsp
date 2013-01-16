<%@ page import="cratos.TipoIdentificacion" %>



<div class="fieldcontain ${hasErrors(bean: tipoIdentificacionInstance, field: 'codigo', 'error')} required">
	<label for="codigo">
		<g:message code="tipoIdentificacion.codigo.label" default="Codigo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="codigo" maxlength="4" class="field ui-widget-content ui-corner-all required"
                 value="${tipoIdentificacionInstance?.codigo}" style="width: 40px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: tipoIdentificacionInstance, field: 'descripcion', 'error')} required">
	<label for="descripcion">
		<g:message code="tipoIdentificacion.descripcion.label" default="Descripcion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descripcion" maxlength="63" class="field ui-widget-content ui-corner-all required"
                 value="${tipoIdentificacionInstance?.descripcion}" style="width: 300px;"    />
</div>

<div class="fieldcontain ${hasErrors(bean: tipoIdentificacionInstance, field: 'tipoAnexo', 'error')} ">
	<label for="tipoAnexo">
		<g:message code="tipoIdentificacion.tipoAnexo.label" default="Tipo Anexo" />
		
	</label>
	<g:select name="tipoAnexo" from="${tipoIdentificacionInstance.constraints.tipoAnexo.inList}"
              class="ui-widget-content ui-corner-all" value="${tipoIdentificacionInstance?.tipoAnexo}"
              valueMessagePrefix="tipoIdentificacion.tipoAnexo" noSelection="['': '']" style="40px;"/>
</div>

