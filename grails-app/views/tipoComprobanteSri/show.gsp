

<ol class="property-list tipoComprobanteSri">
    
    <g:if test="${tipoComprobanteSriInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoComprobanteSri.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoComprobanteSriInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoComprobanteSriInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoComprobanteSri.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoComprobanteSriInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
