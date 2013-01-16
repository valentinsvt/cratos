<html>

<head>
    <title>Finix - Gestor Contable</title>
    <meta name="layout" content="main" />

    <script type='text/javascript' src='${createLinkTo(dir:'js/jquery/plugins', file:'jquery.dataTables.js')}' ></script>
    <link rel='stylesheet' href='${createLinkTo(dir:'js/jquery/css', file:'jquery.dataTables.css')}' />
    <script type='text/javascript' src='${createLinkTo(dir:'js/jquery/plugins', file:'jquery.validate.js')}' ></script>
</head>

<body>
<div class="container entero ui-widget-content ui-corner-all">
    <h1 class="titulo center ui-widget-header ui-corner-all" style="margin-bottom: 10px;">Buscar gestores contables</h1>
    <div style="width: 800px;height: 40px">
        <g:link
                class="btn"
                action="nuevoGestor" >Nuevo
        </g:link>

    </div>
    <div id="divContenido">
        <g:form action="buscarGestor" class="buscarGestor">

            <div class="ui-state-error ui-corner-all ui-helper-hidden" style="padding: 5px; margin-bottom: 10px;">
                <span class="icon ui-icon ui-icon-alert" style="margin-top: 0; margin-right: 10px;"></span>
                <span id="error">error!</span>
            </div>
            <div class="span-10">
                <label style="margin-left: 10px">Nombre:</label>
                <input type="text" name="nombre" id="txtBusca" class="onlyNumbers ui-widget-content ui-corner-all" />

            </div>
            <div class="span-4">
                <a href="#" id="buscarGestor" class="btn">

                    Buscar
                </a>
            </div>
        </g:form>
    </div>
    <div id="divLista" style="clear: both; padding: 5px; margin-top: 5px;">

    </div>

    <script type="text/javascript">
        $(".btn").button()
    </script>
</div> <!-- container -->
</body>

</html>