<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 10/10/12
  Time: 12:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Auxiliar por clientes</title>

        <style type="text/css">
        table {
            border-collapse : collapse;
            margin-bottom   : 15px;
        }
        </style>

    </head>

    <body>

        <g:each in="${cuentas}" var="cuenta">
            <h1>Cuenta contable: ${cuenta.cuenta.numero} ${cuenta.cuenta.descripcion}</h1>
            <g:each in="${cuenta.clientes}" var="cliente">
                <table border="1">
                    <thead>
                        <tr>
                            <th style="width: 105px;">Fecha</th>
                            <th style="width: 70px;">Trans.</th>
                            <th style="width: 70px;">Comp</th>
                            <th style="width: 70px;">Tipo</th>
                            <th style="width: 70px;">Doc</th>
                            %{--<th style="width: 70px;">Cheque</th>--}%
                            <th style="width: 70px;">Tipo</th>
                            <th style="width: 200px;">Descripción</th>
                            <th style="width: 80px;">Debe</th>
                            <th style="width: 80px;">Haber</th>
                            <th style="width: 80px;">Saldos</th>
                        </tr>
                        <tr>
                            <th colspan="10">
                                Persona: ${cliente.cliente.ruc} ${cliente.cliente.nombre ?: cliente.cliente.nombreContacto + " " + cliente.cliente.apellidoContacto}
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cliente.auxiliares}" var="auxiliar">
                            <tr>
                                <td>
                                    <g:formatDate date="${auxiliar.fechaRegistro}" format="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    **trans
                                </td>
                                <td>
                                    ${auxiliar.asiento.comprobante.numero}
                                </td>
                                <td>
                                    ${auxiliar.asiento.comprobante.tipo.descripcion}
                                </td>
                                <td>
                                    **doc
                                </td>
                                %{--<td>--}%
                                    %{--**cheque--}%
                                %{--</td>--}%
                                <td>
                                    ${auxiliar.tipoDocumento.descripcion}
                                </td>
                                <td>
                                    ${auxiliar.descripcion}
                                </td>
                                <td>
                                    <g:if test="${auxiliar.asiento.debe != 0}">
                                        ${auxiliar.haber}
                                    </g:if>
                                </td>
                                <td>
                                    <g:if test="${auxiliar.asiento.haber != 0}">
                                        ${auxiliar.haber}
                                    </g:if>
                                </td>
                                <td>
                                    <g:if test="${auxiliar.asiento.debe != 0}">
                                        ${auxiliar.haber}
                                    </g:if>
                                    <g:else>
                                        ${-auxiliar.haber}
                                    </g:else>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </g:each>
        </g:each>

    </body>
</html>