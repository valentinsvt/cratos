

<ol class="property-list tipoComprobanteId">
    
    <g:if test="${tipoComprobanteIdInstance?.tipoIdentificacion}">
        <li class="fieldcontain">
            <span id="tipoIdentificacion-label" class="property-label"><g:message code="tipoComprobanteId.tipoIdentificacion.label" default="Tipo Identificacion" /></span>
            
            <span class="property-value" aria-labelledby="tipoIdentificacion-label">
                %{--<g:link controller="tipoIdentificacion" action="show" id="${tipoComprobanteIdInstance?.tipoIdentificacion?.id}">--}%
                    ${tipoComprobanteIdInstance?.tipoIdentificacion?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${tipoComprobanteIdInstance?.tipoComprobanteSri}">
        <li class="fieldcontain">
            <span id="tipoComprobanteSri-label" class="property-label"><g:message code="tipoComprobanteId.tipoComprobanteSri.label" default="Tipo Comprobante Sri" /></span>
            
            <span class="property-value" aria-labelledby="tipoComprobanteSri-label">
                %{--<g:link controller="tipoComprobanteSri" action="show" id="${tipoComprobanteIdInstance?.tipoComprobanteSri?.id}">--}%
                    ${tipoComprobanteIdInstance?.tipoComprobanteSri?.encodeAsHTML()}
                %{--</g:link>--}%
            </span>
            
        </li>
    </g:if>
    
</ol>
