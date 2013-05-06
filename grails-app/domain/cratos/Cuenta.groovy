package cratos
class Cuenta implements Serializable {
    String auxiliar
    String movimiento
    String descripcion
    Cuenta padre
    String numero
    Empresa empresa
    CuentaBanco cuentaBanco
    Nivel nivel
    Presupuesto presupuesto
    String estado
    String retencion    /*     S --> si    N--> no      */
    Impuesto impuesto
    String resultado = ""  /* Cuenta para el calculo de resultados S--> superavit D--> deficit */
    static mapping = {
        table 'cnta'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cnta__id'
        id generator: 'identity'
        version false
        columns {
            auxiliar column: 'cntaauxl'
            movimiento column: 'cntamvmt'
            descripcion column: 'cntadscr'
            padre column: 'cntapdre'
            numero column: 'cntanmro'
            empresa column: 'empr__id'
            cuentaBanco column: 'cnbn__id'
            nivel column: 'nvel__id'
            presupuesto column: 'prsp__id'
            estado column: 'cntaetdo'
            retencion column: 'cntartcn'
            impuesto column: 'impt__id'
            resultado column: 'imptrstd'
        }
    }
    static constraints = {
        auxiliar(size: 1..1, inList: ['S', 'N'], blank: true, nullable: true, attributes: [title: 'Si puede o no tener auxiliares'])
        movimiento(size: 1..1, inList: ['1', '0'], blank: true, nullable: true, attributes: [title: 'Si puede o no tener movimientos'])
        descripcion(size: 1..127, blank: false, attributes: [title: 'Descripción'])
        padre(size: 1..20, blank: true, nullable: true, attributes: [title: 'Cuenta padre'])
        numero(size: 1..20, blank: false, attributes: [title: 'Número de cuenta'])
        empresa(blank: true, nullable: true, attributes: [title: 'Empresa a la que pertenece la cuenta'])
        cuentaBanco(blank: true, nullable: true, attributes: [title: 'Cuenta Banco'])
        nivel(blank: false, attributes: [title: 'Nivel'])
        presupuesto(blank: true, nullable: true, attributes: [title: 'Presupuesto'])
        estado(blank: false, maxSize: 1, attributes: [title: 'Estado'])
        retencion(blank: true,nullable: true,size: 0..1)
        impuesto(blank:true,nullable: true)
        resultado(blank: true,nullable: true,size:1..1)
    }

    String toString() {
        return this.numero + " - " + this.descripcion
    }

}