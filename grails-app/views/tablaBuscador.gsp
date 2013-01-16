
<g:if test="${lista?.size()>0}">
    <table width="400px" id="tablaBuscador">
        <thead>
        <g:each in="${listaTitulos}">
            <th>${it}</th>
        </g:each>
        <th style="width: 40px"></th>
        </thead>
        <tbody id="paginate">
        <g:each var="reg" in="${lista}" status="i">
            <tr>
                <g:each in="${listaCampos}" var="nombre" status="j">
                    <g:if test="${funciones}">
                        <g:if test="${funciones[j]}">
                            <g:set var="prop" value="${bsc.operacion(propiedad:nombre,funcion:funciones[j],registro:reg)}"></g:set>
                        </g:if>
                        <g:else>
                            <g:set var="prop" value="${reg.properties[nombre]}"></g:set>
                        </g:else>
                    </g:if>
                    <g:else>
                        <g:set var="prop" value="${reg.properties[nombre]}"></g:set>
                    </g:else>
                    <td>
                        ${prop}
                    </td>
                </g:each>
                <td style="text-align: right;width: 40px">
                    <div  style="float: right; margin-right: 5px;" class="ok btnpq ui-state-default ui-corner-all" id="reg_${i}" regId="${reg?.id}" txtReg="${reg.toString()}" >
                        <span class="ui-icon ui-icon-circle-check"></span>
                    </div>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <script type="text/javascript">

        function paginar(id,mostrar){

            var tbody=$("#"+id)
            var num = mostrar
            var rows = tbody.find("tr")
            var cant = rows.size()
            var paginas = Math.ceil(cant/num)
            var i=0
            var fila
            var padre
            var show = function (){
                var pag=$(this).html()
                var body =$("#"+$(this).attr("body"))
                body.find("tr").addClass("hiden")
                body.find("."+pag).removeClass("hiden").show()
                $(".paginateButon").css("background","none")
                $(".b"+pag).css("background","#B2D1FF")
                $(".hiden").hide()

            }

            rows.each(function(i){
                if(i>=num){
                    $(this).hide().addClass("hiden "+(Math.ceil((i+1)/num)))
                }else{
                    $(this).addClass("1")
                }

            });

            padre=tbody.parent().parent()
            fila=$("<div>")
            fila.width(tbody.parent().width()-10)
            fila.height(20)
            fila.css("padding-left",5).css("padding-rigth",5).css("padding-top",2)

            for(i=0;i<paginas;i++){
                var boton = $("<div>")
                boton.css({
                    cursor:"pointer",
                    width:15,
                    height:20,
                    float:"left",
                    marginLeft:5,
                    border:"1px solid black",
                    lineHeight:"20px",
                    paddingLeft:"7px"

                }).html(i+1).bind("click",show).attr("body",id).addClass("b"+(i+1)+" paginateButon");
                if(i==0)
                    boton.css("background","#B2D1FF")
                fila.append(boton)
            }

            padre.append(fila)


        }



        paginar("paginate",10)

    </script>
</g:if>
<g:else>
    <div class="message" style="margin-left: 40px;width: 85%;margin-bottom: 15px">
        No se encontraron datos
    </div>
</g:else>

