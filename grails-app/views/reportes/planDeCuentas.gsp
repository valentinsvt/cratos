
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Plan de cuentas</title>
    <style type="text/css">
        .even {background:#fff;}
        .odd  {background:#ddd}
    </style>

</head>
<body>
   %{--<th>--}%
   %{--<div style="width:  600px" align="center" ></div>--}%
   %{--</th>--}%
<th>
   <div style="width: 650px" align="center">PLAN DE CUENTAS</div>
</th>
 <table>
     <thead>

     <th style="width: 100px" align="center">
         Numero
     </th>
      <th style="width: 100px" align="center">
         Padre
     </th>
     <th style="width:50px" align="center">
         Nivel
     </th>
     <th style="width: 100px" align="center">
         Descripcion
     </th>

       </thead>
     <tbody>
     <g:each in="${cuentas}" var="cuenta" status="i">
         <tr class="${i%2 == 0 ? 'even': 'odd'}">
             <td>
                 ${cuenta.numero}
             </td>
             <td>
                 ${cuenta.padre?.numero}
             </td>
             <td align="center">
                 ${cuenta.nivel.id}
             </td>
             <td>
                 ${cuenta.descripcion}
             </td>

         </tr>

     </g:each>

    


     </tbody>
 </table>

</body>
</html>