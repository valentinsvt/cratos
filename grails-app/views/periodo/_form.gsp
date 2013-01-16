<%@ page import="cratos.Periodo" %>


<g:hiddenField name="id" value="${periodoInstance?.id}"/>
<g:hiddenField name="version" value="${periodoInstance?.version}"/>
<div class="container">
    
    <div class="span-24 ${hasErrors(bean: periodoInstance, field: 'fechaFin', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fechaFin">
                Fecha Fin
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker class="field ui-corner-all"  title="${Periodo.constraints.fechaFin.attributes.title}" name="fechaFin" title="fechaFin" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: periodoInstance, field: 'fechaInicio', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="fechaInicio">
                Fecha Inicio
            </label>
        </div>

        <div class="span-19">
            <elm:datePicker class="field ui-corner-all"  title="${Periodo.constraints.fechaInicio.attributes.title}" name="fechaInicio" title="fechaInicio" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: periodoInstance, field: 'numero', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="numero">
                Numero
            </label>
        </div>

        <div class="span-19">
            <g:textField class="field  ui-corner-all" name="numero" value="${periodoInstance?.numero}" title="${Periodo.constraints.numero.attributes.title}" />
            
        </div>
    </div>
    
    <div class="span-24 ${hasErrors(bean: periodoInstance, field: 'contabilidad', 'error')} ">
        <div class="span-3 prepend-1">
            <label for="contabilidad">
                Contabilidad
            </label>
        </div>

        <div class="span-19">
            <g:select id="contabilidad" name="contabilidad.id" from="${cratos.Contabilidad.list()}" optionKey="id" value="${periodoInstance?.contabilidad?.id}" class="field  many-to-one ui-corner-all" title="${Periodo.constraints.contabilidad.attributes.title}" noSelection="['null': '']"/>
            
        </div>
    </div>
    
</div>