<%-- 
    Document   : polaridadTweetsFrecuentes
    Created on : 6/11/2017, 03:46:18 PM
    Author     : Kmilo
--%>

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
        <title>Polaridad</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <!--<body style="background-color: darkslategray">-->
    
        <BR><BR><BR> 
        
        <%String hash = new String(request.getParameter("Hashtag_Elegido").getBytes("ISO-8859-1"),"UTF-8"); %>
        <h1 style="color: black" align="center">Polaridad en los tweets del hashtag #<%=hash%></h1><BR><BR>
        
        <%    
            //Pruebas Locales
            //Mongo mg = new Mongo("localhost",27017);
            //Pruebas en cluster
            Mongo mg = new Mongo("172.24.99.98");
            
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_tweet");
            BasicDBObject whereQuery = new BasicDBObject();
            whereQuery.put("hashtag", hash);            
            DBCursor cursor = collection.find(whereQuery);       
            int cnt=0;
            while(cursor.hasNext()) {                
                DBObject str = cursor.next();
                %><h2 align="center">Tweet <%= cnt+1 %><%= " = " + str.get("text") + "\n" %> </h2><BR><%
                cnt++;
            }

            TextClassifier tc = new TextClassifier();
            tc.loadModel("D:\\01_ESTUDIOS\\MAESTRIA\\1_BIG_DATA\\TALLERES\\T3\\01_Enunciado_Entregables\\Prueba.model");            
            String retorno = tc.classify("camilo");
            System.out.println("Retorno = camilo se clasifica como " + retorno.toUpperCase());
        %>    
        <br><br>
        <p class="linkVolver" align="center">                
            <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
            <br>
            <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
        </p>
    </body>
</html>
