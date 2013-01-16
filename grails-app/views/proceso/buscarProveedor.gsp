<table style="width: 430px">
    <thead>
    <tr>
        <th></th>
        <th>RUC</th>
        <th>Nombre</th>
        <th>Tipo</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${provs}" var="p">
        <tr>
            <td>
                <a href="#" class="btn_bsc" id="${p.id}" ruc="${p.ruc}">Seleccionar</a>
            </td>
            <td>${p.ruc}</td>
            <td>${p.nombre}</td>
            <td>${p.tipoProveedor.descripcion}</td>
        </tr>
    </g:each>
    </tbody>

</table>

<script type="text/javascript">
    $(".btn_bsc").button({icons:{ primary:"ui-icon-check"},text:false}).click(function(){

        $("#prov").val($(this).attr("ruc"))
        $("#prov_id").val($(this).attr("id"))
        $("#dlgBuscar").dialog("close")
    });
</script>