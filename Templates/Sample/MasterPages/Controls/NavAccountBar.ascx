<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="NavAccountBar.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls.NavAccountBar" EnableViewState="false" %>
<%@ Register TagPrefix="CMSNav" TagName="LoginSelector" Src="LoginSelector.ascx" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<li class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="<%= GetLoginUrl() %>">
<nav class="account-bar">
    <asp:LoginView ID="LoginView" runat="server" EnableViewState="false">
        <AnonymousTemplate>
            <span class="visible-xs glyphicon glyphicon-user"></span>
            <span class="hidden-xs">
                Log In <i class="caret"></i>
            </span>
        </AnonymousTemplate>
        <LoggedInTemplate>
            <span class="visible-xs glyphicon glyphicon-user"></span>
            <span class="hidden-xs">
                <%=WebStringHelper.EncodeForWebString(Mediachase.Commerce.Customers.CustomerContext.Current.CurrentContactName) %>
                <i class="caret"></i>
            </span>
        </LoggedInTemplate>
    </asp:LoginView>
</nav>
    </a>
    <ul class="dropdown-menu">
        <li><a href="<%= GetAccountInfoUrl() %>">Account Info</a></li>
        <li><a href="<%= GetYourOrdersUrl() %>">Orders History</a></li>
        <li><a href="<%= GetAddressesUrl() %>">Addresses Book</a></li>
        <li><a href="<%= GetWishListUrl() %>">Wish List</a></li>
        <li class="divider"></li>
        <li>
            <CMSNav:LoginSelector ID="LoginSelectorID" runat="server" />
        </li>
    </ul>
</li>