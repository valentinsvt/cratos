<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestor contable</title>
  </head>
  <body>


    <table border="0" class="table hover">
      <g:if test="${lista.size()>0}">
	<thead>
	  <tr>
	    <th>
              Nombre
	    </th>
	    <th>
	      Descripcion
	    </th>
	    <th>
	      Observaciones
	    </th>

	  </tr>
	</thead>
	<tbody>

	<g:each var="gestor" in="${lista}">
	  <tr>
	    <td><g:link action="verGestor" id="${gestor.id}" title="Click para ver la informaci&oacute;n completa">${gestor.nombre}</g:link></td>
	    <td>${gestor.descripcion}</td>
	    <td>${gestor.observaciones}</td>
	  </tr>
	</g:each>
	</tbody>

      </g:if>
      <g:else>
	<tr>
	  <td>No se encontraron gestores</td>
	</tr>
      </g:else>
    </table>

  </body>
</html>
