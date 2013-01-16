<%@ page import="cratos.Persona" %>


<g:hiddenField name="id" value="${personaInstance?.id}"/>
<g:hiddenField name="version" value="${personaInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="email">
                Email
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="email" maxlength="63" value="${personaInstance?.email}" title="${Persona.constraints.email.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="telefono">
                Telefono
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="telefono" maxlength="63" value="${personaInstance?.telefono}" title="${Persona.constraints.telefono.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'direccionReferencia', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="direccionReferencia">
                Direccion Referencia
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="direccionReferencia" maxlength="127" value="${personaInstance?.direccionReferencia}" title="${Persona.constraints.direccionReferencia.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'barrio', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="barrio">
                Barrio
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="barrio" maxlength="127" value="${personaInstance?.barrio}" title="${Persona.constraints.barrio.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'direccion', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="direccion">
                Direccion
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="direccion" maxlength="127" value="${personaInstance?.direccion}" title="${Persona.constraints.direccion.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'fechaNacimiento', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fechaNacimiento">
                Fecha Nacimiento
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker class="field ui-corner-all"  title="${Persona.constraints.fechaNacimiento.attributes.title}" name="fechaNacimiento" title="Fecha de Nacimiento" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'discapacitado', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="discapacitado">
                Discapacitado
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="discapacitado" maxlength="1" value="${personaInstance?.discapacitado}" title="${Persona.constraints.discapacitado.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'sexo', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="sexo">
                Sexo
            </label>
        </div>

        <div class="span-19">
            <g:select class="field  required  ui-corner-all" name="sexo" maxlength="1" required=""  value="${personaInstance?.sexo}" title="${Persona.constraints.sexo.attributes.title}"  from="${Persona.constraints.sexo.attributes}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="apellido">
                Apellido
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="apellido" maxlength="31" required="" value="${personaInstance?.apellido}" title="${Persona.constraints.apellido.attributes.title}" />
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="nombre">
                Nombre
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="nombre" maxlength="31" required="" value="${personaInstance?.nombre}" title="${Persona.constraints.nombre.attributes.title}" />
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'cedula', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="cedula">
                Cedula
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  required  ui-corner-all" name="cedula" maxlength="10" required="" value="${personaInstance?.cedula}" title="${Persona.constraints.cedula.attributes.title}" />
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'empresa', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="empresa">
                Empresa
            </label>
        </div>

        <div class="span-19">
            <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" value="${personaInstance?.empresa?.id}" class="field  many-to-one ui-corner-all" title="${Persona.constraints.empresa.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'nacionalidad', 'error')} required">
        <div class="span-3 prepend-1">
            <label for="nacionalidad">
                Nacionalidad
            </label>
        </div>

        <div class="span-19">
            <g:select id="nacionalidad" name="nacionalidad.id" from="${cratos.Nacionalidad.list()}" optionKey="id" required="" value="${personaInstance?.nacionalidad?.id}" class="field  requiredCmb required  many-to-one ui-corner-all" title="${Persona.constraints.nacionalidad.attributes.title}"/>
            <span class="required-indicator">*</span>
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'profesion', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="profesion">
                Profesion
            </label>
        </div>

        <div class="span-19">
            <g:select id="profesion" name="profesion.id" from="${cratos.Profesion.list()}" optionKey="id" value="${personaInstance?.profesion?.id}" class="field  many-to-one ui-corner-all" title="${Persona.constraints.profesion.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'estadoCivil', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="estadoCivil">
                Estado Civil
            </label>
        </div>

        <div class="span-19">
            <g:select id="estadoCivil" name="estadoCivil.id" from="${cratos.EstadoCivil.list()}" optionKey="id" value="${personaInstance?.estadoCivil?.id}" class="field  many-to-one ui-corner-all" title="${Persona.constraints.estadoCivil.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: personaInstance, field: 'observaciones', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="observaciones">
                Observaciones
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="observaciones" maxlength="127" value="${personaInstance?.observaciones}" title="${Persona.constraints.observaciones.attributes.title}" />
            
        </div>
    </div>
    
</div>