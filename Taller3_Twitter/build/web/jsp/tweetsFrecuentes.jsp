<%-- 
    Document   : tweetsFrecuentes
    Created on : 4/11/2017, 01:26:47 PM
    Author     : Kmilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="com.mongodb.*"
        import="java.net.UnknownHostException"
        import="com.sun.org.apache.bcel.internal.generic.NEW"        
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tweets Frecuentes</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
    </head>
    <body style="background-color: darkslategray"><BR><BR><BR>
        
        <%String cantidad = new String(request.getParameter("hashtags").getBytes("ISO-8859-1"),"UTF-8"); %>
        
        <h1 style="color: black" align="center">Listado de los <%= cantidad %> hashtag más frecuentes </h1><BR><BR>
        
        <%  Mongo mg = new Mongo("localhost",27017);
            int cnt=0, c=0;
            String p;
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_tweet");
            BasicDBObject doc = new BasicDBObject();
            DBCursor cursor = collection.find().limit(Integer.parseInt(cantidad));
            
            
            
            doc = new BasicDBObject();
            try {
	
                while(cursor.hasNext()) 
                {
                      DBObject str = cursor.next();
                      
                      %><h2>Hashtag <%= cnt+1 %><%= " = " + str.get("text") + "\n" %> </h2><BR><%
                      cnt++;
                }
            }finally 
                    {
                    if(c==cnt)
                    {
                           %><center> No se encontró nada<br><br><strong><a href="javascript:history.go(-1)">Try Again</a></strong></center> <% 
                    }
                       cursor.close();
                    }            
        
            mg.close();
        %>
    
        <br>
        <p class="linkVolver" align="center">                
        <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
        <br>
        <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
    </body>
</html>
