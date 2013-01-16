<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="Grails"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'phoenix.png')}" type="image/x-icon">
        <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
        <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">

        <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css">

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


        <!-- qtip -->
        <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.css')}" media="screen">
        <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins/qtip', file: 'jquery.qtip.min.js')}"></script>


        <g:layoutHead/>
        <r:layoutResources/>
    </head>

    <body>
        <div role="banner" class="banner">
            <div class="img" style="float: left; height: 75px;">
                <img src="${resource(dir: 'images', file: 'finix1.png')}" alt="Finix" height="73"/>
            </div>

            <div style="height: 75px; line-height: 75px; font-size: 30px; float: left; margin-left:75px;">
                Cratos - Contabilidad
            </div>
        </div>


        <div style="height: 600px;">
            <g:layoutBody/>
        </div>

        %{--<div class="footer ui-widget-content" role="contentinfo"></div>--}%

        <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
        %{--<g:javascript library="application"/>--}%
        <r:layoutResources/>
    </body>
</html>