<%-- 
    Document   : principal
    Created on : 4/11/2017, 01:19:01 PM
    Author     : Kmilo
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import="com.mongodb.*"
        import="java.net.UnknownHostException"
        import="com.sun.org.apache.bcel.internal.generic.NEW"        
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Principal</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
            function validarCantidadVS() {
                //obteniendo el valor que se puso en campo text del formulario
                miCampoTexto = document.getElementById("cant_registros").value;
                //la condición
                if (miCampoTexto.length == 0) {
                    alert("Debe colocar la cantidad de registros");
                    return false;
                }
                return true;
            }
            
            function validarCantidad() {
                //obteniendo el valor que se puso en campo text del formulario
                miCampoTexto = document.getElementById("cantidad").value;
                //la condición
                if (miCampoTexto.length == 0) {
                    alert("Debe colocar la cantidad de Hashtags");
                    return false;
                }
                return true;
            }
            
            
            
            function validarSiNumero(numero){
                if (!/^([0-9])*$/.test(numero)) 
                    alert("El valor " + numero + " no es un número");
            }
        </script>
    </head>
    <body>
    <!--<body style="background-color: darkslategray">-->
        
        <BR><BR><BR>
        
        <h1 style="color: black" align="center"><b>Tweet Sentiment Analysis</b></h1><BR><BR><BR>            
        
        <form name="form_frecuentes" action="tweetsFrecuentes.jsp" onsubmit="return validarCantidad()" align="center">
            <fieldset style="background-color:darkgrey;"><br>
                <p class="BtntweetsFrecuentes" align="center">
                    <label style="color: black; font-size:18px"> Consultar los </label>
                    <input id="cantidad" type="text" name="hashtags" placeholder="Ej: 10" size="2" onChange="validarSiNumero(this.value);"/>
                    <label style="color: black; font-size:18px"> hashtags más frecuentes </label><BR><BR>
                    <input type="submit" value="Buscar" name="btn_tweetsFrecuentes" align="center"/>
                </p>
                </fieldset>
        </form>
              
        
        <BR><BR>
        
        <form name="form_seguidores" action="HistoricoSeguidores.jsp">                        
            <fieldset style="background-color:darkgrey;"><br>
                <p class="BtnHistorico" align="center">
                    <label style="color: black; font-size:18px">Consultar las estadísticas por cuenta </label><br><br>
                    <input type="submit" name="Consultar_Seguidores" value="Buscar" align="center" />
                    <input type ="text" name="Candidato_Elegido" value="AlvaroUribeVel" hidden="true"/>
                </p>
            </fieldset>
        </form>
        
        <br><br>
        
        <form name="form_apoyo" action="apoyoCuenta.jsp" align="center">
            <fieldset style="background-color:darkgrey;"><br>
                <p class="BtnConsultarApoyo" align="center">             
                    <% 
                        //Pruebas Locales
                        //Mongo mg = new Mongo("localhost",27017);

                        //Pruebas en Cluster
                        Mongo mg = new Mongo("172.24.99.98");

                        int cnt=0;
                        String p;
                        DB db = mg.getDB("Grupo05");
                        DBCollection collection = db.getCollection("grupo05_tweet");
                        BasicDBObject doc = new BasicDBObject();
                        DBCursor c = collection.find();
                        DBCursor cursor = c.sort(new BasicDBObject("account", -1));
                        
                        String opcion = "";
                        String validar_cuenta = "cuenta_inicial";
                       
                        for (DBObject cu : cursor){
                            if (!cu.get("account").toString().contains(validar_cuenta)){                                
                                opcion = opcion + "<option value=\""+cu.get("account").toString()+"\">"+cu.get("name").toString()+"<//option>";                                
                                validar_cuenta = cu.get("account").toString();
                            }
                        }
                        
                    %>
                    <label style="color: black; font-size:18px">Consultar el nivel de apoyo a la cuenta de </label>
                    <select name="Cuenta_elegida" id="Cuenta_elegida">                        
                        <%=opcion%>
                    </select>
                    <br><br>
                    <input type="submit" value="Buscar" name="btn_apoyoCuenta" align="center"/>
                </p>
                </fieldset>
        </form>
                    
        <br><br>

        <form name="form_ingles" action="tweetsIngles.jsp" onsubmit="return validarCantidadVS()" align="center">
            <fieldset style="background-color:darkgrey;"><br>
                <p class="BtnHistorico" align="center">
                    <label style="color: black; font-size:18px">Modelo anotado al 100% VS Modelo anotado al 20%</label><br><br>
                    <label style="color: black; font-size:18px">Consultar </label>
                    <input id="cant_registros" type="text" name="cant_registros" placeholder="Ej: 100" size="3" onChange="validarSiNumero(this.value);"/>
                    <label style="color: black; font-size:18px"> registros</label><br><br>
                    <input type="submit" name="Comparar_modelos" value="Buscar" align="center" />                    
                </p>
            </fieldset>
        </form>
        
        <BR><BR><BR>
        
        <p class="linkVolver" align="center">
            <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center" align="center">Inicio</a>
        </p>
        
    </body>
</html>
