<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
    <tr>

        <th>RUC</th>
        <th>Nombre Contacto</th>
        <th>Apellido Contacto</th>
        <th>Nombre</th>
        <th>Dirección</th>
        <th>Teléfono</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${resultado}" var="r">

        <tr class="proveedor" id="${r.id}">
            <td class="ruc" id="ruc">${r.ruc}</td>
            <td class="nombreContacto" id="nombreContacto">${r.nombreContacto}</td>
            <td class="apellidoContacto" id="apellidoContacto">${r.apellidoContacto}</td>
            <td class="nombre" id="nombre">${r.nombre}</td>
            <td class="direccion" id="direccion">${r.direccion}</td>
            <td class="telefono" id="telefono">${r.telefono}</td>

        </tr>

    </g:each>

    </tbody>
</table>

<script type="text/javascript">

    $(function () {
        $(".proveedor").hover(
                function () {
                    $(this).addClass("hover");
                },
                function () {
                    $(this).removeClass("hover");
                }).click(function () {
                    var tr = $(this);

                    var nombreContacto = tr.find(".nombreContacto").text();
                    var apellido = tr.find(".apellidoContacto").text();
                    var direccion = tr.find(".direccion").text();
                    var telefono = tr.find(".telefono").text();
                    var ruc = tr.find(".ruc").text();

                    $("#ci").val($.trim(ruc));
                    $("#nombre").val(nombreContacto);
                    $("#apellido").val(apellido);
                    $("#direccion").val(direccion);
                    $("#telefono").val(telefono);
                    $("#dlgBuscarCliente").dialog("close");

                });
    });
</script>


