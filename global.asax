<%@ Application Language="C#" Inherits="EPiServer.Global" %>

<script RunAt="server">
protected void Application_AuthenticateRequest(Object sender, EventArgs e)
{
    var authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
    if (authCookie == null)
        return;
        
    //Extract the forms authentication cookie
    var authTicket = FormsAuthentication.Decrypt(authCookie.Value);

    // If caching roles in userData field then extract
    var roles = authTicket.UserData.Split(new char[]{'|'});

    
}
</script>
