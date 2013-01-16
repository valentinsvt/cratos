<%@ page import="cratos.seguridad.Accn" contentType="text/html;charset=UTF-8" %>
<html>
<head><title></title></head>
<body>
<g:form action="guardarPermisos" class="frmPrms" method="POST">
    <input type="hidden" value="${perfil.id}" name="perfil">
    <div id="tabs" style="height: 450px;overflow-y: auto;min-width: 800px;">
        <ul>
            <g:each in="${modulos}" var="mod" status="i">
                <g:if test="${mod.orden<99}">
                    <li><a href="#tabs-${i+1}">${mod.nombre}</a></li>
                </g:if>
            </g:each>
        </ul>
        <g:each in="${modulos}" var="mod" status="i">
            <g:if test="${mod.orden<99}">
                <div id="tabs-${i+1}" >
                    <table style="width: 600px;" id="tabla_${mod.id}">
                        <thead>
                        <th>Otorgado</th>
                        <th>Nombre</th>
                        <th>Descripcion</th>
                        <th>Controlador</th>
                        <th>Tipo</th>
                        </thead>
                        <tbody>
                        <g:each in="${Accn.findAllByModulo(mod,[sort:'control'])}" var="accn" status="j">
                            <tr class="${(j % 2) == 0 ? 'odd' : 'even'}">
                                <td><input type="checkbox" class="chkPrms ${accn.modulo}" name="chk" style="margin-left: 40%;" accn="${accn.id}"  ${(permisos.contains(accn.id))?"checked='true'":"no"} value="${accn.id}" ></td>
                                <td>${accn.accnNombre}</td>
                                <td>${accn.accnDescripcion}</td>
                                <td>${accn.control}</td>
                                <td>${accn.tipo}</td>
                            </tr>
                        </g:each>
                        <tr style="background: #8FBF5C">
                            <td><input type="checkbox" class="chkall" mdlo="${mod}" style="margin-left: 40%;" ></td>
                            <td>Chequear todos</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </g:if>
        </g:each>

    </div>
</g:form>
<a href="#" id="guardar" style="margin-top: 10px">Guardar</a>
<script type="text/javascript">

    $(".chkall").change(function(){

         $("."+$(this).attr("mdlo")).attr("checked",$(this).is(":checked"));


    });

    $("#guardar").button().click(function(){
        $(".frmPrms").submit()
    });
    $( "#tabs" ).tabs();
    $(".combo").change(function(){
        $.ajax({
                    type: "POST",
                    url: "${createLink(action:'cambiarTipo')}",
                    data: {
                        accn:$(this).attr("accn"),
                        val:$(this).val()
                    },
                    success: function(msg) {

                    }
                });
    });

    $(".comboModulo").change(function(){
        var sel = $(this);
        $.ajax({
                    type: "POST",
                    url: "${createLink(action:'cambiarModulo')}",
                    data: {
                        accn:$(this).attr("accn"),
                        val:$(this).val()
                    },
                    success: function(msg) {
                        if(msg=="ok"){
                            var tr = sel.parent().parent();
                            ////console.log(tr);
                            ////console.log($("#tabla_"+sel.val()));
                            $("#tabla_"+sel.val()).prepend(tr);
                        }
                    }
                });
    });
</script>
</body>
</html>