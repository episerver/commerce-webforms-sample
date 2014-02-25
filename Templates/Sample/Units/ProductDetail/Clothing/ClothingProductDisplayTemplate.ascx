<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ClothingProductDisplayTemplate.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.Clothing.ClothingProductDisplayTemplate" %>
<!-- Controls in Main Detail-->
<%@ Register Src="../SharedModules/ProductInfoPricing/CommonItemInfoPricing.ascx" TagName="ProductInfoPricing" TagPrefix="product" %>
<%@ Register Src="ClothingProductItemSelector.ascx" TagName="ProductItemSelector" TagPrefix="product" %>
<%@ Register Src="../SharedModules/CommonModule.ascx" TagName="Common" TagPrefix="product" %>
<!-- Control For Sharing Bar-->
<%@ Register Src="../SharedModules/ProductSocial/CommonProductSocial.ascx" TagName="ProductSocial" TagPrefix="product" %>

<div class="row C_Page-Header">
    <div class="col-md-12">
        <h1>
            <EPiServer:property runat="server" propertyname="DisplayName" />
        </h1>
        <h4>Short Copy to quickly Highlight the product from a marketing perspective or just drop this line completely. </h4>
        <hr />
    </div>
</div>
<div class="row C_Product-Detail">
    <div class="col-md-3 col-sm-6 C_Product-Images">
        <EPiServer:Property runat="server" ID="ProductImage" PropertyName="CommerceMediaCollection" CssClass="img-responsive" />
    </div>
    <div class="col-md-6 col-sm-6 C_Product-Detail">
        <product:ProductInfoPricing ID="ProductInfoPricingID" runat="server" />
    </div>
    <div class="col-md-3 col-sm-10 C_Product-ItemSelector">
        <product:ProductItemSelector ID="ProductItemSelectorID" runat="server" />
    </div>
    <div class="col-md-12 col-sm-2">
        <product:ProductSocial ID="ProductSocialID" runat="server" />
    </div>
</div>
<product:Common ID="ProductCommonModule" runat="server" />
