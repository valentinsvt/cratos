

<ol class="property-list estado">
    
    <g:if test="${estadoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="estado.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${estadoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${estadoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="estado.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${estadoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
