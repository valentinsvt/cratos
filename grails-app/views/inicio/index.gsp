<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 2/10/12
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Cratos - Contabilidad</title>


    <style type="text/css">
    .item{
        width: 100px;
        height: 100px;
        border: 1px solid #ccc;
        text-align: center;
        font-weight: bold;
        font-family: "Helvetica Neue Light";
        cursor: pointer;

    }
    img{
        width: 80px;
        height: 60px;
        margin-left: 10px;
        margin-top: 5px;
    }
    a{
        text-decoration: none !important;
        color:black !important;
        font-weight: bold;
    }
    </style>
</head>

<body>
<div style="width: 920px;height: 600px;margin: 27px;position: relative;">

    <div class="item ui-corner-all" style="position: absolute;top:10px;left: 200px;" accion="list" controlador="ordenCompra">
        <g:link action="list" controller="ordenCompra">
            <img src="${resource(dir: 'images',file: 'ordenCompra.gif')}" alt="" >
            Ordenes de compra
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:180px;left: 200px;">
        <g:link action="list" controller="ordenCompra">
            <img src="${resource(dir: 'images',file: 'adq.png')}" alt="" >
            Adquisiciones
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:180px;left: 600px;">
        <g:link action="list" controller="factura">
            <img src="${resource(dir: 'images',file: 'ventas.gif')}" alt="" >
            Ventas
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:390px;left: 400px;">
        <g:link action="lsta" controller="proceso">
            <img src="${resource(dir: 'images',file: 'contabilidad2.jpeg')}" alt="" >
            Contabilidad
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:390px;left: 5px;">
        <g:link action="index" controller="gestorContable">
            <img src="${resource(dir: 'images',file: 'gestor.jpeg')}" alt="" >
            Gestor
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:390px;left: 200px;">
        <g:link action="nuevoProceso" controller="proceso">
            <img src="${resource(dir: 'images',file: 'contabilidad.jpeg')}" alt="" >
            Transacciones
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:565px;left: 400px;">
        <g:link action="index" controller="reportes">
            <img src="${resource(dir: 'images',file: 'reportes.jpeg')}" alt="" >
            Reportes
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:180px;left: 5px;">
        <g:link action="list" controller="cuenta">
            <img src="${resource(dir: 'images',file: 'plan_cuentas.png')}" alt="" >
            Plan de cuentas
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:180px;left: 800px;">
        <g:link action="list" controller="proveedor">
            <img src="${resource(dir: 'images',file: 'clientes.jpeg')}" alt="" >
            Clientes
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:10px;left: 800px;">
        <g:link action="list" controller="usro">
            <img src="${resource(dir: 'images',file: 'usuarios.jpeg')}" alt="" >
            Usuarios
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:390px;left: 800px;">
        <g:link action="parametros" controller="inicio">
            <img src="${resource(dir: 'images',file: 'parametros.jpeg')}" alt="" >
            Parámetros
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:180px;left: 400px;">
        <g:link action="list" controller="proveedor">
            <img src="${resource(dir: 'images',file: 'proveedor.jpeg')}" alt="" >
            Proveedores
        </g:link>
    </div>
    <div class="item ui-corner-all" style="position: absolute;top:10px;left: 400px;">
        <g:link action="list" controller="item">
            <img src="${resource(dir: 'images',file: 'item.jpeg')}" alt="" >
            Productos
        </g:link>
    </div>



    %{--Flechas--}%
    <img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:110px;left: 200px">
    <img src="${resource(dir: 'images',file: 'flecha_se.png')}" alt="" style="position: absolute;top:300px;left: 270px">
    <img src="${resource(dir: 'images',file: 'flecha_sw.png')}" alt="" style="position: absolute;top:300px;left: 540px">
    <img src="${resource(dir: 'images',file: 'flecha_e.png')}" alt="" style="position: absolute;top:410px;left: 105px">
    <img src="${resource(dir: 'images',file: 'flecha_e.png')}" alt="" style="position: absolute;top:410px;left: 305px">
    <img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:490px;left: 400px">
    <img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:300px;left: 5px">
    <img src="${resource(dir: 'images',file: 'flecha_n.png')}" alt="" style="position: absolute;top:115px;left: 400px">
    <img src="${resource(dir: 'images',file: 'flecha_w.png')}" alt="" style="position: absolute;top:190px;left: 700px">
    <img src="${resource(dir: 'images',file: 'flecha_w.png')}" alt="" style="position: absolute;top:20px;left: 300px">
    <img src="${resource(dir: 'images',file: 'flecha_se.png')}" alt="" style="position: absolute;top:50px;left: 520px">
</div>
<script type="text/javascript">
    $(".item").hover(function(){
        var d =  $(this).find("img")
        d.width(d.width()+10)
        d.height(d.height()+10)
//        $.each($(this).children(),function(){
//            $(this).width( $(this).width()+10)
//        });
    },function(){
        var d =  $(this).find("img")
        d.width(d.width()-10)
        d.height(d.height()-10)
    })

</script>
</body>
</html>