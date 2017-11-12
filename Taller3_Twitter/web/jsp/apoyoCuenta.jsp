<%-- 
    Document   : apoyoCuenta
    Created on : 11/11/2017, 05:37:28 PM
    Author     : Kmilo
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="uniandes.edu.co.clasificador.TextClassifier"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.DB"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nivel de apoyo a las cuentas</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        
        <BR><BR><BR>
                
        <%String cuenta = new String(request.getParameter("Cuenta_elegida").getBytes("ISO-8859-1"),"UTF-8"); %>
        <h1 style="color: black" align="center"><b>Nivel de apoyo a la cuenta "<%=cuenta%>"</b></h1><br><br>
        <form name="Form_Button">
            <%
                //Pruebas Locales
                Mongo mg = new Mongo("localhost",27017);

                //Pruebas en Cluster
                //Mongo mg = new Mongo("172.24.99.98");

                int cnt=0, muynegativo=0, negativo=0, neutro=0, positivo=0, muypositivo=0;
                String p;
                DB db = mg.getDB("Grupo05");
                DBCollection collection = db.getCollection("grupo05_tweet");
                BasicDBObject doc = new BasicDBObject();
                BasicDBObject whereQuery = new BasicDBObject();
                whereQuery.put("mention1", cuenta);
                BasicDBObject subQuery = new BasicDBObject();
                subQuery.put("mention", whereQuery);
                DBCursor cursor = collection.find(subQuery);
                
                for(DBObject str : cursor){
                    String retorno = "";
                    TextClassifier tc = new TextClassifier();
                    tc.loadModel("F:\\Andes\\Entrenamiento\\Tweets.model");
                    //tc.loadModel("D:\\01_ESTUDIOS\\MAESTRIA\\1_BIG_DATA\\TALLERES\\T3\\01_Enunciado_Entregables\\Prueba.model");  //Pablo
                    //tc.loadModel("/home/estudiante/Prueba.model"); //Cluster
                    retorno = tc.classify(str.get("account").toString(), str.get("text").toString(), str.get("retweet").toString(), Integer.parseInt(str.get("countSeguidores").toString()), Integer.parseInt(str.get("countFavoritos").toString()), str.get("location").toString());
                    //retorno = "d";
                    if(retorno.equals("Muy Negativo")){
                        muynegativo ++;
                    }else if(retorno.equals("Negativo")){
                        negativo ++;
                    }else if(retorno.equals("Neutro")){
                        neutro ++;
                    }else if(retorno.equals("Positivo")){
                        positivo ++;
                    }else if(retorno.equals("Muy Positivo")){
                        muypositivo ++;
                    } 
                }
                
                int total_entero = muynegativo + negativo + neutro + positivo + muypositivo;
                Double total = (double) muynegativo + (double) negativo + (double) neutro + (double) positivo + (double) muypositivo;
                
                DecimalFormat df = new DecimalFormat("#.00");
                Double pmuynegativo = muynegativo / total * 100;
                Double pnegativo = negativo / total * 100;
                Double pneutro = neutro / total * 100;
                Double ppositivo = positivo / total * 100;
                Double pmuypositivo = muypositivo / total * 100;
                

            %>            
            <br><br><br>
            <p align="center">
                Se encontraron <%=total_entero%> tweets en donde se menciona la cuenta "<%=cuenta%>", a partir de esto se hizo la clasificación de los tweets para poder medir el nivel de apoyo.
            </p>
            <br>
            
            <div style="text-align:center;">
                <table BORDER WIDTH="40%" align="center" border=5 border-color = "black" id="myTable" class="myTable"
                                   CELLPADDING=4 CELLSPACING=4
                                    style="margin: 0 auto; font-size: 12pt; font-family: Comic Sans MS; background-color: lightsteelblue">                    
                    <tr>
                        <th><b>NIVEL DE APOYO</b></th>                    
                        <th><b>CANTIDAD TWEETS</b></th>                    
                        <th><b>PORCENTAJE (%)</b></th>
                    </tr>
                    <tr>
                        <td>Muy Negativo</td>
                        <td><%=muynegativo%></td>
                        <td><%=Math.rint(pmuynegativo*100)/100%>%</td>
                    </tr>
                    <tr>
                        <td>Negativo</td>
                        <td><%=negativo%></td>
                        <td><%=Math.rint(pnegativo*100)/100%>%</td>
                    </tr>
                    <tr>
                        <td>Neutro</td>
                        <td><%=neutro%>
                        <td><%=Math.rint(pneutro*100)/100%>%</td>
                    </tr>
                    <tr>
                        <td>Positivo</td>
                        <td><%=positivo%>
                        <td><%=Math.rint(ppositivo*100)/100%>%</td>
                    </tr>
                    <tr>
                        <td>Muy Negativo</td>
                        <td><%=muypositivo%>
                        <td><%=Math.rint(pmuypositivo*100)/100%>%</td>
                    </tr>
                    <tr>
                        <th><b>TOTAL</b></th>
                        <th><b><%=total_entero%></b></th>
                        <th><b>100%</b></th>
                    </tr>
                </table>
            </div>                        
        </form>
        <br><br>        
        <p class="linkVolver" align="center">                
            <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
            <br>
            <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
        </p>
    </body>
</html>