

<ol class="property-list departamento">
    
    <g:if test="${departamentoInstance?.empresa}">
        <li class="fieldcontain">
            <span id="empresa-label" class="property-label"><g:message code="departamento.empresa.label" default="Empresa" /></span>
            
            <span class="property-value" aria-labelledby="empresa-label">

                <g:fieldValue bean="${departamentoInstance.empresa}" field="nombre">${departamentoInstance?.empresa?.nombre?.encodeAsHTML()} </g:fieldValue>
                %{--<g:link controller="empresa" action="show"--}%
           %{--id="${departamentoInstance?.empresa?.id}">${departamentoInstance?.empresa?.encodeAsHTML()}</g:link></span>--}%
            
        </li>
    </g:if>
    
    <g:if test="${departamentoInstance?.descripcion}">
        <li class="fieldcontain">
            <span id="descripcion-label" class="property-label"><g:message code="departamento.descripcion.label" default="Descripción" /></span>
            
            <span class="property-value" aria-labelledby="descripcion-label"><g:fieldValue bean="${departamentoInstance}" field="descripcion"/></span>
            
        </li>
    </g:if>
    
</ol>
