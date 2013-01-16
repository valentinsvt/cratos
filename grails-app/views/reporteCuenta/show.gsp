

<ol class="property-list reporteCuenta">
    
    <g:if test="${reporteCuentaInstance?.empresa}">
        <li class="fieldcontain">
            <span id="empresa-label" class="property-label"><g:message code="reporteCuenta.empresa.label" default="Empresa" /></span>
            
            <span class="property-value" aria-labelledby="empresa-label">
                %{--<g:link controller="empresa" action="show" id="${reporteCuentaInstance?.empresa?.id}">${reporteCuentaInstance?.empresa?.encodeAsHTML()}</g:link>--}%
                <g:fieldValue field="empresa" bean="${reporteCuentaInstance}"/>
            </span>
            
        </li>
    </g:if>
    
    <g:if test="${reporteCuentaInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="reporteCuenta.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${reporteCuentaInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
