

<ol class="property-list bodega">
    
    <g:if test="${bodegaInstance?.centroCosto}">
        <li class="fieldcontain">
            <span id="centroCosto-label" class="property-label"><g:message code="bodega.centroCosto.label" default="Centro Costo" /></span>
            
            <span class="property-value" aria-labelledby="centroCosto-label">
                %{--<g:link controller="centroCosto" action="show" id="${bodegaInstance?.centroCosto?.id}">--}%
                    ${bodegaInstance?.centroCosto?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${bodegaInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="bodega.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${bodegaInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${bodegaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="bodega.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${bodegaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
