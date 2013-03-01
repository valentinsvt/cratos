package cratos

class Proveedor {
    TipoProveedor tipoProveedor
    TipoPersona tipoPersona
    Empresa empresa
    TipoIdentificacion tipoIdentificacion
    Canton canton
    String ruc
    String nombre
    String direccion
    Date fecha
    String nombreContacto
    String apellidoContacto
    double descuento
    String estado
    String observaciones
    String telefono
    TipoRelacion tipoRelacion
    String actividad
    String email
    String pais
    String nombreCheque
    String autorizacionSri
    Date fechaCaducidad

    static auditable = [ignore: ['lugar', 'tipoProveedor']]

    static mapping = {
        table 'prve'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prve__id'
        id generator: 'identity'
        version false
        columns {
            tipoProveedor column: 'tppv__id'
            tipoPersona column: 'tppr__id'
            empresa column: 'empr__id'
            tipoIdentificacion column: 'tpid__id'
            canton column: 'cntn__id'

            ruc column: 'prve_ruc'
            nombre column: 'prvenmbr'
            direccion column: 'prvedire'
            fecha column: 'prvefcha'
            nombreContacto column: 'prvenbct'
            apellidoContacto column: 'prveapct'

            descuento column: 'prvedsct'
            estado column: 'prveetdo'
            observaciones column: 'prveobsr'
            telefono column: 'prvetlfn'

            tipoRelacion column: 'tprl__id'

            actividad column: 'prveactv'
            email column: 'prvemail'
            pais column: 'prvepais'
            nombreCheque column: 'prvenmch'
            autorizacionSri column: 'autr_sri'
            fechaCaducidad column: 'fchacdcd'
        }
    }
    static constraints = {
        tipoProveedor(blank: true, nullable: true, attributes: [title: 'tipo de proveedor'])
        tipoPersona(attributes: [title: 'tipo de persona'])
        empresa(attributes: [title: 'empresa'])
        tipoIdentificacion(blank: true, nullable: true, attributes: [title: 'tipo de identificacion'])
        canton(attributes: [title: 'canton'])

        empresa(blank: true, nullable: true)
        canton(blank: true, nullable: true)

        ruc(size: 1..13, blank: false, attributes: [title: 'ruc'],unique: true)
        nombre(blank: true, nullable: true, maxSize: 63, attributes: [title: 'nombre'])
        direccion(maxSize: 127, blank: true, nullable: true, attributes: [title: 'direccion'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        nombreContacto(size: 1..40, blank: false, nullable: false, attributes: [title: 'nombre del contacto'])
        apellidoContacto(size: 1..40, blank: false, nullable: false, attributes: [title: 'apellido del contacto'])

        descuento(blank: true, nullable: true, attributes: [title: 'descuento'])
        estado(blank: true, nullable: true, attributes: [title: 'estado'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'observaciones'])

        telefono(blank: true, maxSize: 63, nullable: true, attributes: [title: 'telefono'])

        tipoRelacion(blank: true, attributes: [title: 'tipoRelacion'])

        actividad(blank: true, attributes: [title: 'actividad'])
        email(blank: true, attributes: [title: 'email'])
        pais(blank: true, attributes: [title: 'pais'])
        nombreCheque(blank: true, attributes: [title: 'nombreCheque'])
        autorizacionSri(blank: true,nullable: true,size: 1..40)
        fechaCaducidad(blank:true,nullable: true)
    }

    String toString() {
        def nombre = this.nombre
        if(!this.nombre)
            nombre = this.nombreContacto+" "+this.apellidoContacto

        "${this.ruc} ${nombre}"
    }
}