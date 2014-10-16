<%@ Page Language="C#" CodeBehind="ImportSiteContent.aspx.cs" Inherits="EPiServer.Commerce.Sample.ImportSiteContent" EnableViewState="false" %>

<!DOCTYPE html>

<html>
<head id="HeaderTag" runat="server">
    <title>Importing Commerce Sample content</title>
    <meta http-equiv="refresh" content="5" runat="server" id="autoRefreshTag" />
    <style>
 	body {font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;font-size: 13px;background-color: #f9f9f9;}
 	progress {background-color: #ffd800;border: 0;height: 18px;border-radius: 9px;  width: 40%;}
 	progress::-webkit-progress-bar { background-color: #f3f3f3; border-radius: 9px;}
 	progress::-webkit-progress-value {background: #cdeb8e;background: -moz-linear-gradient(top,  #cdeb8e 0%, #a5c956 100%);background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#cdeb8e), color-stop(100%,#a5c956));background: -webkit-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: -o-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: -ms-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: linear-gradient(to bottom,  #cdeb8e 0%,#a5c956 100%);filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cdeb8e', endColorstr='#a5c956',GradientType=0 );border-radius: 9px;}
 	progress::-moz-progress-bar {background: #cdeb8e;background: -moz-linear-gradient(top,  #cdeb8e 0%, #a5c956 100%);background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#cdeb8e), color-stop(100%,#a5c956));background: -webkit-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: -o-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: -ms-linear-gradient(top,  #cdeb8e 0%,#a5c956 100%);background: linear-gradient(to bottom,  #cdeb8e 0%,#a5c956 100%);filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cdeb8e', endColorstr='#a5c956',GradientType=0 );border-radius: 9px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>Importing Commerce Sample Content.</h1>
        <progress id="progressbar" max="100" value="0" runat="server"></progress>
        <h2>Do not rebuild your solution until import has been completed.</h2>
        <asp:Label runat="server" ID="ImportLbl"></asp:Label>
    </div>
    </form>
</body>
</html>
