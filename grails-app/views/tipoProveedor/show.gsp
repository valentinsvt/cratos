

<ol class="property-list tipoProveedor">
    
    <g:if test="${tipoProveedorInstance?.codigo}">
        <li class="fieldcontain">
            <span id="codigo-label" class="property-label"><g:message code="tipoProveedor.codigo.label" default="Codigo" /></span>
            
            <span class="property-value" aria-labelledby="codigo-label"><g:fieldValue bean="${tipoProveedorInstance}" field="codigo"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoProveedorInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="tipoProveedor.descripcion.label" default="Descripcion" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${tipoProveedorInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
