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
            
            //Agrupar por hashtag
            DBObject groupFields = new BasicDBObject( "_id", "$hashtag");            
            groupFields.put("count", new BasicDBObject( "$sum", 1));
            DBObject group = new BasicDBObject("$group", groupFields );            
            DBObject sortFields = new BasicDBObject("count", -1);
            DBObject sort = new BasicDBObject("$sort", sortFields );
            
            AggregationOutput output = collection.aggregate(group, sort);            
            
            for (DBObject obj : output.results()) {
                
                if (!obj.get("_id").toString().contains("SIN_HASHTAG")){   
                    
                    if (cnt < Integer.parseInt(cantidad)){
                        
                        String hashtag = obj.get("_id").toString();
                        int times = Integer.parseInt(obj.get("count").toString());

                        %><h2>Hashtag <%= cnt+1 %><%= " = #" + hashtag +" aparece "+ times + " veces" + "\n" %> </h2><BR><%    
                        cnt++;
                        
                    }
                }
            }
        %>
        
        
        <script>
            var frequency_list = [{"text":"study","size":40},{"text":"motion","size":15},{"text":"forces","size":10},{"text":"electricity","size":15},{"text":"movement","size":10},{"text":"relation","size":5},{"text":"things","size":10},{"text":"force","size":5},{"text":"ad","size":5},{"text":"energy","size":85},{"text":"living","size":5},{"text":"nonliving","size":5},{"text":"laws","size":15},{"text":"speed","size":45},{"text":"velocity","size":30},{"text":"define","size":5},{"text":"constraints","size":5},{"text":"universe","size":10},{"text":"physics","size":120},{"text":"describing","size":5},{"text":"matter","size":90},{"text":"physics-the","size":5},{"text":"world","size":10},{"text":"works","size":10},{"text":"science","size":70},{"text":"interactions","size":30},{"text":"studies","size":5},{"text":"properties","size":45},{"text":"nature","size":40},{"text":"branch","size":30},{"text":"concerned","size":25},{"text":"source","size":40},{"text":"google","size":10},{"text":"defintions","size":5},{"text":"two","size":15},{"text":"grouped","size":15},{"text":"traditional","size":15},{"text":"fields","size":15},{"text":"acoustics","size":15},{"text":"optics","size":15},{"text":"mechanics","size":20},{"text":"thermodynamics","size":15},{"text":"electromagnetism","size":15},{"text":"modern","size":15},{"text":"extensions","size":15},{"text":"thefreedictionary","size":15},{"text":"interaction","size":15},{"text":"org","size":25},{"text":"answers","size":5},{"text":"natural","size":15},{"text":"objects","size":5},{"text":"treats","size":10},{"text":"acting","size":5},{"text":"department","size":5},{"text":"gravitation","size":5},{"text":"heat","size":10},{"text":"light","size":10},{"text":"magnetism","size":10},{"text":"modify","size":5},{"text":"general","size":10},{"text":"bodies","size":5},{"text":"philosophy","size":5},{"text":"brainyquote","size":5},{"text":"words","size":5},{"text":"ph","size":5},{"text":"html","size":5},{"text":"lrl","size":5},{"text":"zgzmeylfwuy","size":5},{"text":"subject","size":5},{"text":"distinguished","size":5},{"text":"chemistry","size":5},{"text":"biology","size":5},{"text":"includes","size":5},{"text":"radiation","size":5},{"text":"sound","size":5},{"text":"structure","size":5},{"text":"atoms","size":5},{"text":"including","size":10},{"text":"atomic","size":10},{"text":"nuclear","size":10},{"text":"cryogenics","size":10},{"text":"solid-state","size":10},{"text":"particle","size":10},{"text":"plasma","size":10},{"text":"deals","size":5},{"text":"merriam-webster","size":5},{"text":"dictionary","size":10},{"text":"analysis","size":5},{"text":"conducted","size":5},{"text":"order","size":5},{"text":"understand","size":5},{"text":"behaves","size":5},{"text":"en","size":5},{"text":"wikipedia","size":5},{"text":"wiki","size":5},{"text":"physics-","size":5},{"text":"physical","size":5},{"text":"behaviour","size":5},{"text":"collinsdictionary","size":5},{"text":"english","size":5},{"text":"time","size":35},{"text":"distance","size":35},{"text":"wheels","size":5},{"text":"revelations","size":5},{"text":"minute","size":5},{"text":"acceleration","size":20},{"text":"torque","size":5},{"text":"wheel","size":5},{"text":"rotations","size":5},{"text":"resistance","size":5},{"text":"momentum","size":5},{"text":"measure","size":10},{"text":"direction","size":10},{"text":"car","size":5},{"text":"add","size":5},{"text":"traveled","size":5},{"text":"weight","size":5},{"text":"electrical","size":5},{"text":"power","size":5}];
            DrawWordCloud(frequency_list);
        </script>
        <div style="width: 40%;">
            <div class="legend">
                Commonly used words are larger and slightly faded in color.  Less common words are smaller and darker.
            </div>
        </div>
        <br>
        <p class="linkVolver" align="center">                
        <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Inicio </a>
        <br>
        <a href="principal.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center"> Volver </a>
    </body>
</html>
