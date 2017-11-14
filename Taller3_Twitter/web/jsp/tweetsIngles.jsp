<%-- 
    Document   : tweetsIngles
    Created on : 13/11/2017, 08:28:58 PM
    Author     : Kmilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="com.mongodb.*"
        import="java.net.UnknownHostException"
        import="com.sun.org.apache.bcel.internal.generic.NEW"        
        %>
<%@page import="uniandes.edu.co.clasificador.TextClassifier"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tweets en Inglés</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <BR><BR><BR>        
        
        <%String cantidad = new String(request.getParameter("cant_registros").getBytes("ISO-8859-1"),"UTF-8"); %>
        <h1 style="color: black" align="center"><b>Modelo anotado al 100% VS Modelo anotado al 20%</b></h1><BR><BR>
        
        <%
            //Pruebas Locales
            Mongo mg = new Mongo("localhost",27017);

            //Pruebas en Cluster
            //Mongo mg = new Mongo("172.24.99.98");

            int cnt=0, negative_anotado=0, positive_anotado=0, mixed_anotado=0, other_anotado=0, 
                    negative_entrenado=0, positive_entrenado=0, mixed_entrenado=0, other_entrenado=0;
            String p;
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_eng");            
            BasicDBObject whereQuery = new BasicDBObject();
            DBObject sortFields = new BasicDBObject("tweet_id", -1);
            //DBObject sort = new BasicDBObject("$sort", sortFields );            
            DBCursor cursor = collection.find().sort(sortFields).limit(Integer.parseInt(cantidad));
            
            for(DBObject str : cursor){
                //Anotado al 100%
                String retornoAnotado = "";
                TextClassifier tcAnotado = new TextClassifier();
                tcAnotado.loadModel("F:\\Andes\\Entrenamiento\\Ingles\\Ingles_anotado.model");
                retornoAnotado = tcAnotado.classifyIngles(Integer.parseInt(str.get("tweet_id").toString()), str.get("fec_pub").toString(), str.get("content").toString(), str.get("authorname").toString(),
                        str.get("author_nickname").toString(), str.get("rating1").toString(), str.get("rating2").toString(), str.get("rating3").toString(), str.get("rating4").toString());
                
                if(retornoAnotado.equals("negative")){
                    negative_anotado ++;
                }else if(retornoAnotado.equals("positive")){
                    positive_anotado ++;
                }else if(retornoAnotado.equals("mixed")){
                    mixed_anotado ++;
                }else if(retornoAnotado.equals("other")){
                    other_anotado ++;
                }                
                
                //Entrenado al 20%
                String retornoEntrenado = "";
                TextClassifier tcEntrenado = new TextClassifier();
                tcEntrenado.loadModel("F:\\Andes\\Entrenamiento\\Ingles\\Ingles_entrenado.model");
                retornoEntrenado = tcEntrenado.classifyIngles(Integer.parseInt(str.get("tweet_id").toString()), str.get("fec_pub").toString(), str.get("content").toString(), str.get("authorname").toString(),
                        str.get("author_nickname").toString(), str.get("rating1").toString(), str.get("rating2").toString(), str.get("rating3").toString(), str.get("rating4").toString());
                
                if(retornoEntrenado.equals("negative")){
                    negative_entrenado ++;
                }else if(retornoEntrenado.equals("positive")){
                    positive_entrenado ++;
                }else if(retornoEntrenado.equals("mixed")){
                    mixed_entrenado ++;
                }else if(retornoEntrenado.equals("other")){
                    other_entrenado ++;
                }                
            }
            
            
            //Anotado al 100%
            int total_entero_anotado = negative_anotado + positive_anotado + mixed_anotado + other_anotado;
            Double total_anotado = (double) negative_anotado + (double) positive_anotado + (double) mixed_anotado + (double) other_anotado;
            String ptotal_anotado = "";

            if (total_anotado > 0){
                ptotal_anotado = "100";
            }else{
                ptotal_anotado = "0.0";
            }

            Double pnegative_anotado = 0.00;
            Double ppositive_anotado = 0.00;
            Double pmixed_anotado = 0.00;
            Double pother_anotado = 0.00;

            if (negative_anotado > 0){
                pnegative_anotado = negative_anotado / total_anotado * 100;
            }
            if (positive_anotado > 0){
                ppositive_anotado = positive_anotado / total_anotado * 100;
            }
            if (mixed_anotado > 0){
                pmixed_anotado = mixed_anotado / total_anotado * 100;
            }
            if (other_anotado > 0){
                pother_anotado = other_anotado / total_anotado * 100;
            }
            

            //Entrenado al 20%
            int total_entero_entrenado = negative_entrenado + positive_entrenado + mixed_entrenado + other_entrenado;
            Double total_entrenado = (double) negative_entrenado + (double) positive_entrenado + (double) mixed_entrenado + (double) other_entrenado;
            String ptotal_entrenado = "";

            if (total_entrenado > 0){
                ptotal_entrenado = "100";
            }else{
                ptotal_entrenado = "0.0";
            }

            Double pnegative_entrenado = 0.00;
            Double ppositive_entrenado = 0.00;
            Double pmixed_entrenado = 0.00;
            Double pother_entrenado = 0.00;

            if (negative_entrenado > 0){
                pnegative_entrenado = negative_entrenado / total_entrenado * 100;
            }
            if (positive_entrenado > 0){
                ppositive_entrenado = positive_entrenado / total_entrenado * 100;
            }
            if (mixed_entrenado > 0){
                pmixed_entrenado = mixed_entrenado / total_entrenado * 100;
            }
            if (other_entrenado > 0){
                pother_entrenado = other_entrenado / total_entrenado * 100;
            }            
        %>
        
        <br><br><br>
            
        <div style="text-align:center;">
            <table BORDER WIDTH="60%" align="center" border=5 border-color = "black" id="myTable" class="myTable"
                               CELLPADDING=4 CELLSPACING=4
                                style="margin: 0 auto; font-size: 12pt; font-family: Comic Sans MS; background-color: lightsteelblue">                    
                <tr>
                    <th><b>CLASIFICACION</b></th>                    
                    <th><b>MODELO ANOTADO AL 100% (CANT)</b></th>                    
                    <th><b>MODELO ANOTADO AL 100% (%)</b></th>
                    <th><b>MODELO ANOTADO AL 20% (CANT)</b></th>                    
                    <th><b>MODELO ANOTADO AL 20% (%)</b></th>
                </tr>
                <tr>
                    <td>Negative</td>
                    <td><%=negative_anotado%></td>
                    <td><%=Math.rint(pnegative_anotado*100)/100%>%</td>
                    <td><%=negative_entrenado%></td>
                    <td><%=Math.rint(pnegative_entrenado*100)/100%>%</td>
                </tr>
                <tr>
                    <td>Positive</td>
                    <td><%=positive_anotado%></td>
                    <td><%=Math.rint(ppositive_anotado*100)/100%>%</td>
                    <td><%=positive_entrenado%></td>
                    <td><%=Math.rint(ppositive_entrenado*100)/100%>%</td>
                </tr>
                <tr>
                    <td>Mixed</td>
                    <td><%=mixed_anotado%>
                    <td><%=Math.rint(mixed_anotado*100)/100%>%</td>
                    <td><%=mixed_entrenado%>
                    <td><%=Math.rint(mixed_entrenado*100)/100%>%</td>
                </tr>
                <tr>
                    <td>Other</td>
                    <td><%=other_anotado%>
                    <td><%=Math.rint(pother_anotado*100)/100%>%</td>
                    <td><%=other_entrenado%>
                    <td><%=Math.rint(pother_entrenado*100)/100%>%</td>
                </tr>                
                <tr>
                    <th><b>TOTAL</b></th>
                    <th><b><%=total_entero_anotado%></b></th>
                    <th><b><%=ptotal_anotado%>%</b></th>
                    <th><b><%=total_entero_entrenado%></b></th>
                    <th><b><%=ptotal_entrenado%>%</b></th>
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
