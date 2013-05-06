<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Contabilidad"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'phoenix.png')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">


    <!-- Framework CSS -->
    <link rel="stylesheet" href="${resource(dir: 'css/blueprint', file: 'screen.css')}" type="text/css" media="screen, projection"/>
    <link rel="stylesheet" href="${resource(dir: 'css/blueprint', file: 'print.css')}" type="text/css" media="print"/>
    <!--[if IE]><link rel="stylesheet" href="${resource(dir: 'css/blueprint', file: 'ie.css')}" type="text/css" media="screen, projection" /><![endif]-->

    <!--  CSS framework plugins -->
    <link rel="stylesheet" href="${resource(dir: 'css/blueprint/plugins/fancy-type', file: 'screen.css')}" type="text/css" media="screen, projection"/>
    <link rel="stylesheet" href="${resource(dir: 'css/blueprint/plugins/silksprite', file: 'sprite.css')}" type="text/css" media="screen, projection"/>

    <!-- Jquery -->
    <link rel="stylesheet" href="${resource(dir: 'js/jquery/css/bnw', file: 'jquery-ui-1.8.17.custom.css')}" type="text/css"/>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-1.7.1.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.8.17.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/i18n', file: 'jquery.ui.datepicker-es.js')}"></script>

    <!-- box -->
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery/plugins/box/css', file: 'jquery.luz.box.css')}" media="screen">
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/box/js', file: 'jquery.luz.box.js')}"></script>

    <!-- Dropdown menu -->
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery/plugins/superfish/css', file: 'superfish.css')}" media="screen">
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/superfish/js', file: 'hoverIntent.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/superfish/js', file: 'superfish.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/superfish/js', file: 'supersubs.js')}"></script>

    <!-- validation -->
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation', file: 'jquery.validate.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation', file: 'additional-methods.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/validation', file: 'messages_es.js')}"></script>

    <!-- qtip -->
    <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.css')}" media="screen">
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>

    <!-- countdown -->
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/countdown', file: 'jquery.countdown.min.js')}"></script>

    <!-- datejs -->
    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/datejs', file: 'date.js')}"></script>

    <!-- funciones -->
    <script type="text/javascript" src="${resource(dir: 'js', file: 'funciones.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css">

    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>
<g:if test="${session.usuario}">
    <div role="banner" class="banner">
        <g:link action="index" controller="inicio" style="color:#F67B26 !important;text-decoration: none;font-weight: normal;">
            <div class="img" style="float: left; height: 75px;">
                <img src="${resource(dir: 'images', file: 'finix1.png')}" alt="Finix" height="73"/>
            </div>

            <div style="height: 75px; line-height: 75px; font-size: 25px; float: left; margin-left:0px;width: 800px;float: right">
                Cratos - ${session.empresa}
            </div>

            %{--<div class="emp" style="height: 25px; width: 200px; margin-top: 50px; float: right;">--}%

                %{--Empresa:--}%
            %{--</div>--}%
        </g:link>
    </div>

    <mn:horizontalDropDown/>

    <div style="min-height: 900px;margin-top: 5px;">
        <g:layoutBody/>
    </div>

%{--<div class="footer ui-widget-content" role="contentinfo"></div>--}%

    <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
%{--<g:javascript library="application"/>--}%
    <r:layoutResources/>



    <script type="text/javascript">

        function validarSesion() {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller:'validarSesion', action: 'validarSesion')}",
                success : function (msg) {
                    console.log(msg);
                    if (msg == "OK") {
                        fin.add({
                            minutes : 20
                        });
                        $('#countdown').css({color : "#fff"}).countdown('change', {until : fin});
                    } else {
                        location.href = "${createLink(controller:'login', action: 'login')}";
                    }
                }
            });
        }

        var fin = new Date().add({
            minutes : 20
//                seconds : 5
        });
        $('#countdown').countdown({
            until    : fin,
            compact  : true,
            format   : 'MS',
//                expiryText : "Validando su sesión",
            onTick   : function (periods) {
                var mins = periods[5];
                var secs = periods[6];
                if (mins <= 5) {
                    $('#countdown').css({
                        color : "red"
                    });
                    if (mins == 5 && secs == 59) {
                        $('#countdown').show("pulsate");
                    }
                }
            },
            onExpiry : function () {
                validarSesion();

            }
        });

        $(".ajax").click(function () {
            var fin = new Date().add({
                minutes : 20
//                seconds : 5
            });
            $('#countdown').css({color : "#fff"}).countdown('change', {until : fin});
        });
    </script>
</g:if>

</body>
</html>