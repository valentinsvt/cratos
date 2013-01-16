

<ol class="property-list documentosProceso">
    
    <g:if test="${documentosProcesoInstance?.proceso}">
        <li class="fieldcontain">
            <span id="proceso-label" class="property-label"><g:message code="documentosProceso.proceso.label" default="Proceso" /></span>
            
            <span class="property-value" aria-labelledby="proceso-label">
                %{--<g:link controller="proceso" action="show" id="${documentosProcesoInstance?.proceso?.id}">--}%
                    ${documentosProcesoInstance?.proceso?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.tipoDocumentoProveedor}">
        <li class="fieldcontain">
            <span id="tipoDocumentoProveedor-label" class="property-label"><g:message code="documentosProceso.tipoDocumentoProveedor.label" default="Tipo Documento Proveedor" /></span>
            
            <span class="property-value" aria-labelledby="tipoDocumentoProveedor-label">
                %{--<g:link controller="tipoDocumentoProveedor" action="show" id="${documentosProcesoInstance?.tipoDocumentoProveedor?.id}">--}%
                    ${documentosProcesoInstance?.tipoDocumentoProveedor?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.tipoComprobanteId}">
        <li class="fieldcontain">
            <span id="tipoComprobanteId-label" class="property-label"><g:message code="documentosProceso.tipoComprobanteId.label" default="Tipo Comprobante Id" /></span>
            
            <span class="property-value" aria-labelledby="tipoComprobanteId-label">
                %{--<g:link controller="tipoComprobanteId" action="show" id="${documentosProcesoInstance?.tipoComprobanteId?.id}">--}%
                    ${documentosProcesoInstance?.tipoComprobanteId?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.documentosProcesoSerie01}">
        <li class="fieldcontain">
            <span id="documentosProcesoSerie01-label" class="property-label"><g:message code="documentosProceso.documentosProcesoSerie01.label" default="Documentos Proceso Serie01" /></span>
            
            <span class="property-value" aria-labelledby="documentosProcesoSerie01-label"><g:fieldValue bean="${documentosProcesoInstance}" field="documentosProcesoSerie01"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.documentosProcesoSerie02}">
        <li class="fieldcontain">
            <span id="documentosProcesoSerie02-label" class="property-label"><g:message code="documentosProceso.documentosProcesoSerie02.label" default="Documentos Proceso Serie02" /></span>
            
            <span class="property-value" aria-labelledby="documentosProcesoSerie02-label"><g:fieldValue bean="${documentosProcesoInstance}" field="documentosProcesoSerie02"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.secuencial}">
        <li class="fieldcontain">
            <span id="secuencial-label" class="property-label"><g:message code="documentosProceso.secuencial.label" default="Secuencial" /></span>
            
            <span class="property-value" aria-labelledby="secuencial-label"><g:fieldValue bean="${documentosProcesoInstance}" field="secuencial"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.autorizacionSRI}">
        <li class="fieldcontain">
            <span id="autorizacionSRI-label" class="property-label"><g:message code="documentosProceso.autorizacionSRI.label" default="Autorizacion SRI" /></span>
            
            <span class="property-value" aria-labelledby="autorizacionSRI-label"><g:fieldValue bean="${documentosProcesoInstance}" field="autorizacionSRI"/></span>
            
        </li>
    </g:if>
    
    <g:if test="${documentosProcesoInstance?.fecha}">
        <li class="fieldcontain">
            <span id="fecha-label" class="property-label"><g:message code="documentosProceso.fecha.label" default="Fecha" /></span>
            
            <span class="property-value" aria-labelledby="fecha-label"><g:formatDate date="${documentosProcesoInstance?.fecha}" /></span>
            
        </li>
    </g:if>
    
</ol>
