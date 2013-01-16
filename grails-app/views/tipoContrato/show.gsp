

<ol class="property-list tipoContrato">
    
    <g:if test="${tipoContratoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoContrato.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoContratoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
