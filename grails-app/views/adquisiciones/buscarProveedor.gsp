<table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
        <tr>
            <th>Nombre</th>
            <th>Nombre Contacto</th>
            <th>Apellido Contacto</th>
            <th>RUC</th>
        </tr>
    </thead>
    <tbody>
        <g:each in="${results}" var="r">
            <tr class="proveedor" id="${r.id}">
                <td class="nombre" id="nombre">${r.nombre}</td>
                <td class="nombreContacto" id="nombreContacto">${r.nombreContacto}</td>
                <td class="apellidoContacto" id="apellidoContacto">${r.apellidoContacto}</td>
                <td class="ruc" id="ruc">${r.ruc}</td>

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
                    var proveedorId = tr.attr("id");
                    var ruc = $.trim(tr.find(".ruc").text());
                    var nombre = $.trim(tr.find(".nombre").text());
                    var nombreContacto = $.trim(tr.find(".nombreContacto").text()) + " " + $.trim(tr.find(".apellidoContacto").text());

                    var str = ruc;
                    if (nombre != "") {
                        str += " - " + nombre;
                    } else if (nombreContacto) {
                        str += " - " + nombreContacto;
                    }

                    $("#proveedor").val(str);
                    $("#proveedorHidden").val(proveedorId);
//                    $("#form-adquisiciones").valid();, usuario:Usfasdu
                    $("#dlgBuscarPro").dialog("close");

                });
    });
</script>


