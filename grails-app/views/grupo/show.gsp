

<ol class="property-list grupo">
    
    <g:if test="${grupoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="grupo.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${grupoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${grupoInstance?.cuenta}">
        <li class="fieldcontain">
            <span id="cuenta-label" class="property-label"><g:message code="grupo.cuenta.label" default="Cuenta" /></span>
            
            <span class="property-value" aria-labelledby="cuenta-label">
                %{--<g:link controller="cuenta" action="show" id="${grupoInstance?.cuenta?.id}">--}%
                    ${grupoInstance?.cuenta?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${grupoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="grupo.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${grupoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
