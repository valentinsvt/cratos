<table width="400px">
  <thead>
    <tr>
      <th>C&oacute;digo</th>
      <th>Nombre</th>
      <th>Nivel</th>
      <th>Debe/Haber</th>
      <th>Agregar</th>
    </tr>
  </thead>
  <tbody>
  <g:if test="${planCuentas != null}">
    <g:each var="cuenta" in="${planCuentas}">
      <tr>
	<td>${cuenta.numero}</td>
	<td>${cuenta.descripcion}</td>
	<td>${cuenta.nivel.descripcion}</td>
        <td><select class="span-3 ui-widget-content ui-corner-all" name="razon" id="${'dh_'+cuenta.id}" >
	  <option id="1">Debe</option>
	  <option id="0">Haber</option>
	</select></td>
         <td >
          <div style="width: 70px; text-align: center" class="agregarCuenta fg-button ui-state-default  ui-corner-all " id="agregar_${cuenta.numero}" cuenta="${cuenta.id}" >Agregar</div>
      </tr>
    </g:each>
  </g:if>
</tbody>
</table>


<script type="text/javascript">
  $(function(){
  $(".agregarCuenta").click(function() {
		   
			$.ajax({
			    type: "POST",
			    url: "${g.createLink(controller: 'gestorContable',action: 'agregarCuenta')}",
			    data: "id="+$(this).attr("cuenta")+"&razon="+$("#dh_"+$(this).attr("cuenta")).val()+"&tc="+$("#tipo").val(),
			    success: function(msg){
				$("#agregarCuentas").html(msg)
			    }
			});
		    
		});
});
</script>