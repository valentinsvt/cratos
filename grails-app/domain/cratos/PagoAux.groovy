package cratos
class PagoAux implements Serializable {

    Auxiliar auxiliar
    double monto
    double interes = 0
    String factura
    Date fecha

    TipoDocumento tipoDocumento
    String referencia

    String estado //V validado

    static mapping = {
        table 'pgax'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pgax__id'
        id generator: 'identity'
        version false
        columns {
            auxiliar column: 'axlr__id'
            monto column: 'pgaxmnto'
            interes column: 'pgaxintr'
            factura column: "pgaxfctr"

            tipoDocumento column: 'tpdc__id'
            referencia column: 'pgaxrefe'

            estado column: 'pgaxetdo'
        }
    }
    static constraints = {
        auxiliar(blank: false, nullable: false)
        fecha(nullable: true, blank: true)
        factura(nullable: true, blank: true, size: 1..30)

        tipoDocumento(blank: true, nullable: true, attributes: [title: 'tipoDocumento'])
        referencia(blank: true, nullable: true, attributes: [title: 'documento de referencia'])

        estado(blank: true, nullable: true)
    }
}