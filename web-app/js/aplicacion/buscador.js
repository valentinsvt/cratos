

$("#buscar").click(function() {
    var w = screen.width
    var l = w/2-(460)
    $(".buscador").dialog('open')
    $(".buscador").dialog({
        position:[l,30]
    })

});
$(".buscador").dialog({
    autoOpen: false,
    resizable:true,
    draggable: true ,
    width:900,
    title: 'Buscador',
    modal:true,
    position: 'center',
    buttons:{
//        "Rerporte":function(){
//            if($("#tablaBuscador").html()){
//                var data = "";
//                $(".crit").each(function(){
//                    data+="&campos="+$(this).attr("campo");
//                    data+="&operadores="+$(this).attr("operador");
//                    data+="&criterios="+$(this).attr("criterio");
//                });
//                if(data.length<2){
//                    data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()
//                }
//                data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();
//
//                var div = $("#tablaBuscador").parent()
//                //console.log(headers)
//                location.href =div.attr("url")+"?"+data+"&reporte=1"
//            }
//
//        },
        "Cerrar":function(){
            $(".buscador").dialog("close")
        }
    }
});
$("#btn_reporte").button().click(function(){
    if($("#tablaBuscador").html()){
        var data = "";
        $(".crit").each(function(){
            data+="&campos="+$(this).attr("campo");
            data+="&operadores="+$(this).attr("operador");
            data+="&criterios="+$(this).attr("criterio");
        });
        if(data.length<2){
            data="tc="+$("#tipoCampo").val()+"&campos="+$("#campo :selected").val()+"&operadores="+$("#operador :selected").val()+"&criterios="+$("#criterio").val()
        }
        data+="&ordenado="+$("#campoOrdn :selected").val()+"&orden="+$("#orden :selected").val();

        var div = $("#tablaBuscador").parent()
        //console.log(headers)
        location.href =div.attr("url")+"?"+data+"&reporte=1"
    }

});

$("#campo").change(function() {
    cambiaOperador()
});
$("#reset").button({
    icons:{
        primary:"ui-icon-arrowrefresh-1-w"
    },
    text:false
}).click(function(){
        $(".crit").remove()
    });

$("#mas").unbind()
$("#mas").button({
    icons:{
        primary:"ui-icon-plusthick"
    },
    text:false
}).bind("click",function(){
        var tipoCampo=$("#tipoCampo")
        var campo = $("#campo :selected")
        var operador = $("#operador :selected")
        var criterio = $("#criterio")
        var div =$("<div>")
        div.html(campo.text()+" "+operador.text()+" a '"+criterio.val()+"'").addClass("crit ui-corner-all")
        div.attr("campo",campo.val()).attr("operador",operador.val()).attr("criterio",criterio.val())
        div.css({float:"left",height:"25px",minWith :"60px",background:"rgba(248, 192, 60,0.5)",lineHeight:"25px",paddingLeft:"5px",paddingRight:"5px",marginLeft:"5px",marginTop:"5px",border:"1px solid rgb(248, 192, 60)",cursor:"pointer"})
        div.click(function(){
            $(this).remove()
        })
        $("#criterios").append(div)




    });

$(".btnpq").livequery(function() {
    $(this).hover(
        function () {
            $(this).addClass("ui-state-hover");
        },
        function () {
            $(this).removeClass("ui-state-hover");
        }
    );
});

$(".ok").livequery(function() {
    $(this).click(function() {
        var idReg = $(this).attr("regId");
        var txtReg = $(this).attr("txtReg");
        $("#hidVal").val(idReg);
        $("#txtValor").val(txtReg);
        $(".buscador").dialog("close");
    });
});
function cambiaOperador() {
    if ($("#campo option:selected").attr("tipo") == 'string') {
        $("#operador option").remove();
        var opt = $("<option value=\'like\'>Contiene</option>");
        $("#operador").append(opt);
        opt = $("<option value=\'like der\'>Empieza</option>");
        $("#operador").append(opt);
        opt = $("<option value=\'igual\'>Igual</option>");
        $("#operador").append(opt);
    }
    if ($("#campo :selected").attr("tipo") == "number" || $("#campo :selected").attr("tipo") == "date" ) {
        $("#Doperador").html('<select name="operador" id="operador" style="width: 100px;"><option value="=">Igual</option><option value=">">Mayor</option><option value="<">Menor</option>  </select>');
        $("#tipoCampo").val("number");
    }
    if ($("#campo :selected").attr("tipo") == "-1") {
        $("#Doperador").html('<select name="operador" style="width: 100px;"></select>');
    }
}

$("#criterio").keypress(function(event){
    if(parseInt(event.keyCode) == 13){
        enviar();
    }
});