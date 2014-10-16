<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="SiteCatalogControl.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SiteCatalogControl" %>
<%@ Import Namespace="EPiServer.Commerce.Catalog.ContentTypes" %>
<%@ Register Src="SharedModules/CategoryTopMenu.ascx" TagName="CategoryTopMenu" TagPrefix="catalog" %>
<%@ Register Src="SharedModules/CommonNodeList.ascx" TagName="NodeList" TagPrefix="catalog" %>

<catalog:CategoryTopMenu ID="CategoryTopMenuID" runat="server" />
<div class="row C_Page-header">
    <div class="col-md-12">
        <div class="jumbotron">
            <h1><%=HttpUtility.HtmlEncode(CurrentData.Name) %></h1>
        </div>
    </div>
</div>

<asp:Repeater runat="server" ID="rptDepartments">
    <ItemTemplate>
        <h2>
            <EPiServer:Property runat="server" PropertyName="DisplayName"></EPiServer:Property>
        </h2>
        <catalog:NodeList runat="server" CurrentData="<%# (CatalogContentBase)Container.DataItem %>" />
    </ItemTemplate>
</asp:Repeater>