

<ol class="property-list color">
    
    <g:if test="${colorInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="color.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${colorInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
