<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SiteSubCategoryControl.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SiteSubCategoryControl" %>
<%@ Register Src="SharedModules/CategoryTopMenu.ascx" TagName="CategoryTopMenu" TagPrefix="catalog" %>
<%@ Register Src="SharedModules/CommonNodeList.ascx" TagName="NodeList" TagPrefix="catalog" %>
<div class="row C_Page-header">
    <div class="col-md-12">
        <catalog:CategoryTopMenu ID="CategoryTopMenuID" runat="server"></catalog:CategoryTopMenu>
        <h1>Shopping <%: ParentNodeName %> Store</h1>
        <h2><EPiServer:Property runat="server" PropertyName="DisplayName"></EPiServer:Property></h2>
        <hr />
        <EPiServer:Property PropertyName="Info_Description" runat="server" />
    </div>
</div>
<catalog:NodeList ID="NodeListID" runat="server" />