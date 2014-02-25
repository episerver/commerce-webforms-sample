<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CategoryTopMenu.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules.CategoryTopMenu" %>
<%@ Import Namespace="EPiServer.Commerce.Catalog.ContentTypes" %>

<div class="btn-group C_Catalog_TopMenu">
    <asp:HyperLink ID="HyperLink3" CssClass="btn btn-info" runat="server" NavigateUrl='<%# GetUrl(CategoryParentNode) %>'>
        <i class="glyphicon glyphicon-shopping-cart"></i> <%# GetDisplayName(CategoryParentNode) %>
    </asp:HyperLink>
     <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
    <ul class="dropdown-menu">
        <asp:Repeater EnableViewState="false" runat="server" ID="CatalogNodes">
            <ItemTemplate>
                <li>
                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# GetUrl((NodeContent) Container.DataItem) %>'>
                                    <%# GetDisplayName(Container.DataItem as NodeContent) %>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>

    </ul>
</div> 