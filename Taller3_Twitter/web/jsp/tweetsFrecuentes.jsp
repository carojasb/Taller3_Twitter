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
        
        <!-- Se registran estos para el cloud de palabras-->
        <script src="http://d3js.org/d3.v3.min.js"></script>
        <script src="../js/d3.layout.cloud.js"></script>
        <script src="../js/DrawWordCloud.js"></script>
        <link rel="stylesheet" href="../Resources/css/stylescloud.css">
         <!-------------------------------------------------------------->
        
    </head>
    <body>
    <!--<body style="background-color: darkslategray">-->
        <BR><BR><BR>        
        <%String cantidad = new String(request.getParameter("hashtags").getBytes("ISO-8859-1"),"UTF-8"); %>
        
        <h1 style="color: black" align="center"><b>Listado de los <%= cantidad %> hashtag más frecuentes</b></h1><BR><BR>
        
        <%  
            //Pruebas Locales
            Mongo mg = new Mongo("localhost",27017);
            
            //Pruebas en Cluster
            //Mongo mg = new Mongo("172.24.99.98");
            
            int cnt=0;
            String p;
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_tweet");
            BasicDBObject doc = new BasicDBObject();
            DBCursor cursor = collection.find().limit(Integer.parseInt(cantidad));
            
            //Agrupar por hashtag
            DBObject groupFields = new BasicDBObject( "_id", "$hashtag");            
            groupFields.put("count", new BasicDBObject( "$sum", 1));
            DBObject group = new BasicDBObject("$group", groupFields );
            DBObject sortFields = new BasicDBObject("count", -1);
            DBObject sort = new BasicDBObject("$sort", sortFields );
            
            AggregationOutput output = collection.aggregate(group, sort);
            
            String hashtag = null;
            int times = 0, incremento=0, disminuir=0;
            String vari = "";
            String opcion = "";
            
            for (DBObject obj : output.results()) {
                
                if (!obj.get("_id").toString().contains("SIN_HASHTAG")){   
                    
                    if (cnt < Integer.parseInt(cantidad)){
                        
                        hashtag = obj.get("_id").toString();
                        times = Integer.parseInt(obj.get("count").toString());

                        %><h2 align="center">Hashtag <%= cnt+1 %><%= " = #" + hashtag +" aparece "+ times + " veces" + "\n" %> </h2><BR><%
                        cnt++;                        
                        
                        if (cnt < Integer.parseInt(cantidad)){
                            vari = vari + "{\"text\":\"#"+hashtag+"\",\"size\":"+(times+incremento)+"},";
                            opcion = opcion + "<option value=\""+hashtag+"\">"+"#"+hashtag+"<//option>";
                            incremento = incremento - disminuir;
                        }else if (cnt == Integer.parseInt(cantidad)){
                            vari = vari + "{\"text\":\"#"+hashtag+"\",\"size\":"+(times+incremento)+"}";
                            opcion = opcion + "<option value=\""+hashtag+"\">"+"#"+hashtag+"<//option>";
                            incremento = incremento - disminuir;
                        }
                    }
                }
            }

            mg.close();
        %>
        
        <BR><BR>
        
        <div class="opciones_hashtag" align="center">
            <form name="Form_consultTweets" action="polaridadTweetsFrecuentes.jsp">
                <label style="color: black; font-size:18px">Consultar la polaridad en los tweets del hashtag </label>
                <select name="Hashtag_Elegido" id="Hashtag_Elegido">
                    <%=opcion%>
                </select>
                <BR><BR>
                <p class="BtnHashtagTweets">
                    <input type="submit" value="Buscar"/>
                </p><BR>

            </form>
        </div>
        
        <div align="center">
            <script>
                var frequency_list = [<%=vari%>];
                DrawWordCloud(frequency_list);
            </script>        
        </div>

        <div class="legend" align="center">
            Entre más frecuente el hashtag, más grandes se encuentra en el tagCloud.
        </div> 
        
        
        <br><br>
        <p class="linkVolver" align="center">                
            <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
            <br>
            <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
        </p>
    </body>
</html>
