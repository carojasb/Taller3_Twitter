/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uniandes.edu.co.conexion;

import com.mongodb.*;
import java.net.UnknownHostException;

/**
 *
 * @author Kmilo
 */
public class mongoConector {
    
    final String HOST = "localhost";
    final int PORT = 27017;
    final String DBNAME = "basetwitter";
    public static mongoConector instance;
    public Mongo connection;
    public DB database;
    
    private mongoConector() throws UnknownHostException{
        this.connection = new Mongo(this.HOST, this.PORT);
        this.database = this.connection.getDB(this.DBNAME);
    }
    
    public static mongoConector createInstance () throws UnknownHostException{
        if (mongoConector.instance == null){
            mongoConector.instance = new mongoConector();
        }
        return mongoConector.instance;
    }
    
    public DBCollection getCollection(String name){
        return this.database.getCollection(name);
    }
}
