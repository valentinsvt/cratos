

<ol class="property-list nacionalidad">
    
    <g:if test="${nacionalidadInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="nacionalidad.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${nacionalidadInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
