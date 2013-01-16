

<ol class="property-list marca">
    
    <g:if test="${marcaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="marca.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${marcaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
