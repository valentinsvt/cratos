<%@ page import="cratos.seguridad.Sesn" %>


<g:hiddenField name="id" value="${sesnInstance?.id}"/>
<g:hiddenField name="version" value="${sesnInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: sesnInstance, field: 'perfil', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="perfil">
                Perfil
            </label>
        </div>

        <div class="span-19">
            <g:select id="perfil" name="perfil.id" from="${cratos.seguridad.Prfl.list()}" optionKey="id" required="" value="${sesnInstance?.perfil?.id}" class="field  requiredCmb required  many-to-one ui-corner-all" title="${Sesn.constraints.perfil.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: sesnInstance, field: 'usuario', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="usuario">
                Usuario
            </label>
        </div>

        <div class="span-19">
            <g:select id="usuario" name="usuario.id" from="${cratos.seguridad.Usro.list()}" optionKey="id" required="" value="${sesnInstance?.usuario?.id}" class="field  requiredCmb required  many-to-one ui-corner-all" title="${Sesn.constraints.usuario.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
</div>