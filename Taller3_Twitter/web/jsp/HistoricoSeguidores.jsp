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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historico de Seguidores</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
        <script src="https://d3js.org/d3.v4.min.js"></script>
       
    </head>
    
    <body>
        <div class="Imagenes">
        <img src="../Resources/images/Petro.jpg" border="0" width="80" height="120">
        <img src="../Resources/images/VargasLleras.jpg" border="0" width="80" height="120">
         <script src="../js/LineChartSeguidores.js"></script>
        </div>
        <div class="Line_chart">
        <script>
            LineChartSeguidores();
        </script>
        </div>        
    </body>
</html>
