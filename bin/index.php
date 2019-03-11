<html>
    <head>
        <title><? echo $_GET["swf"]; ?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <script type="text/javascript" src="swfobject/swfobject.js">
        </script>
        <script type="text/javascript">
            var date = new Date();
            swfobject.embedSWF("<? echo $_GET["swf"]; ?>.swf?id=" + date.getTime(), "container", "100%", "100%", "10.0.0", "swfobject/expressInstall.swf");
        </script>
        <style type="text/css">
            html, body {
                margin: 0px;
                padding: 0px;
                overflow: hidden;
            }
        </style>
    </head>
    <body>
        <div id="container">
            <h1>Alternative content</h1>
            <p>
                <a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
            </p>
        </div>
    </body>
</html>