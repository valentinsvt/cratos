

<ol class="property-list tipoRelacion">
    
    <g:if test="${tipoRelacionInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoRelacion.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoRelacionInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoRelacionInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoRelacion.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoRelacionInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
