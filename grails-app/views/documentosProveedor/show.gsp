

<ol class="property-list documentosProveedor">
    
    <g:if test="${documentosProveedorInstance?.proveedor}">
        <li class="fieldcontain">
            <span id="proveedor-label" class="property-label"><g:message code="documentosProveedor.proveedor.label" default="Proveedor" /></span>
            
            <span class="property-value" aria-labelledby="proveedor-label">
                %{--<g:link controller="proveedor" action="show" id="${documentosProveedorInstance?.proveedor?.id}">--}%
                    ${documentosProveedorInstance?.proveedor?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.tipoDocumentoProveedor}">
        <li class="fieldcontain">
            <span id="tipoDocumentoProveedor-label" class="property-label"><g:message code="documentosProveedor.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" /></span>
            
            <span class="property-value" aria-labelledby="tipoDocumentoProveedor-label">
                %{--<g:link controller="tipoDocumentoProveedor" action="show" id="${documentosProveedorInstance?.tipoDocumentoProveedor?.id}">--}%
                    ${documentosProveedorInstance?.tipoDocumentoProveedor?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.documentosProveedorSerie01}">
        <li class="fieldcontain">
            <span id="documentosProveedorSerie01-label" class="property-label"><g:message code="documentosProveedor.documentosProveedorSerie01.label" default="Documentos Proveedor Serie01" /></span>
            
            <span class="property-value" aria-labelledby="documentosProveedorSerie01-label"><g:fieldValue bean="${documentosProveedorInstance}" field="documentosProveedorSerie01"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.documentosProveedorSerie02}">
        <li class="fieldcontain">
            <span id="documentosProveedorSerie02-label" class="property-label"><g:message code="documentosProveedor.documentosProveedorSerie02.label" default="Documentos Proveedor Serie02" /></span>
            
            <span class="property-value" aria-labelledby="documentosProveedorSerie02-label"><g:fieldValue bean="${documentosProveedorInstance}" field="documentosProveedorSerie02"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.fechaAutorizacionSRI}">
        <li class="fieldcontain">
            <span id="fechaAutorizacionSRI-label" class="property-label"><g:message code="documentosProveedor.fechaAutorizacionSRI.label" default="Fecha Autorizacion SRI" /></span>
            
            <span class="property-value" aria-labelledby="fechaAutorizacionSRI-label"><g:formatDate date="${documentosProveedorInstance?.fechaAutorizacionSRI}" /></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.fechaValidoHasta}">
        <li class="fieldcontain">
            <span id="fechaValidoHasta-label" class="property-label"><g:message code="documentosProveedor.fechaValidoHasta.label" default="Fecha Valido Hasta" /></span>
            
            <span class="property-value" aria-labelledby="fechaValidoHasta-label"><g:formatDate date="${documentosProveedorInstance?.fechaValidoHasta}" /></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProveedorInstance?.autorizacionSRI}">
        <li class="fieldcontain">
            <span id="autorizacionSRI-label" class="property-label"><g:message code="documentosProveedor.autorizacionSRI.label" default="Autorizacion SRI" /></span>
            
            <span class="property-value" aria-labelledby="autorizacionSRI-label"><g:fieldValue bean="${documentosProveedorInstance}" field="autorizacionSRI"/></span>
            
        </li>
    </g:if>
    
</ol>
