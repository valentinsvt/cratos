<%@ page import="cratos.DetalleAdquisicion; cratos.Adquisiciones" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Revisar Adquisición</title>


    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/plugins/contextMenu', file: 'jquery.contextMenu.css')}"
          type="text/css">

    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript"
            src="${resource(dir: 'js/jquery/plugins/jquery-validation-1.9.0', file: 'messages_es.js')}"></script>

</head>

<body>

<g:if test="${flash.message}">
    <div class="message ${flash.clase}" role="status"><span
            class="ss_sprite ${flash.ico}">&nbsp;</span>${flash.message}
    </div>
</g:if>
<th>
    <div style="width: 450px; padding-left: 250px; font-weight: bold;" align="center">REVISAR ADQUISICIONES</div>
</th>
<fieldset %{--style="width: 650px"--}%>
    <g:form class="frmRevisar" name="frmRevisar" action="estadoDetalles">

        <table>

            <thead>
            <th style="width: 100px" align="center">
                Cantidad

            </th>

            <th style="width: 100px" align="center">

                Código
            </th>

            <th style="width: 400px" align="center">

                Producto
            </th>
            <th style="width: 100px" align="center">
                Recibidos
                %{--<g:checkBox name="marcarTodos" id="marcarTodos" title="Marcar Todos"/>--}%

            </th>

            <g:hiddenField name="id" value="${adquisicionesInstance.id}"/>

            </thead>

            <tbody>
            <g:each in="${cratos.DetalleAdquisicion.findAllByAdquisiciones(adquisicionesInstance).sort()}" var="item" >
                <tr>
                    <td>

                        ${item.cantidad}
                    </td>
                    <td >

                        ${item.item.codigo}


                    </td>
                    <td>
                        ${item.item.nombre}

                    </td>
                    <td align="right">

                         <input type="checkbox" class="revisar" name="revisar" value="${item.id}" ${item.estado == '1'? 'checked' : ''} />

                   </td>

                </tr>

            </g:each>
            </tbody>

        </table>
    </g:form>
    <div id="dlgLoad" class="ui-helper-hidden" style="text-align:center;">
        Cargando.....Por favor espere......<br/><br/>
        <img src="${resource(dir: 'images', file: 'spinner64.gif')}" alt=""/>
    </div>

    <div class="ui-widget-header buttons botones">

        <a href="#" class="btnDesmarcar">Desmarcar Todos</a>
        <a href="#" class="btnMarcar">Marcar Todos</a>
        <a href="#" class="btnGuardar">Guardar</a>

    </div>
</fieldset>

<script type="text/javascript">




    $(".btnMarcar").button({

        icons:{

            primary:"ui-icon-check"

        }

    }).click(function () {


                $(".revisar").attr("checked", true);

                $(".revisar").each(function () {



                    ${adquisicionesInstance.estado = '1'}

                    console.log(${adquisicionesInstance.estado})

                });


            });

    $(".btnDesmarcar").button({

        icons:{

            primary:"ui-icon-note"

        }


    }).click(function () {


                $(".revisar").attr("checked", false);

                $(".revisar").each(function () {


                    ${adquisicionesInstance.estado = '0'};
                    console.log(${adquisicionesInstance.estado});


                });

            });

    $(".btnGuardar").button({
        icons:{
            primary:"ui-icon-check"
        }
    }).click(function () {

                $("#frmRevisar").submit();

            });





</script>

</body>
</html>