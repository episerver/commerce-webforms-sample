<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master"
    Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ShoppingOverview"
    CodeBehind="ShoppingOverview.aspx.cs" %>

<%@ Register Src="../Units/Shopping/CatalogNodeList.ascx" TagName="CatalogNodeList"
    TagPrefix="catalog" %>
<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <h1>
                <EPiServer:Property PropertyName="PageTitle" ID="PageTitleID" runat="server" />
            </h1>
            <h4 class="subheader">
                <EPiServer:Property PropertyName="PageSubHeader" ID="PageSubHeaderID" runat="server" />
            </h4>
            <hr>
        </div>
    </div>
    <div class="row C_Business-Control1">
        <div class="col-sm-3">
            <catalog:CatalogNodeList runat="server" ID="CatalogNodeList">
            </catalog:CatalogNodeList>
        </div>
        <div class="col-sm-9">
            <EPiServer:Property PropertyName="BodyMarkup" ID="BodyMarkupID" runat="server" />
        </div>
    </div>
</asp:Content>
