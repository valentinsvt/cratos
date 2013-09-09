<div style="width: 100%;height: 40px;margin-bottom: 10px;background-color: #C3D9FF;padding: 5px" class="ui-corner-all">
    Recuerde conservar el signo de los valores y utilizar el botón
    <div style="width: 18px;display: inline-block" class=" btnpq ui-state-default ui-corner-all">
        <span class="ui-icon ui-icon-circle-check"></span>
    </div>
    para guardar los cambios de cada rubro.
</div>
<table style="width: 100%;">
    <thead>
    <tr>
        <th>Rubro</th>
        <th>Tipo</th>
        <th>Valor</th>
        <g:if test="${rol.estado!='R'}">
            <th style="width: 15px;"></th>
            <th style="width: 15px;"></th>
        </g:if>
    </tr>
    </thead>
    <tbody>
    <g:set var="total" value="${0}"></g:set>
    <g:each in="${detalle}" var="d">
        <tr>
            <g:if test="${d.rubroTipoContrato}">
                <td>${d.rubroTipoContrato.rubro.descripcion}</td>
                <td>${d.rubroTipoContrato.rubro.tipoRubro}</td>
            </g:if>
            <g:else>
                <g:if test="${d.descripcion}">
                    <td>${d.descripcion}</td>
                </g:if>
                <g:else>
                    <td>SUELDO</td>
                </g:else>
                <td></td>
            </g:else>
            <g:if test="${rol.estado=='R'}">
                <td style="text-align: right">${d.valor}</td>
            </g:if>
            <g:else>
                <td style="text-align: right"><input type="text" style="width: 80px;text-align: right" class="rubro" id="d_${d.id}" value="${d.valor}" valor="${d.valor}"></td>
                <td style="width: 15px;text-align: center">
                    <div style="float: left; margin: auto" class="guardarDatos btnpq ui-state-default ui-corner-all" detalle="${d.id}" title="Guardar">
                        <span class="ui-icon ui-icon-circle-check"></span>
                    </div>
                </td>
                <td style="width: 15px;text-align: center">
                    <div style="float: left; margin: auto" class="borrar btnpq ui-state-default ui-corner-all" detalle="${d.id}" title="Eliminar">
                        <span class="ui-icon ui-icon-trash"></span>
                    </div>
                </td>
            </g:else>
            <g:set var="total" value="${(total.toDouble())+d.valor}"></g:set>
        </tr>
    </g:each>
    <tr>
        <td colspan="2"><b>TOTAL</b></td>
        <td style="text-align: right;font-weight: bold" class="detalle_total">${total.toDouble().round(2)}</td>
    </tr>
    </tbody>
</table>
<g:if test="${rol.estado!='R'}">
    <fieldset style="width: 90%;height: 50px;margin-bottom: 10px;" class="ui-corner-all">
        <legend style="font-size: 12px;">Agregar Rubro</legend>
        <input type="hidden" id="emp" value="${emp?.id}">
        <div style="height: 25px;line-height: 25px">
            <b> Descripcion:</b>
            <input type="text" style="width: 150px" id="desc">
            <b> Valor:</b>
            <input type="text" style="width: 60px" id="val">
            <a href="#" id="agregarRubro">Agregar</a>
        </div>
    </fieldset>
</g:if>
<script type="text/javascript">

    $("#agregarRubro").button().click(function(){
        var desc = $("#desc").val()
        var val = $("#val").val()
        var emp = $("#emp").val()
        var msg = ""
        if(desc.trim().length>120)
            msg="La descripción no puede tener mas de 120 caracteres"
        if(isNaN(val))
            msg="El valor debe ser un número."
        if(msg==""){
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'addDetalle')}",
                data    : "emp="+emp+"&desc="+desc+"&val="+val+"&rol=${rol?.id}",
                success : function (msg) {
                    if(msg=="ok"){
                        $.ajax({
                            type    : "POST",
                            url     : "${g.createLink(controller: 'rubro',action: 'getDetalle')}",
                            data    : "rol=${rol?.id}&emp="+emp,
                            success : function (msg) {
                                $("#control").val("1")
                                $("#dlg-rol").html(msg)
                            }
                        });
                    }

                }
            });
        }else{
            alert(msg)
        }

    }) ;

    $(".guardarDatos").click(function(){
        var valor = $("#d_"+$(this).attr("detalle")).val()
        var txt = $("#d_"+$(this).attr("detalle"))
        var msg=""
        if(isNaN(valor)){
            msg="El campo valor debe ser un número"
            alert(msg)
        }else{
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'saveDetalle')}",
                data    : "detalle="+$(this).attr("detalle")+"&valor="+valor,
                success : function (msg) {
//                     console.log($("#d_"+$(this).attr("detalle")))
                    var total=0
                    $(".rubro").each(function(){
                        var v =  $(this).val()
                        if(isNaN(v)){
                            v= $(this).attr("valor")
                            $(this).val($(this).attr("valor")*1)
                        }
                        v=v*1
                        total+=v
                    });
                    if(total!=$(".detalle_total").html()*1)
                        $("#control").val("1")
                    $(".detalle_total").html(number_format (total, 2, ".", ""))
                    txt.css("background","rgba(225, 242, 182,0.6)")

                }
            });
        }
    });
    $(".borrar").click(function(){
        if(confirm("Esta seguro?")){
            var elem = $(this)
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'deleteDetalle')}",
                data    : "detalle="+$(this).attr("detalle"),
                success : function (msg) {
                    if(msg=="ok"){
                        elem.parent().parent().remove()
                        var total=0
                        $(".rubro").each(function(){
                            var v =  $(this).val()
                            if(isNaN(v)){
                                v= $(this).attr("valor")
                                $(this).val($(this).attr("valor")*1)
                            }
                            v=v*1
                            total+=v
                        });
                        if(total!=$(".detalle_total").html()*1)
                            $("#control").val("1")
                        $(".detalle_total").html(number_format (total, 2, ".", ""))
                        txt.css("background","rgba(225, 242, 182,0.6)")
                    }else{
                        alert("Ha ocurrido un error")
                    }


                }
            });
        }
    })

</script>