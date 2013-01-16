<g:form action="grabar" method="post">
    <!-- <div style="height: 400px; overflow: auto;"> -->
    <input type="hidden" id="mdlo__id" value="${mdlo__id}">
    <input type="hidden" id="tpac__id" value="${mdlo__id}">
    <g:if test="${datos?.size()>0}">
        <div class="ui-corner-all" style="height: 440px; overflow:auto; margin-bottom: 5px; margin-left: -20px; background-color: #efeff8;
             border-style: solid; border-color: #AAA; border-width: 1px; ">
            <table border="0" cellpadding="0" width="800px">
                <thead style="color: #101010; background-color: #69b0d3">
                <tr>
                    <th style="padding:4px;" width="100px">Permisos</th>
                    <th "width="150px">Menú</th>
                    <th "width="300px">Accion</th>
                    <th "width="200px">Controlador</th>
                </tr>
                </thead>
                <tbody>
                <!-- <hr>Hola ${lista}</hr> -->
                <g:each in="${datos}" status="i" var="d">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="background: ${(d[4]) ? '#7cf' : ''}">
                        <td><input type="checkbox" name="cdgo" class="ndm chkAccn"
                                   value="${d[0].encodeAsHTML()}" ${(d[4]) ? 'checked' : ''}></td>
                        <td>${d[1]?.encodeAsHTML()}</td>
                        <td>${d[2]?.encodeAsHTML()}</td>
                        <td>${d[3]?.encodeAsHTML()}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </g:if>
    <input id="aceptaAJX" type="button" class="grabaPrms" value="Fijar permisos del Menú">
</g:form>

<script type="text/javascript">
    $(document).ready(function() {
        $("#aceptar").click(function() {
            alert("ohhhhh")
        });

    });

    $("#aceptaAJX").button().click(function() {
        if (confirm("Actualizar los permisos.. \n Seguro??")) {
            var data = armarAccn()
            //alert("armado: " + data);
            $.ajax({
                type: "POST", url: "../grabar",
                data: "&ids=" + data + "&tpac=" + $('#tpac__id').val() + "&prfl=" + $('#perfil').val(),
                success: function(msg) {
                    $("#ajx").html(msg)
                }
            });
        }
    });

    function armarAccn() {
        var datos = new Array()
        $('.chkAccn:checked').each(
                function() {
                    datos.push($(this).val());
                }
        )
        datos += "&menu=" + $('#mdlo__id').val() + "&grabar=S"
        return datos
    }
    ;



</script>