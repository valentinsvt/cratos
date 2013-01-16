<%@ page import="cratos.seguridad.Prfl" %>


<g:hiddenField name="id" value="${prflInstance?.id}"/>
<g:hiddenField name="version" value="${prflInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'descripcion', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="descripcion">
                Descripcion
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="descripcion" value="${prflInstance?.descripcion}" title="${Prfl.constraints.descripcion.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'nombre', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="nombre">
                Nombre
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="nombre" value="${prflInstance?.nombre}" title="${Prfl.constraints.nombre.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'observaciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="observaciones" value="${prflInstance?.observaciones}" title="${Prfl.constraints.observaciones.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'padre', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="padre">
                Padre
            </label>
        </div>

        <div class="span-19">
            <g:select id="padre" name="padre.id" from="${cratos.seguridad.Prfl.list()}" optionKey="id" required="" value="${prflInstance?.padre?.id}" class="field  requiredCmb required  many-to-one ui-corner-all" title="${Prfl.constraints.padre.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'perfiles', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="perfiles">
                Perfiles
            </label>
        </div>

        <div class="span-19">
            
<ul class="one-to-many">
<g:each in="${prflInstance?.perfiles?}" var="p">
    <li><g:link controller="prfl" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="prfl" action="create" params="['prfl.id': prflInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'prfl.label', default: 'Prfl')])}</g:link>
</li>
</ul>

            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: prflInstance, field: 'permisos', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="permisos">
                Permisos
            </label>
        </div>

        <div class="span-19">
            
<ul class="one-to-many">
<g:each in="${prflInstance?.permisos?}" var="p">
    <li><g:link controller="prms" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="prms" action="create" params="['prfl.id': prflInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'prms.label', default: 'Prms')])}</g:link>
</li>
</ul>

            
        </div>
    </div>
    
</div>