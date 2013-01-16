

<ol class="property-list estadoCivil">
    
    <g:if test="${estadoCivilInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="estadoCivil.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${estadoCivilInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
