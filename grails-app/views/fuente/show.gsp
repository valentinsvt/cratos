

<ol class="property-list fuente">
    
    <g:if test="${fuenteInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="fuente.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${fuenteInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
