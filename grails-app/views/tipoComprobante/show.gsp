

<ol class="property-list tipoComprobante">
    
    <g:if test="${tipoComprobanteInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoComprobante.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoComprobanteInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoComprobanteInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoComprobante.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoComprobanteInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
