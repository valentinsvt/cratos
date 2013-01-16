<g:if test="${cuentas?.size()>0}">
    <table width="400px">
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th colspan="3"><center>Debe</center></th>
            <th colspan="3"><center>Haber</center></th>
            <th>&nbsp;</th>
        </tr>
        <tr>
            <th style="max-width: 250px;">C&oacute;digo(Comprobante)</th>

            <th>Porcentaje</th>
            <th>Impuestos</th>
            <th>Valor</th>

            <th>Porcentaje</th>
            <th>Impuestos</th>
            <th>Valor</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:set var="por" value="${0}" />
        <g:set var="imp" value="${0}" />
        <g:set var="val" value="${0}" />
        <g:set var="porH" value="${0}" />
        <g:set var="impH" value="${0}" />
        <g:set var="valH" value="${0}" />
        <g:each var="genera" in="${cuentas}" status="i">
            <g:if test="${genera.id}">
                <g:set var="gnra" value="${cratos.Genera.get(genera.id)}"></g:set>
                <g:set var="cuenta" value="${cratos.Cuenta.get(gnra.cuenta.id)}"></g:set>
            </g:if>
            <g:else>
                <g:set var="gnra" value="${genera}"></g:set>
                <g:set var="cuenta" value="${genera.cuenta}"></g:set>
            </g:else>
            <tr style="background-color: ${(genera.tipoComprobante.id==1)?'#D4E6FC':((genera.tipoComprobante.id==2)?'#99CC99':'#FFCC99')} !important; ">
            <td style="max-width: 250px;">${cuenta.numero+'('+cuenta.descripcion+')'}</td>
            <g:if test="${genera.debeHaber=='D'}">
                <td><input type="text" name="porcentaje" id="por_${i}" style="width: 62px;" value="${genera.porcentaje?:0}"/></td>
                <td><input type="text" name="impuestos" id="imp_${i}" style="width: 62px;" value="${genera.porcentajeImpuestos?:0}"/></td>
                <td><input type="text" name="valor" id="val_${i}" style="width: 62px;" value="${genera.valor?:0}"/></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                    <div  style="float: left; margin-right: 5px;" class="guardarDatos btnpq ui-state-default ui-corner-all" id="guardar_${i}" posicion="${i}" >
                        <span class="ui-icon ui-icon-circle-check"></span>
                    </div>
                    <div  style="float: left;" class="eliminar btnpq ui-state-default ui-corner-all" id="eliminar_${i}" posicion="${i}">
                        <span class="ui-icon ui-icon-circle-close"></span>
                    </div>
                </td>
                </tr>
                <g:set var="por" value="${por+genera.porcentaje?:0}" />
                <g:set var="imp" value="${imp+genera.porcentajeImpuestos?:0}" />
                <g:set var="val" value="${val+genera.valor?:0}" />
            </g:if>
            <g:else>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
                <td><input type="text" name="porcentaje" id="por_${i}" style="width: 62px;" value="${genera.porcentaje?:0}"/></td>
                <td><input type="text" name="impuestos" id="imp_${i}" style="width: 62px;" value="${genera.porcentajeImpuestos?:0}"/></td>
                <td><input type="text" name="valor" id="val_${i}" style="width: 62px;" value="${genera.valor?:0}"/></td>
                <td>
                    <div  style="float: left; margin-right: 5px;" class="guardarDatos btnpq ui-state-default ui-corner-all" id="guardar_${i}" posicion="${i}" >
                        <span class="ui-icon ui-icon-circle-check"></span>
                    </div>
                    <div  style="float: left;" class="eliminar btnpq ui-state-default ui-corner-all" id="eliminar_${i}" posicion="${i}">
                        <span class="ui-icon ui-icon-circle-close"></span>
                    </div>
                </td>
                <g:set var="porH" value="${porH+genera.porcentaje?:0}" />
                <g:set var="impH" value="${impH+genera.porcentajeImpuestos?:0}" />
                <g:set var="valH" value="${valH+genera.valor?:0}" />
            </g:else>
            </tr>
        </g:each>
        <tr style="background-color:white !important;">
            <td>TOTAL:</td>
            <td style="background-color: ${(por==porH)?'#d0ffd0':'#ffd0d0'};" >${por}</td>
            <td style="background-color: ${(imp==impH)?'#d0ffd0':'#ffd0d0'};">${imp}</td>
            <td style="background-color: ${(val==valH)?'#d0ffd0':'#ffd0d0'};">${val}</td>
            <td style="background-color: ${(por==porH)?'#d0ffd0':'#ffd0d0'};">${porH}</td>
            <td style="background-color: ${(imp==impH)?'#d0ffd0':'#ffd0d0'};">${impH}</td>
            <td style="background-color: ${(val==valH)?'#d0ffd0':'#ffd0d0'};">${valH}</td>
            <td></td>
        </tr>
        </tbody>
    </table>
</g:if>

<script type="text/javascript">
    $(function(){

        $(".btnpq").hover(
                function () {
                    $(this).addClass("ui-state-hover");
                },
                function () {
                    $(this).removeClass("ui-state-hover");
                }
        );

        $(".guardarDatos").click(function() {
            var por=$("#por_"+$(this).attr("posicion")).val()
            if(isNaN(por))
                por=0
            var val=$("#val_"+$(this).attr("posicion")).val()
            if(isNaN(val))
                val=0
            var imp=$("#imp_"+$(this).attr("posicion")).val()
            if(isNaN(imp))
                imp=0
            $.ajax({
                type: "POST",
                url: "${g.createLink(controller: 'gestorContable',action: 'agregarCuenta')}",
                data: "posicion="+$(this).attr("posicion")+"&por="+por+"&val="+val+"&imp="+imp,
                success: function(msg){
                    $("#agregarCuentas").html(msg);
                }
            });
        });

        $(".eliminar").click(function() {
            $.ajax({
                type: "POST",
                url: "${g.createLink(controller: 'gestorContable',action: 'agregarCuenta')}",
                data: "eliminar=true&posicion="+$(this).attr("posicion"),
                success: function(msg){
                    $("#agregarCuentas").html(msg);
                }
            });
        });

        function IsNumeric(inputVal) {
            if (isNaN(parseFloat(inputVal))) {
                return false;
            }
            return true
        }


    });
</script>