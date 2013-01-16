

<ol class="property-list profesion">
    
    <g:if test="${profesionInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="profesion.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${profesionInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${profesionInstance?.sigla}">
        <li class="fieldcontain">
            <span id="sigla-label" class="property-label"><g:message code="profesion.sigla.label" default="Sigla" /></span>
            
            <span class="property-value" aria-labelledby="sigla-label"><g:fieldValue bean="${profesionInstance}" field="sigla"/></span>
            
        </li>
    </g:if>
    
</ol>
