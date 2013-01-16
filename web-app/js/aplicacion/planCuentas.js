$(function() {



    $("#numero").blur(function() {
        $.ajax({
            type: "POST",
            url: "validarCodigo",
            data: "numero="+$(this).val(),
            success: function(msg){
                var clase = "", msj = "";
                if(msg.substring(0,2)!="ok") {
                    $("#msjNum") .html( msg);
                    clase = "invalid ui-state-error";
                    $("#numero").focus();
                    $("#msjNum").show("pulsate")
                    $("#validarNumero").val(0)
                    $("[name=cuentaPadreTxt]").val("")
                    $("[name=nivelTxt]").val("")
                    $("[name=cuentaPadre.id]").val(null)
                    $("[name=nivel]").val(null)
                }else{
                    var ar=msg.split("/")
                    $("[name=cuentaPadreTxt]").val(ar[1])
                    $("[name=nivelTxt]").val(ar[2])
                    $("[name=cuentaPadre.id]").val(ar[3])
                    $("[name=nivel]").val(ar[4])
                    $('.resto').attr('disabled', false);
                    $("#msjNum").hide("slide")
                    $("#validarNumero").val(1)
                }
            }
        });
    });

    $("#movimiento").change(function() {
        if($(this).is(":checked")) {
            $(".esconde").show();
        } else {
            $(".esconde").hide();
        }
    });
    $("#guardarCuenta").click(function() {
        if($("#validarNumero").val()=="1"){
            if($(".planDeCuentas").validate())
                $(".planDeCuentas").submit();
        }else{
            $("#msjNum").show("pulsate");
        }
    });

});