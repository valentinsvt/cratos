

<ol class="property-list rubroTipoContrato">
    
    <g:if test="${rubroTipoContratoInstance?.tipoContrato}">
        <li class="fieldcontain">
            <span id="tipoContrato-label" class="property-label"><g:message code="rubroTipoContrato.tipoContrato.label" default="Tipo Contrato" /></span>
            
            <span class="property-value" aria-labelledby="tipoContrato-label">
                %{--<g:link controller="tipoContrato" action="show" id="${rubroTipoContratoInstance?.tipoContrato?.id}">--}%
                    ${rubroTipoContratoInstance?.tipoContrato?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.rubro}">
        <li class="fieldcontain">
            <span id="rubro-label" class="property-label"><g:message code="rubroTipoContrato.rubro.label" default="Rubro" /></span>
            
            <span class="property-value" aria-labelledby="rubro-label">
                %{--<g:link controller="rubro" action="show" id="${rubroTipoContratoInstance?.rubro?.id}">--}%
                    ${rubroTipoContratoInstance?.rubro?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.porcentaje}">
        <li class="fieldcontain">
            <span id="porcentaje-label" class="property-label"><g:message code="rubroTipoContrato.porcentaje.label" default="Porcentaje" /></span>
            
            <span class="property-value" aria-labelledby="porcentaje-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="porcentaje"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.editable}">
        <li class="fieldcontain">
            <span id="editable-label" class="property-label"><g:message code="rubroTipoContrato.editable.label" default="Editable" /></span>
            
            <span class="property-value" aria-labelledby="editable-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="editable"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.decimo}">
        <li class="fieldcontain">
            <span id="decimo-label" class="property-label"><g:message code="rubroTipoContrato.decimo.label" default="Decimo" /></span>
            
            <span class="property-value" aria-labelledby="decimo-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="decimo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.iess}">
        <li class="fieldcontain">
            <span id="iess-label" class="property-label"><g:message code="rubroTipoContrato.iess.label" default="Iess" /></span>
            
            <span class="property-value" aria-labelledby="iess-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="iess"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.gravable}">
        <li class="fieldcontain">
            <span id="gravable-label" class="property-label"><g:message code="rubroTipoContrato.gravable.label" default="Gravable" /></span>
            
            <span class="property-value" aria-labelledby="gravable-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="gravable"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.valor}">
        <li class="fieldcontain">
            <span id="valor-label" class="property-label"><g:message code="rubroTipoContrato.valor.label" default="Valor" /></span>
            
            <span class="property-value" aria-labelledby="valor-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="valor"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroTipoContratoInstance?.observaciones}">
        <li class="fieldcontain">
            <span id="observaciones-label" class="property-label"><g:message code="rubroTipoContrato.observaciones.label" default="Observaciones" /></span>
            
            <span class="property-value" aria-labelledby="observaciones-label"><g:fieldValue bean="${rubroTipoContratoInstance}" field="observaciones"/></span>
            
        </li>
    </g:if>
    
</ol>
