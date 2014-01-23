<%@ page contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Parámetros</title>

    <script type="text/javascript" src="${resource(dir: 'js/jquery/plugins', file: 'jquery.cookie.js')}"></script>

</head>

<body>

<div class="container ui-corner-all " style="">
  <div style="float:left; width:640px;">
    <div id="info">
        <ul id="info-nav">
            <li><a href="#gnrl">Generales</a></li>
            <li><a href="#emprtb">Empresa</a></li>
            <li><a href="#item">Activos fijos y Facturación</a></li>
            <li><a href="#nmna">Nómina</a></li>
        </ul>

            <div id="gnrl" class="ui-widget-content" style="height: 600px">
                <div class="item" texto="nvel">
                    <g:link controller="nivel" action="list">Nivel</g:link> de detalle de las cuentas contables y de
                    preupuesto (partidas)
                </div><br>
                <div class="item" texto="tppg">
                    <g:link controller="tipoPago" action="list">Tipo de pago</g:link> o forma de pago
                    que se acuerda con los proveedores, puede ser contado, crédito, o mediante un tiempo de espera antes
                    de realizar la efectivización del pago, ejemplo tarjetas de crédito con fechas de corte prefijadas
                </div><br>
                <div class="item" texto="fnte">
                    <g:link controller="fuente" action="list">Fuente de transacciones</g:link> nombre de los módulos
                    del sistema que pueden generar transacciones contables
                </div><br>
                <div class="item" texto="tpdp">
                    <g:link controller="tipoDocumentoProveedor" action="list">Tipo de Documentos de Proveedor o Cliente</g:link> para
                    distinguir entre documentos de retención, facturas u otros.
                </div><br>
                <div class="item" texto="tpcp">
                    <g:link controller="tipoComprobante" action="list">Tipos de comprobante contable</g:link> usualmente
                    se trata de ingresos, egresos y diarios
                </div><br>
                <div class="item" texto="tpcn">
                    <g:link controller="tipoCuenta" action="list">Tipo de cuenta bancaria</g:link> que puede estar
                    asociada a una cuenta contable, por ejemplo caja bancos está asociada a una cuenta corriente
                </div><br>
                <div class="item" texto="tpdc">
                    <g:link controller="tipoDocumento" action="list">Tipo de Documento de pago</g:link> con los que se
                    permite realizar pagos a proveedores
                </div><br>
                <div class="item" texto="tpid">
                    <g:link controller="tipoIdentificacion" action="list">Tipo de Identificación</g:link> de la persona
                    natural o jurídica, puede ser RUC, Cédula, pasaporte, etc.
                </div><br>
                <div class="item" texto="tprl">
                    <g:link controller="tipoRelacion" action="list">Tipo de Relación</g:link> predominante con la persona
                    natural o jurídica, ya sea como Proveedor, Cliente o los dos roles.
                </div><br>
                <div class="item" texto="tppr">
                    <g:link controller="tipoPersona" action="list">Tipo de Persona</g:link> natural o jurídica
                    de un Proveedor o Cliente.
                </div><br>
                <div class="item" texto="tppv">
                    <g:link controller="tipoProveedor" action="list">Tipo de Proveedor</g:link> como contribuyentes
                    normales, especiales y el estado.
                </div><br>
                <div class="item" texto="tpst">
                    <g:link controller="tipoSoporte" action="list">Tipo de Sustento Tributario</g:link> como contribuyentes
                    normales, especiales y el estado.
                </div><br>
                <div class="item" texto="tpcp_sri">
                    <g:link controller="tipoComprobanteSri" action="list">Tipo de Comprobante según el SRI</g:link> para
                    los anexos tributarios.
                </div><br>
                <div class="item" texto="tcti">
                    <g:link controller="tipoComprobanteId" action="list">Tipo de Comprobante que se aplica al tipo de
                    identificación</g:link> para cada tipo de identificación se aceptan sólo ciertos tipos de comprobantes.
                </div><br>
                <div class="item" texto="crear">
                    <g:link controller="contabilidad" action="list">Períodos Contables</g:link>
                </div><br>
            </div>

            <div id="emprtb" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="tpem">
                    <g:link controller="tipoEmpresa" action="list">Tipo de Empresa</g:link>, clasificación para registro
                    y control de empresas que reciben el servicio
                </div><br>
                <div class="item" texto="cncs">
                    <g:link controller="centroCosto" action="list">Centro de Costos</g:link> de la empresa de acuerdo a
                    los cuales se llevará el control de bodegas, inventarios y existencias.
                </div><br>
                <div class="item" texto="bnco">
                    <g:link controller="banco" action="list">Bancos</g:link> en los cuales posee cuentas asociadas a la
                    contabilidad
                </div><br>
                <div class="item" texto="dpto">
                    <g:link controller="departamento" action="list">Departamento</g:link> de la empresa que poseen
                    personal
                </div><br>
                <div class="item" texto="rpcn">
                    <g:link controller="reporteCuenta" action="list">Reportes Contables</g:link> Reportes contables
                    especiales del sistema conforme a las normas NIIF
                </div><br>
                <div class="item" texto="paux">
                    <g:link controller="parametrosAuxiliares" action="list">Parámetros Auxiliares</g:link> para definir
                    valores de impuestos.
                </div><br>
                <div class="item" texto="empr">
                    <g:link controller="empresa" action="list">Parámetros de la Empresa</g:link> para definir la forma de
                    funcionamiento de la contabilidad, centros de costos y control de inventarios.
                </div><br>
            </div>

            <div id="item" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="undd">
                    <g:link controller="unidad" action="list">Unidades</g:link> de conteo o control de los los items.
                </div><br>
                <div class="item" texto="mrca">
                    <g:link controller="marca" action="list">Marcas</g:link> de los distintos items que se posee como
                    inventarios o como activos fijos.
                </div><br>
                <div class="item" texto="clor">
                    <g:link controller="color" action="list">Colores</g:link> de los distintos activos fijos a cargo de
                    los distintos empleados de la empresa.
                </div><br>
                <div class="item" texto="grpo">
                    <g:link controller="grupo" action="list">Grupos</g:link> de ítems, sirve para clasificar y controlar
                    los ítems clasificados por grupos.
                </div><br>
                <div class="item" texto="bdga">
                    <g:link controller="bodega" action="list">Bodegas</g:link> para el control de existencias e inventarios
                    por centros de costos o en forma general.
                </div><br>
                <div class="item" texto="tptj">
                    <g:link controller="tipoTarjeta" action="list">Tipo de tarjeta</g:link> de crédito para el pago
                    de las facturas
                </div><br>
                <div class="item" texto="tpfc">
                    <g:link controller="tipoFactura" action="list">Tipo de Factura</g:link> para discriminar entre
                    facturas, notas de venta y proformas
                </div><br>
                <div class="item" texto="etdo">
                    <g:link controller="estado" action="list">Estado</g:link> de la factura, se aplica también como
                    referencia a transferencias y adquisiciones.
                </div><br>
                <div class="item" texto="frpg">
                    <g:link controller="formaDePago" action="list">Forma de pago</g:link> de la factura
                    puede ser en efectivo, con tarjeta de crédito o con cheque.
                </div><br>
            </div>

            <div id="nmna" class="ui-widget-content" style="height: 440px">
                <div class="item" texto="tpct">
                    <g:link controller="tipoContrato" action="list">Tipos de contrato</g:link> que se aplican a sus
                    empleados para la generación de la nómina
                </div><br>
                <div class="item" texto="tprb">
                    <g:link controller="tipoRubro" action="list">Tipo de rubro</g:link> que componen los ingresos y
                    egresos de nómina de un empleado
                </div><br>
                <div class="item" texto="rbro">
                    <g:link controller="rubro" action="list">Rubro de nómina</g:link> que pueden ser ingresos, egresos y provisiones.
                </div><br>
                <div class="item" texto="crgo">
                    <g:link controller="cargo" action="list">Cargos</g:link> que puede tener un empleado.
                </div><br>
                <div class="item" texto="edcv">
                    <g:link controller="estadoCivil" action="list">Estado civil</g:link> de la persona.
                </div><br>
                <div class="item" texto="prof">
                    <g:link controller="profesion" action="list">Profesión</g:link> del empelado, o título académico
                    principal.
                </div><br>
                <div class="item" texto="ncnl">
                    <g:link controller="nacionalidad" action="list">Nacionalidad</g:link> del empelado.
                </div><br>
                <div class="item" texto="mess">
                    <g:link controller="mes" action="arbol">Meses del año</g:link> para generar la nómina.
                </div><br>
                <div class="item" texto="base">
                    <g:link controller="base" action="list">Tabla de valores para declarar el impuesto a la renta</g:link>
                    de acuerdo al SRI, definida año por año.
                </div>
            </div>
    </div>
</div>

<div id="tool" style="float:left; width: 200px; height: 300px; margin-top: 80px; margin-left: 30px; display: none; padding:20px;"
     class="ui-widget-content ui-corner-all">
</div>

<div id="nvel" style="display:none">
    <h1>Nivel de las Cuentas</h1><br>
    <p>Nivel de detalle de las cuentas contables y de las partidas preupuestarias</p>
    <p>Se aplica al plan o catálogo de cuentas y al catálogo presupuestario</p>
</div>

<div id="tppg" style="display:none">
   <h1>Tipo de Pago</h1><br>
   <p>Es la forma de pago que se acuerda con los proveedores, puede ser contado, a crédito, o mediante un
    tiempo de espera o fecha prefijada para la realización del pago, ejemplo tarjetas de crédito con fechas
    de corte a inicio o fin de mes</p>
    <p>Finix ha dejado abierta la posibilidad de manejar cortes y políticas de pago para aplicars a productos
    como tarjetas de crédito</p>
</div>

<div id="fnte" style="display:none">
    <h1>Fuente de Transacciones</h1><br>
    <p>Define el origen de la transacción que genera el registro contable. Cada fuente está ligada a una
    operación bancaria o a un módulo finix</p>
    <p>Se aplica al registro contable de transacciones bancarias y a los módulos administrativos que puede
    tener finix</p>
</div>
<div id="tpdp" style="display:none">
    <h1>Tipo de Documento de Proveedor o Cliente</h1><br>
    <p>Distintos tipos de documentos que puede generar la transacción, como factura, retención, comprobante de
    ingreso, etc.</p>
</div>
<div id="tpcp" style="display:none">
    <h1>Tipo de Comprobante</h1><br>
    <p>En forma general los comprobantes contables son ingresos, egresos y diarios</p>
    <p>Se deja abierta la posibilida de aplicar otros tipos de comprobantes de acuerdo a los requerimientos
    que pueda hacer la Superintendencia de Bancos y Seguros</p>
</div>
<div id="tpcn" style="display:none">
    <h1>Tipo de Cuenta Bancaria</h1><br>
    <p>Se refiere al tipo de cuenta bancaria que puede tener la institución financiera en otros bancos locales
    o internacionales, no se trata de sus propios productos bancarios</p>
    <p>Se aplica al control de cuentas contables como libro bancos</p>
</div>
<div id="tpdc" style="display:none">
    <h1>Tipo de Documento de Pago</h1><br>
    <p>Son los diferentes tipos de documentos de pago que pueden aceptarse para transacciones entre la institución financiera y sus proveedores</p>
    <p>No se aplica a los productos bancarios, solo al registro contable</p>
</div>
<div id="tpid" style="display:none">
    <h1>Tipo de Identificaci&oacute;n</h1><br>
    <p>Tipos de identificación que posee la persona natural o jurídica, como por ejempla RUC, cédula, pasaporte, etc.</p>
    <p style="font-style: italic; color: navy">No se debe editar este parámetro.</p>
</div>
<div id="tprl" style="display:none">
    <h1>Tipo de Relaci&oacute;n</h1><br>
    <p>Tipos de relación que puede darse con una persona natural o jurídica, como un proveedor o como un cliente.</p>
    <p>Si una persona posee los dos roles, se requiere que se indique se debe indicar los dos roles
    o promoverlo al tipo Proveedor/Cliente.</p>
    <p style="font-style: italic; color: navy">No se debe editar este parámetro.</p>
</div>
<div id="tppr" style="display:none">
    <h1>Tipo de Persona</h1><br>
    <p>Tipos de persona: natural o jurídica que posee un proveedor o un cliente.</p>
    <p style="font-style: italic; color: navy">No se debe editar este parámetro.</p>
</div>
<div id="tppv" style="display:none">
    <h1>Tipo de Proveedor</h1><br>
    <p>Sirve para distinguir los varios tipos de proveedores como contribuyentes especiales, particulares y el fisco.</p>
</div>
<div id="tpst" style="display:none">
    <h1>Tipo de Sustento Tributario</h1><br>
    <p>Tipo de sustento tributario que se ha se adjuntar a los anexos tributarios que se entregan al SRI.</p>
</div>
<div id="tpcp_sri" style="display:none">
    <h1>Tipo de Comprobante según el SRI</h1><br>
    <p>Tipo de comprobante que se usa para el enexo tributario.</p>
</div>
<div id="tcti" style="display:none">
    <h1>Tipo de Comprobante por Tipo de Identificación</h1><br>
    <p>Para cada tipo de identificación que se use con un proveedor se deben usar sólo un deerminado Tipo de comprobante.</p>
    <p>Esta información debe ser concordante con lo establecido por el SRI.</p>
</div>

<div id="tpem" style="display:none">
    <h1>Tipo de Empresa</h1><br>
    <p>Sirve para distinguir de entre los distinctos tipos de empresas beneficiarios del servicio.</p>
</div>
<div id="cncs" style="display:none">
    <h1>Centro de Costos</h1><br>
    <p>Centro de costos para el control de adquisiciones, ventas, inventario y bodegas.</p>
    <p>Si la empresa no lleva el control de varios centros de costos, se debe definir uno general a la
    cual pretenecerán todas las bodegas.</p>
</div>
<div id="bnco" style="display:none">
    <h1>Bancos</h1><br>
    <p>Registro de los bancos relacionados con la empresa, ya sea por cuentas de ahorro o corrientes.</p>
</div>
<div id="dpto" style="display:none">
    <h1>Departamentos de Personal</h1><br>
    <p>Departamentos de personal de la empresa para el control de la nómina. Cada empleado será vinculado a un
    departamento y un cargo.</p>
</div>
<div id="rpcn" style="display:none">
    <h1>Reportes de la Contabilidad</h1><br>
    <p>Sirve para definir reportes especiales por empresa.</p>
    <p>Por lo general siempre se definirán los mismo reportes para cada empresa, conforme las normas NIIF.</p>
</div>
<div id="paux" style="display:none">
    <h1>Parámtros de Funcionamiento</h1><br>
    <p>Parámetros de funcionamiento generales como el valor del IVA.</p>
</div>
<div id="empr" style="display:none">
    <h1>Parámtros de la Empresa</h1><br>
    <p>Parámetros de funcionamiento de la contabilidad, control de costos y valores del IVA, en la Empresa,</p>
</div>


<div id="undd" style="display:none">
    <h1>Unidad de Medida</h1><br>
    <p>Unidad de control o conteo de obras para el plan anual de adquisiciones (PAC) y para fijar las metas.</p>
    <p>Pueden ser: kil&oacute;metros, metros, escuelas, unidades, etc.</p>
</div>
<div id="mrca" style="display:none">
    <h1>Marcas</h1><br>
    <p>Marca de los artículos d einventario y de los activos fijos de la Empresa.</p>
    <p>Se de be crear un "Sin Marca" para aquellos bienes que no tienen marca</p>
</div>
<div id="clor" style="display:none">
    <h1>Colores</h1><br>
    <p>Colores para personalizar los activos fijos de la Empresa.</p>
    <p>El color sirve para distinguir de entre varios bienes del mismo tipo, marca y modelo</p>
</div>
<div id="grpo" style="display:none">
    <h1>Grupo de Ítems</h1><br>
    <p>Los grupos de ítems, sirven para clasificar y controlar los ítems clasificados por características.</p>
    <p>El manejo de grupos permite obtener estadísticas de ventas, adquisiciones y transferencias.</p>
</div>
<div id="bdga" style="display:none">
    <h1>Bodegas</h1><br>
    <p>Son los sitios donde se almacenan los artículos de inventario.</p>
    <p>Cada bodega debe estar relacionada a un centro de costos, pudiendo haber varias bodegas dentro de un
    mismo centro de costos.</p>
</div>
<div id="tptj" style="display:none">
    <h1>Tipo de Tarjeta</h1><br>
    <p>Se trata de los difentes tipos de tarjeta de crédito existentes.</p>
</div>
<div id="tpfc" style="display:none">
    <h1>Tipo de Factura</h1><br>
    <p>Maneja los difernetes tipos de facturas que pueden existir, tales como Facturas, proformas, notas de venta.</p>
</div>
<div id="etdo" style="display:none">
    <h1>Estado de la Factura</h1><br>
    <p>Sirve para distinguir enre facturas anuladas, impresas y en proceso de elaboración.</p>
</div>
<div id="frpg" style="display:none">
    <h1>Forma de pago de la Factura</h1><br>
    <p>Se trata de si el pago se realiza en efectivo, cheque o tarjeta de crédito.</p>
</div>


<div id="tpct" style="display:none">
    <h1>Tipo de Contrato</h1><br>
    <p>Tipos de contrato para el cálculo de la nómina de cada empleado. Cada tiṕo de contrato posee
    un conjunto específico de rubros de ingresos, egresos y provisiones</p>
</div>
<div id="tprb" style="display:none">
    <h1>Tipo de Rubro</h1><br>
    <p>Tipo de rubro de nómina.</p>
    <p>Pueden ser Ingresos, egresos y provisiones.</p>
</div>
<div id="rbro" style="display:none">
    <h1>Rubros de la Nómina</h1><br>
    <p>Rubros o conceptos por los que se hacen pagos o retenciones al empleado.</p>
    <p>Existen tambien rubros que pueden ser de valores fijos en proporción al sueldo base, y otros cuyo valor
    se ingrese mes a mes.</p>
</div>
<div id="crgo" style="display:none">
    <h1>Cargos de la Empresa</h1><br>
    <p>Cargos que existen en la Empresa.</p>
    <p>Cada empleado de la Empresa será asociado a un cargo.</p>
</div>
<div id="edcv" style="display:none">
    <h1>Estado Civil</h1><br>
    <p>Valores de Estado civil que se pueden aceptar del personal de la empresa.</p>
</div>
<div id="prof" style="display:none">
    <h1>Profesión de la Persona</h1><br>
    <p>Profesiones con sus respectivas abreviaciones del personal de la empresa.</p>
    <p style="font-style: italic; color: navy">Por ejemplopara ingeniero, la abrviatura es "Ing".</p>
</div>
<div id="ncnl" style="display:none">
    <h1>Nacionalidad</h1><br>
    <p>Nacionalidad de la persona de la empresa.</p>
</div>
<div id="mess" style="display:none">
    <h1>Meses del año</h1><br>
    <p>Meses de año para usarse en los reportes.</p>
</div>
<div id="base" style="display:none">
    <h1>Tabla del Impuesto a la Renta</h1><br>
    <p>Valores de fracción básica, impuesto, % de excedente, etc.</p>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $('.item').hover(function () {
            //$('.item').click(function(){
            //entrar
            $('#tool').html($("#" + $(this).attr('texto')).html());
            $('#tool').show();
        }, function () {
            //sale
            $('#tool').hide('');
        });

        $('#info').tabs({
            //event: 'mouseover', fx: {
            cookie:{ expires:30 },
            event:'click', fx:{
                opacity:'toggle',
                duration:'fast'
            },
            spinner:'Cargando...',
            cache:true
        });
    });
</script>
</body>
</html>
