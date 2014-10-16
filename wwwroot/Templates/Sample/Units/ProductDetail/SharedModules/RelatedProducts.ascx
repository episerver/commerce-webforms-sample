<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="RelatedProducts.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.RelatedProducts" %>
<%@ Register Src="SimpleProductInfo.ascx" TagName="SimpleProductInfo" TagPrefix="product" %>

<asp:Repeater runat="server" ID="RelatedProductsRepeater">
    <HeaderTemplate>
        <div class="row">
    </HeaderTemplate>
    <ItemTemplate>
        <div class="col-lg-2 col-md-3 col-sm-4">
            <product:SimpleProductInfo runat="server" CurrentData="<%# Container.DataItem as EPiServer.Commerce.Catalog.ContentTypes.EntryContentBase %>" />
        </div>
    </ItemTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>

