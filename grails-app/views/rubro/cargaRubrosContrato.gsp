
<table style="width: 100%" >
    <thead>
    <tr>
        <th>Tipo</th>
        <th>Rubro</th>
        <th>Porcentaje</th>
        <th>Valor</th>
        <th>IESS</th>
        <th>Gravable</th>
        <th>Decimo</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${rubros}" var="r">
        <tr id="${r.id}" class="tr_rubro" rubro="${r.rubro.id}" porc="${r.porcentaje}" valor="${r.valor}" iess="${r.iess}" grav="${r.gravable}" dec="${r.decimo}" tipo="${r.rubro.tipoRubro.id}" >
            <td style="text-align: center">${r.rubro.tipoRubro.codigo}</td>
            <td>${r.rubro.descripcion}</td>
            <td style="text-align: right">${r.porcentaje}</td>
            <td  style="text-align: right">${r.valor}</td>
            <td style="text-align: center">${(r.iess=="1")?"Si":"No"}</td>
            <td  style="text-align: center">${(r.gravable=="1")?"Si":"No"}</td>
            <td  style="text-align: center">${(r.decimo=="1")?"Si":"No"}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    function cambia(){
//        console.log("cambia")
        $("#rubros").val($("#tipoRubro").attr("rubro"))
    }
    $(".tr_rubro").dblclick(function(){
        $("#tipoRubro").val($(this).attr("tipo"))
        $("#tipoRubro").attr("rubro",$(this).attr("rubro"))
        $("#tipoRubro").change()
        setTimeout(cambia,250);
        $("#rubro_id").val($(this).attr("id"))
        $("#rubro_porcentaje").val($(this).attr("porc"))
        $("#rubro_valor").val($(this).attr("valor"))
        $("#rubro_descripcion").val($(this).attr("desc"))

        var iess = $(this).attr("iess")
        var grav = $(this).attr("grav")
        var dec = $(this).attr("dec")
        if(iess*1==1){
            $("#rubro_iess").attr("checked","checked")
        }else {
            $("#rubro_iess").removeAttr("checked")
        }
        if(dec*1==1) {
            $("#rubro_decimo").attr("checked","checked")
        }else {
            $("#rubro_decimo").removeAttr("checked")
        }
        if(grav*1==1)
            $("#rubro_gravable").attr("checked","checked")
        else
            $("#rubro_gravable").removeAttr("checked")

    });
</script>