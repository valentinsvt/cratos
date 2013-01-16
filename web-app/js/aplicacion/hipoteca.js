
    $("#btnHipoteca").livequery(function() {
    	$(this).click(function() {

    		var idPer = $("#txtIdPersona").val();
    		var idCli = $("#txtIdCliente").val();

    		$.ajax({
    		    type: "POST",
    		    url: "../editarHipoteca",
    		    data: "cli="+idCli+"&per="+idPer,
    		    
    		    success: function(msg) {
    				
	    			$("#bienes").html(msg);
	    			
	    			/*$(".datepicker").datepicker({
	    			    dateFormat: 'dd/mm/yy',
	    			    changeYear: true,
	    			    changeMonth: true,
	    			    maxDate: "+0D",
	    			    yearRange:"-50:+50",
	    			    onSelect: function(dateText, inst) {
	    				var id = inst.id;
	    				var parts;
	    				parts = dateText.split("/");
	    				if(id == "fechaInicioBien") {
	    				    $('#fechaFinBien').datepicker('option', 'minDate', new Date(parts[2], (parts[1] - 1), (parts[0])));
	    				}
	    			    }
	    			});*/
    		    }
    		});
    	    

    	});
        });