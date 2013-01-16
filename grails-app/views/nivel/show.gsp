

<ol class="property-list nivel">
    
    <g:if test="${nivelInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="nivel.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${nivelInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
