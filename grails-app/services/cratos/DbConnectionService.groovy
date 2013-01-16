package cratos
import groovy.sql.Sql

class DbConnectionService {
    boolean transactional = false
    def dataSource
    public init(){
    }

    /**
     * Devuelve la conexión a la base de datos
     */

    def getConnection(){

        Sql sql = new Sql(dataSource)
        return sql
    }

}
