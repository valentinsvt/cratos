<g:select name="rubros" id="rubros" from="${rubros}" optionKey="id" optionValue="descripcion" noSelection="['-1':'Seleccione...']"></g:select>
<script type="text/javascript">
    $("#rubros").change(function(){
        if($(this).val()!="-1"){
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'rubro',action: 'getDatosRubro')}",
                data    : "id=" +$("#rubros").val(),
                success : function (msg) {
                    var datos = msg.split(";")

                    $("#rubro_porcentaje").val(datos[1])
                    $("#rubro_valor").val(datos[0])
                    if(datos[2]=="1")
                        $("#rubro_iess").attr("checked","checked")
                    else
                        $("#rubro_iess").removeAttr("checked")
                    if(datos[3]=="1")
                        $("#rubro_gravable").attr("checked","checked")
                    else
                        $("#rubro_gravable").removeAttr("checked")
                    if(datos[4]=="1")
                        $("#rubro_decimo").attr("checked","checked")
                    else
                        $("#rubro_decimo").removeAttr("checked")

                }
            });
        }else{

            $("#rubro_porcentaje").val("")
            $("#rubro_valor").val("")

            $("#rubro_iess").removeAttr("checked")

            $("#rubro_gravable").removeAttr("checked")

            $("#rubro_decimo").removeAttr("checked")
        }

    });
</script>