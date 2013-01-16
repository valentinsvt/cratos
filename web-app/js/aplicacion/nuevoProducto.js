$(function(){
    
    $("#productoSiguiente").click(function(){
        if($(".datosProducto").validate())
            $(".datosProducto").submit();
    });
   
    $("#agregarRef").click(function(){
        $(".datosRef").submit();
    });

    $("#eliminarRef").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
        $(".eliminar").submit();
    });
    $("#agregarDoc").click(function(){
        $(".datosDoc").submit();
    });

    $("#eliminarDoc").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
        $(".eliminar").submit();
    });
    $("#agregarInf").click(function(){
        $(".datosInf").submit();
    });

    $("#eliminarInf").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
        $(".eliminar").submit();
    });
     $("#agregarOp").click(function(){
        $(".datosOp").submit();
    });

    $("#eliminarOp").click(function(){
        $(".eliminar").val($(".eliminar").val()*1+1)
        $(".eliminar").submit();
    });
   

    $(".chkborrar").change(function(){

        var act = $("#num_eliminar").val()*1;
        var checked = $(this).is(":checked");
        if(checked) {
            $("#num_eliminar").val(act+1);
        }else{
            $("#num_eliminar").val(act+1);
        }
    });

});

