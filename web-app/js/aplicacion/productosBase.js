 $(function(){
    $("#guardarAsgr").click(function(){
	$(".frmaAsgr").submit();
    });

    $("#guardarTpas").click(function(){
        if($(".frmaTpas").validate())
	$(".frmaTpas").submit();
    });

      $("#guardarTprf").click(function(){
        if($(".frmaTprf").validate())
	$(".frmaTprf").submit();
    });

     $("#guardarTrmt").click(function(){
        if($(".frmaTrmt").validate())
	$(".frmaTrmt").submit();
    });

     $("#guardarTpgr").click(function(){
        if($(".frmaTpgr").validate())
	$(".frmaTpgr").submit();
    });

     $("#guardarTpts").click(function(){
        if($(".frmaTpts").validate())
	$(".frmaTpts").submit();
    });

     $("#guardarUbcn").click(function(){
        if($(".frmaUbcn").validate())
	$(".frmaUbcn").submit();
    });

    $("#guardarDpnd").click(function(){
        if($(".frmaDpnd").validate())
	$(".frmaDpnd").submit();
    });

    $("#guardarDcmt").click(function(){
        if($(".frmaDcmt").validate())
	$(".frmaDcmt").submit();
    });

 });
