<div id="divPlanCuentasAll" style="width: 100%;float: left; min-height: 150px; margin-top: 0px; ">
    <div style="width: 800px;float: left;min-height: 10px; margin-top: 2px;border:none;margin-left: 8px;margin-bottom: 15px; " class=" ui-corner-all">
        <div id="agregarCuentas"></div>
    </div>

    <div style="float: left; width: 100%; ">
        <div style="margin-left: 15px; float: left">
            <div class="span-2">
                Nombre:
            </div>

            <div class="span-4">
                <input type="text" class="span-4 ui-widget-content ui-corner-all" name="nombreBus" id="nombreBus"/>
            </div>
        </div> <!-- fila -->
        <div style="margin-left: 15px;float: left">
            <div class="span-2">
                C&oacute;digo:
            </div>

            <div class="span-4">
                <input type="text" class="span-4 ui-widget-content ui-corner-all" name="codigo" id="codigoBus"/>
            </div>
        </div> <!-- fila -->
        <input type="hidden" name="movimientos" value="1"/>

        <div style="margin-left: 15px">
            <input type="button" class="fg-button ui-state-default  ui-corner-all" name="buscar" id="buscar" value="Buscar"/>
        </div> <!-- fila -->
    </div>

    <div id="divPlanCuentas" style="float: left; padding: 5px; margin-top: 2px; width: 700px;">

    </div>
</div>

<g:if test="${!nuevo}">
    <script type="text/javascript">
        $(function () {

            function cargarCuentas() {

                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(action: 'cargarCuentas',controller: 'gestorContable')}",
                    data    : " ",
                    success : function (msg) {
                        $("#agregarCuentas").html(msg);
                    }
                });
            }

            cargarCuentas();
        });

    </script>
</g:if>