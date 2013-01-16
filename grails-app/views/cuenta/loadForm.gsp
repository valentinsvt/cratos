<g:form name="form-cuenta" action="save">
    <g:render template="form"/>
</g:form>

<script type="text/javascript">
    $(function () {
        $(".field").qtip();

//        $("#form-cuenta").validate({
//            errorClass : "invalid"
//        });


        var myForm = $('#form-cuenta');

        myForm.validate({
//            errorClass     : "errormessage",
            onkeyup        : false,
            errorClass     : 'error1',
            validClass     : 'valid',
            errorPlacement : function (error, element) {
                // Set positioning based on the elements position in the form
                var elem = $(element),
                        corners = ['left center', 'right center'],
                        flipIt = true;

                // Check we have a valid error message
                if (!error.is(':empty')) {
                    // Apply the tooltip only if it isn't valid
                    elem.filter(':not(.valid)').qtip({
//                        overwrite : false,
                        content   : error,
                        position  : {
                            my       : corners[ flipIt ? 0 : 1 ],
                            at       : corners[ flipIt ? 1 : 0 ],
                            viewport : $(window)
                        },
                        show      : {
                            event : false,
                            ready : true
                        },
                        hide      : false,
                        style     : {
                            classes : 'ui-tooltip-red' // Make it red... the classic error colour!
                        }
                    })

                        // If we have a tooltip on this element already, just update its content
//                            .qtip('option', 'content.text', error);
                }

                // If the error is empty, remove the qTip
                else {
                    elem.qtip('destroy');
                }
            },
            success        : $.noop // Odd workaround for errorPlacement not firing!
        })

    });
</script>