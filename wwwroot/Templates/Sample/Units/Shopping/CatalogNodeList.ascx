<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CatalogNodeList.ascx.cs"
    Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Shopping.CatalogNodeList" %>
<%@ Import Namespace="EPiServer.Commerce.Catalog.ContentTypes" %>

<div class="well">
    <h4>
        Available Catalogs
    </h4>
    <p>
        These are catalogs you currently have defined as active in EPiServer Commerce.
    </p>
    <asp:Repeater EnableViewState="False" runat="server" ID="CatalogNodes">
        <HeaderTemplate>
            <ul class="nav nav-list">
               <li class="nav-header">
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# GetUrl(CategoryParentNode) %>'>                    
                    <%# GetDisplayName(CategoryParentNode, true) %>
                </asp:HyperLink>
              </li>
        </HeaderTemplate>
        <FooterTemplate></ul></FooterTemplate>
        <ItemTemplate>
            <li>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# GetUrl((NodeContent) Container.DataItem) %>'>
                              <i class="glyphicon glyphicon-book"></i>  <%# GetDisplayName(Container.DataItem as NodeContent, false) %>
                </asp:HyperLink>
            </li>
        </ItemTemplate>
    </asp:Repeater>
</div>
