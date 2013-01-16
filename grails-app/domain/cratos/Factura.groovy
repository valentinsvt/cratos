package cratos
class Factura implements Serializable {

    String registro
    double pagado
    double iva1
    double iva0
    double subtotal
    double iva
    double descuentos

    Date fecha = new Date()
    String direccion
    String telefono
    String persona

    String paciente

    String facturaSerie01
    String facturaSerie02
    String secuencial

    Empresa empresa
    TipoPago tipoPago
    Proveedor proveedor
    Estado estado
    TipoFactura tipoFactura
    TipoTarjeta tipoTarjeta
    String observaciones

    Gestor gestor
    static auditable = true

    static mapping = {
        table 'fctr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fctr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'fctr__id'
            registro column: 'fctrrgst'

            pagado column: 'fctrpgdo'
            iva1 column: 'fctriva1'
            iva0 column: 'fctriva0'
            subtotal column: 'fctrsbtt'
            iva column: 'fctrtiva'
            descuentos column: 'fctrdsct'

            fecha column: 'fctrfcha'
            direccion column: 'fctrdire'
            telefono column: 'fctrtlef'
            persona column: 'fctrprsn'

            paciente column: 'fctrpcnt'


            facturaSerie01 column: 'fctrsr01'
            facturaSerie02 column: 'fctrsr02'
            secuencial column: 'fctrscnc'

            empresa column: 'empr__id'
            tipoPago column: 'tppg__id'
            proveedor column: 'prve__id'
            estado column: 'etdo__id'
            tipoFactura column: 'tpfc__id'
            tipoTarjeta column: 'tptj__id'
            observaciones column: 'fctrobsv'
            gestor column: 'gstr__id'
        }
    }
    static constraints = {
        registro(size: 1..1, blank: true, nullable: true, attributes: [title: 'registro'])
        pagado(blank: true, nullable: true, attributes: [title: 'pagado'])
        iva1(blank: true, nullable: true, attributes: [title: 'iva1'])
        iva0(blank: true, nullable: true, attributes: [title: 'iva0'])
        subtotal(blank: true, nullable: true, attributes: [title: 'subtotal'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        telefono(size: 1..15, blank: true, nullable: true, attributes: [title: 'telefono'])
        persona(size: 1..63, blank: true, nullable: true, attributes: [title: 'persona'])

        paciente(size: 1..63, blank: true, nullable: true, attributes: [title: 'paciente'])

        facturaSerie01(size: 1..3, blank:  true, nullable: true, attributes: [title: 'serie01'])
        facturaSerie02(size: 1..3, blank:  true, nullable: true, attributes: [title: 'serie02'])
        secuencial(blank: true, nullable:true, attributes: [title: 'secuencial'],size: 1..14)
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        tipoPago(blank: true, nullable: true, attributes: [title: 'tipoPago'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        tipoFactura(blank: true, nullable: true, attributes: [title: 'tipoFactura'])
        tipoTarjeta(blank: true, nullable: true, attributes: [title: 'tipoTarjeta'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
        gestor(blank: true, nullable: true)
    }
}