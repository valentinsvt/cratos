

<ol class="property-list tipoDocumento">
    
    <g:if test="${tipoDocumentoInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoDocumento.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoDocumentoInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoDocumentoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoDocumento.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoDocumentoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
