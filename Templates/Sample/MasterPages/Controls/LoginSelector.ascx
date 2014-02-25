<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginSelector.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls.LoginSelector" %>

<asp:LoginView ID="LoginView" runat="server" EnableViewState="false">
    <AnonymousTemplate>
            <a href="<%= GetLoginUrl() %>">Log In</a>
    </AnonymousTemplate>
    <LoggedInTemplate>
        <asp:LinkButton ID="logout" runat="server" Text="Log Out" OnClick="logout_ButtonClick" />
    </LoggedInTemplate>
</asp:LoginView>