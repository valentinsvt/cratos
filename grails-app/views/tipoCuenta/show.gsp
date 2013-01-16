

<ol class="property-list tipoCuenta">
    
    <g:if test="${tipoCuentaInstance?.tipoCuenta}">
        <li class="fieldcontain">
            <span id="tipoCuenta-label" class="property-label"><g:message code="tipoCuenta.tipoCuenta.label" default="Tipo Cuenta" /></span>
            
            <span class="property-value" aria-labelledby="tipoCuenta-label"><g:fieldValue bean="${tipoCuentaInstance}" field="tipoCuenta"/></span>
            
        </li>
    </g:if>
    
</ol>
