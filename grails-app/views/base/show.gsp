

<ol class="property-list base">
    
    <g:if test="${baseInstance?.periodo}">
        <li class="fieldcontain">
            <span id="periodo-label" class="property-label"><g:message code="base.periodo.label" default="Periodo" /></span>
            
            <span class="property-value" aria-labelledby="periodo-label">
                %{--<g:link controller="contabilidad" action="show" id="${baseInstance?.periodo?.id}">--}%
                    ${baseInstance?.periodo?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${baseInstance?.fraccionBasica}">
        <li class="fieldcontain">
            <span id="fraccionBasica-label" class="property-label"><g:message code="base.fraccionBasica.label" default="Fraccion Basica" /></span>
            
            <span class="property-value" aria-labelledby="fraccionBasica-label"><g:fieldValue bean="${baseInstance}" field="fraccionBasica"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${baseInstance?.excesoHasta}">
        <li class="fieldcontain">
            <span id="excesoHasta-label" class="property-label"><g:message code="base.excesoHasta.label" default="Exceso Hasta" /></span>
            
            <span class="property-value" aria-labelledby="excesoHasta-label"><g:fieldValue bean="${baseInstance}" field="excesoHasta"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${baseInstance?.impuestosFraccion}">
        <li class="fieldcontain">
            <span id="impuestosFraccion-label" class="property-label"><g:message code="base.impuestosFraccion.label" default="Impuestos Fraccion" /></span>
            
            <span class="property-value" aria-labelledby="impuestosFraccion-label"><g:fieldValue bean="${baseInstance}" field="impuestosFraccion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${baseInstance?.porcentaje}">
        <li class="fieldcontain">
            <span id="porcentaje-label" class="property-label"><g:message code="base.porcentaje.label" default="Porcentaje" /></span>
            
            <span class="property-value" aria-labelledby="porcentaje-label"><g:fieldValue bean="${baseInstance}" field="porcentaje"/></span>
            
        </li>
    </g:if>
    
</ol>
