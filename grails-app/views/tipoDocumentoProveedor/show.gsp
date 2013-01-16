

<ol class="property-list tipoDocumentoProveedor">
    
    <g:if test="${tipoDocumentoProveedorInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoDocumentoProveedor.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoDocumentoProveedorInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoDocumentoProveedorInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoDocumentoProveedor.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoDocumentoProveedorInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
