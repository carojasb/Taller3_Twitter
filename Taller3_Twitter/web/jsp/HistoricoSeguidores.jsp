<%-- 
    Document   :  (10%) Realice un análisis del histórico de seguidores de las cuentas que seleccione. 
                  Identifique si hay un cambio significativo de seguidores 
                  Analice los contenidos que ellos publican. 
                  Identifique si hay seguidores o interacciones con usuarios que son potencialmente identificados como perfiles robot. 
                  Haga un análisis de retuits, respuestas y citas para apoyar su conclusión sobre el punto anterior. 
                  Incluya en su análisis la característica de tuit favorito (anotado con ). 
    Created on : 4/11/2017, 04:38:25 PM
    Author     : Pablo
--%>

<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.DBCursor"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="com.mongodb.DBCollection"%>
<%@page import="com.mongodb.Mongo"%>
<%@page import="com.mongodb.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historico de Seguidores</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
        <script src="https://d3js.org/d3.v4.min.js"></script>
        <script src="../js/LineChartSeguidores.js"></script>
     </head>
    
    <body>
        <div class="Line_chart">
          <form name="Form_Button" action="HistoricoSeguidores.jsp" onsubmit="return consultar_seguidores()">     
            <!--<img src="../Resources/images/Petro.jpg" border="0" width="80" height="120">
            <img src="../Resources/images/VargasLleras.jpg" border="0" width="80" height="120">-->
             <select name="Candidato_Elegido" id="candidatos">
                <option value="German_Vargas">German Vargas Lleras</option> 
                <option value="IvanDuque">IvanDuque</option> 
                <option value="mluciaramirez">Marta Lucía Ramírez</option> 
                <option value="sergio_fajardo">Sergio Fajardo</option>                 
                <option value="DeLaCalleHum">Humberto de la Calle</option> 
                <option value="petrogustavo">Gustavo Petro</option> 
                <option value="CristoBustos">Juan Fernando Cristo</option> 
                <option value="MoralesViviane">Viviane Morales</option>
                <option value="PinzonBueno">Pinzón Bueno</option>
                 <option value="RafaelPardo">Rafael Pardo</option> 
                <option value="ClaudiaLopez">Claudia López</option> 
                <option value="AlvaroUribeVel">Álvaro Uribe Vélez</option>
                <option value="IvanCepedaCast">Iván Cepeda Castro</option> 
            </select>
                <p class="BtnSeguidores">
                    <input type="submit"/>
                </p><BR><BR>
          </form>
          
            <%
            String CuentaConsultar = new String(request.getParameter("Candidato_Elegido").getBytes("ISO-8859-1"),"UTF-8");
            System.out.println("Cuenta a consultar seguidores: " + CuentaConsultar);
            Mongo mg = new Mongo("localhost",27017);
            DB db = mg.getDB("Grupo05");
            DBCollection collection = db.getCollection("grupo05_tweet");
            BasicDBObject whereQuery = new BasicDBObject();
            whereQuery.put("account", CuentaConsultar);
            DBCursor cursor = collection.find(whereQuery);
            String documento_graficar = "{" + "\"" + "Tweet"+ "\"" + ": [";
            while(cursor.hasNext()) {
                //System.out.println(cursor.next());
                DBObject str = cursor.next();
                documento_graficar = documento_graficar + str.toString() + ",";              
            }
            documento_graficar =  documento_graficar + "]}";
            String documento_final = documento_graficar.replace("},]}", "}]}");
            System.out.println(documento_final);
            %>    
            <script>
                var documento_json = <%= documento_final%>   
                var country = "Tweet"
                LineChartSeguidores(documento_json,country);
            </script>                
        </div>  
    </body>
</html>
