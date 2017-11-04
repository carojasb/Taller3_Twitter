<%-- 
    Document   : principal
    Created on : 4/11/2017, 01:19:01 PM
    Author     : Kmilo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Principal</title>
        <link href="../Resources/css/screen.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
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
    <body style="background-color: darkslategray"><BR><BR><BR>
        <form name="form_index" action="tweetsFrecuentes.jsp" onsubmit="return validarCantidad()">
            
            <h1 style="color: black" align="center">Tweet Sentiment Analysis</h1><BR><BR><BR>            
            
                <p class="BtntweetsFrecuentes" align="center">
                    <label style="color: black; font-size:18px"> Buscar los </label>
                    <input id="cantidad" type="text" name="hashtags" placeholder="Ej: 0" size="1" onChange="validarSiNumero(this.value);"/>
                    <label style="color: black; font-size:18px"> hashtags más frecuentes </label><BR><BR>
                    <input type="submit" value="Buscar" name="btn_tweetsFrecuentes" align="center"/>
                </p><BR><BR>
               
            <p class="linkVolver" align="center">
                <a href="../index.jsp" style="font-size: 15pt; font-family: Comic Sans MS; color: white; align-items: center" align="center">Inicio</a>
            </p>
        </form>
    </body>
</html>