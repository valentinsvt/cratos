<%@ page import="cratos.Canton" %>


<g:hiddenField name="id" value="${cantonInstance?.id}"/>
<g:hiddenField name="version" value="${cantonInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: cantonInstance, field: 'nombre', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="nombre">
                Nombre
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="nombre" maxlength="60" required="" value="${cantonInstance?.nombre}" title="${Canton.constraints.nombre.attributes.title}" />
            <span class="required-indicator">*</span>
        </div>
    </div>
    
</div>