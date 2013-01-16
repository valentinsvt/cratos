

<ol class="property-list tipoFactura">
    
    <g:if test="${tipoFacturaInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoFactura.codigo.label" default="Código" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoFacturaInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoFacturaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoFactura.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoFacturaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
