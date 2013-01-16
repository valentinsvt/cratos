

<ol class="property-list mes">
    
    <g:if test="${mesInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="mes.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${mesInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
