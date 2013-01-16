

<ol class="property-list nacionales">
    
    <g:if test="${nacionalesInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="nacionales.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${nacionalesInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
