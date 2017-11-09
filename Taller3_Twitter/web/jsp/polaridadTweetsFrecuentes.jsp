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
        <h1 style="color: black" align="center"><b>Polaridad en los tweets del hashtag #<%=hash%></b></h1><BR><BR>
        
        <%    
            //Pruebas Locales
            Mongo mg = new Mongo("localhost",27017);
            
            //Pruebas en cluster
            //Mongo mg = new Mongo("172.24.99.98");
            
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_tweet");
            BasicDBObject whereQuery = new BasicDBObject();
            whereQuery.put("hashtag", hash);            
            DBCursor cursor = collection.find(whereQuery);       
            int cnt=0, muymalo=0, malo=0, neutral=0, bueno=0, muybueno=0;
            
            %>             
            <table BORDER WIDTH="80%" align="center" border=5 border-color = "black" id="myTable" class="myTable"
                               CELLPADDING=4 CELLSPACING=4
                                style="margin: 0 auto; font-size: 12pt; font-family: Comic Sans MS; background-color: lightsteelblue">
                <tr>
                    <th><b>ID</b></th>
                    <th><b>TWEET</b></th>
                    <th><b>CLASIFICACIÓN</b></th>
                </tr><%            
                    while(cursor.hasNext()) {                
                        DBObject str = cursor.next();%>
                        <tr>
                            <td align="center"><b><%= cnt+1 %></b></td>
                            <td><%= str.get("text")%> </td><% 
                                cnt++;
                                TextClassifier tc = new TextClassifier();
                                tc.loadModel("F:\\Andes\\Prueba.model");  //Camilo     
                                //tc.loadModel("D:\\01_ESTUDIOS\\MAESTRIA\\1_BIG_DATA\\TALLERES\\T3\\01_Enunciado_Entregables\\Prueba.model");  //Pablo
                                //tc.loadModel("/home/estudiante/Prueba.model"); //Cluster
                                String retorno = tc.classify(str.get("text").toString());
                                if(retorno.equals("muyMalo")){
                                    muymalo ++;
                                }else if(retorno.equals("Malo")){
                                    malo ++;
                                }else if(retorno.equals("Neutro")){
                                    neutral ++;
                                }else if(retorno.equals("Bueno")){
                                    bueno ++;
                                }else if(retorno.equals("MuyBueno")){
                                    muybueno ++;
                                }
                                %>
                            <td align="center"><%=retorno%></td>
                        </tr><%
                    }%>
                <%                    
            mg.close();%>
            </table><br><br><br><br>
            <div style="text-align:center;">
                <table BORDER WIDTH="25%" align="center" border=5 border-color = "black" id="myTable" class="myTable"
                                   CELLPADDING=4 CELLSPACING=4
                                    style="margin: 0 auto; font-size: 12pt; font-family: Comic Sans MS; background-color: lightsteelblue">
                    <caption style="font-size: 20pt"><b>RESUMEN CLASIFICACIÓN</b></caption>
                    <tr>
                        <th>CLASIFICACIÓN</th>
                        <th>CANTIDAD</th>
                    </tr>
                    <tr>
                        <td>Muy Malo</td>
                        <td><%=muymalo%></td>
                    </tr>
                    <tr>
                        <td>Malo</td>
                        <td><%=malo%></td>
                    </tr>
                    <tr>
                        <td>Neutral</td>
                        <td><%=neutral%></td>
                    </tr>
                    <tr>
                        <td>Bueno</td>
                        <td><%=bueno%></td>
                    </tr>
                    <tr>
                        <td>Muy Bueno</td>
                        <td><%=muybueno%></td>
                    </tr>
                </table>
            </div>
        <br><br>
        <p class="linkVolver" align="center">                
            <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
            <br>
            <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
        </p>
    </body>
</html>
