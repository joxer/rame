<html>
  <body>
    <script>
      var myRequest = null;
      
      function CreateXmlHttpReq(handler) {
      var xmlhttp = null;
      xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = handler;
      return xmlhttp;
      }
      
      function myHandler() {
      if (myRequest.readyState == 4 && myRequest.status == 200) {
      var ah = document.getElementById("a");
      ah.innerHTML =  myRequest.responseText;

      }
      }
      
      function esempio3() {
      var ah = document.getElementById("box");
      
      myRequest = CreateXmlHttpReq(myHandler);
      
      myRequest.open("POST","/method/socket/" + ah.value);
      myRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8"); 
      myRequest.send(null);
      }
    </script>
    <p>Inserisci il nome dei metodi. Scrivi :get+http://www.url.com</p>
    
    <input type="inputbox" value="" id="box" />
    <input type="button" value="Clicca per lanciare la richiesta" onClick="esempio3()" />
    <div id="a"></id>
  </body>
</html>
