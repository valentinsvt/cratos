<html>
  <head>
    <title>Finix - Gestor Contable</title>
    <meta name="layout" content="main" />
  <g:javascript library="jquery"/>
  <g:includeJQuery archivo="buscarGestor" />
</head>
<body>

  <div id="summary"/>
<g:form name="gestorForm" action="nuevoGestor" method="post" class="frmGestor" >
  <input type="hidden" name="id" id="id" value="${gestor?.id}" />
  </g:form>
<div class="container entero ui-widget-content ui-corner-all">
  <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 5px; margin-left: 8px;">Gestor contable: ${gestor?.nombre}</h1>
  <g:toolbar id="toolbar">
    <g:grupoBtn>
      <a href="#" class="tbbtn fg-button ui-state-default fg-button-icon-left ui-corner-all" id="editarGestor">
          <span class="ui-icon ui-icon-pencil"></span><span>Editar</span>
        </a>
      

    </g:grupoBtn>
  </g:toolbar>
  
    <g:field tabla="gestorContable" name="nombre" campo="nombre" label="Nombre : " type="plain" value="${gestor?.nombre}" ></g:field>
    <g:field tabla="gestorContable" name="descripcion" campo="descripcion" label="Descripcion : " type="plain" value="${gestor?.descripcion}" ></g:field>
    <g:field tabla="gestorContable" name="estado" type="plain" campo="estado" label="Estado : " value="${(gestor.estado=='A')?'Activo':'Inactivo'}"/>
    <g:field tabla="gestorContable" name="observaciones" campo="observaciones" label="Observaciones : " type="plain" value="${gestor?.observaciones}" ></g:field>
    <br>
    <g:if test="${cuentas?.size()>0}">
      <div style="width: 800px;margin: auto;margin-bottom: 30px">
  <table width="400px">
    <thead>
      <tr>
	<th>&nbsp;</th>
	<th colspan="3"><center>Debe</center></th>
	<th colspan="3"><center>Haber</center></th>
      </tr>
      <tr>
	<th>C&oacute;digo(nombre)</th>

	<th>Porcentaje</th>
	<th>Impuestos</th>
	<th>Valor</th>

	<th>Porcentaje</th>
	<th>Impuestos</th>
	<th>Valor</th>
	
      </tr>
    </thead>
    <tbody>
    <g:set var="por" value="${0}" />
    <g:set var="imp" value="${0}" />
    <g:set var="val" value="${0}" />
    <g:set var="porH" value="${0}" />
    <g:set var="impH" value="${0}" />
    <g:set var="valH" value="${0}" />
    <g:each var="genera" in="${cuentas}" status="i">
      <tr>
        <td style="text-align: center">${genera.cuenta.numero+'('+genera.cuenta.descripcion+')'}</td>
      <g:if test="${genera.razon=='D'}">
	<td style="text-align: center">${genera.porcentaje?:0}</td>
	<td style="text-align: center">${genera.porcentajeImpuestos?:0}</td>
	<td style="text-align: center">${genera.valor?:0}</td>
	<td></td>
	<td></td>
	<td></td>
	
	</tr>
	<g:set var="por" value="${por+genera.porcentaje?:0}" />
	<g:set var="imp" value="${imp+genera.porcentajeImpuestos?:0}" />
	<g:set var="val" value="${val+genera.valor?:0}" />
      </g:if>
      <g:else>
	<td></td>
	<td></td>
	<td></td>
	<td style="text-align: center">${genera.porcentaje?:0}</td>
	<td style="text-align: center">${genera.porcentajeImpuestos?:0}</td>
        <td style="text-align: center">${genera.valor?:0}</td>
	
	<g:set var="porH" value="${porH+genera.porcentaje?:0}" />
	<g:set var="impH" value="${impH+genera.porcentajeImpuestos?:0}" />
	<g:set var="valH" value="${valH+genera.valor?:0}" />
      </g:else>
      </tr>
    </g:each>
    <tr>
      <td>TOTAL:</td>
      <td style="background-color: ${(por==porH)?'#d0ffd0':'#ffd0d0'};text-align: center" >${por}</td>
      <td style="background-color: ${(imp==impH)?'#d0ffd0':'#ffd0d0'};text-align: center">${imp}</td>
      <td style="background-color: ${(val==valH)?'#d0ffd0':'#ffd0d0'};text-align: center">${val}</td>
      <td style="background-color: ${(por==porH)?'#d0ffd0':'#ffd0d0'};text-align: center">${porH}</td>
      <td style="background-color: ${(imp==impH)?'#d0ffd0':'#ffd0d0'};text-align: center">${impH}</td>
      <td style="background-color: ${(val==valH)?'#d0ffd0':'#ffd0d0'};text-align: center">${valH}</td>
      
    </tr>
    </tbody>
  </table>
      </div>
</g:if>

</div>
</body>
</html>