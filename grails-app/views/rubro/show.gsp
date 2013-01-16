

<ol class="property-list rubro">
    
    <g:if test="${rubroInstance?.tipoRubro}">
        <li class="fieldcontain">
            <span id="tipoRubro-label" class="property-label"><g:message code="rubro.tipoRubro.label" default="Tipo Rubro" /></span>
            
            <span class="property-value" aria-labelledby="tipoRubro-label">
                %{--<g:link controller="tipoRubro" action="show" id="${rubroInstance?.tipoRubro?.id}">--}%
                    ${rubroInstance?.tipoRubro?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="rubro.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${rubroInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.porcentaje}">
        <li class="fieldcontain">
            <span id="porcentaje-label" class="property-label"><g:message code="rubro.porcentaje.label" default="Porcentaje" /></span>
            
            <span class="property-value" aria-labelledby="porcentaje-label"><g:fieldValue bean="${rubroInstance}" field="porcentaje"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.editable}">
        <li class="fieldcontain">
            <span id="editable-label" class="property-label"><g:message code="rubro.editable.label" default="Editable" /></span>
            
            <span class="property-value" aria-labelledby="editable-label"><g:fieldValue bean="${rubroInstance}" field="editable"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.decimo}">
        <li class="fieldcontain">
            <span id="decimo-label" class="property-label"><g:message code="rubro.decimo.label" default="Decimo" /></span>
            
            <span class="property-value" aria-labelledby="decimo-label"><g:fieldValue bean="${rubroInstance}" field="decimo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.iess}">
        <li class="fieldcontain">
            <span id="iess-label" class="property-label"><g:message code="rubro.iess.label" default="Iess" /></span>
            
            <span class="property-value" aria-labelledby="iess-label"><g:fieldValue bean="${rubroInstance}" field="iess"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.gravable}">
        <li class="fieldcontain">
            <span id="gravable-label" class="property-label"><g:message code="rubro.gravable.label" default="Gravable" /></span>
            
            <span class="property-value" aria-labelledby="gravable-label"><g:fieldValue bean="${rubroInstance}" field="gravable"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${rubroInstance?.valor}">
        <li class="fieldcontain">
            <span id="valor-label" class="property-label"><g:message code="rubro.valor.label" default="Valor" /></span>
            
            <span class="property-value" aria-labelledby="valor-label"><g:fieldValue bean="${rubroInstance}" field="valor"/></span>
            
        </li>
    </g:if>
    
</ol>
