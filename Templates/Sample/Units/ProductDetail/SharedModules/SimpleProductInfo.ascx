<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="SimpleProductInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.SimpleProductInfo" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<%@ Register Src="ProductInfoPricing/ProductPriceDetails.ascx" TagName="ProductPriceDetails" TagPrefix="product" %>
<%@ Register Src="AddToCart.ascx" TagName="AddToCart" TagPrefix="product" %>

<div class="thumbnail">
    <a href="<%# GetUrl(CurrentData) %>">
        <EPiServer:Property runat="server" PropertyName="CommerceMediaCollection" CssClass="img-responsive"></EPiServer:Property>
    </a>
    <div class="caption">
        <a href="<%# GetUrl(CurrentData) %>"><%# WebStringHelper.EncodeForWebString(CurrentData.DisplayName) %></a>
        <hr />
        <product:ProductPriceDetails runat="server" ID="PriceDetailsControl" />
        <hr />
        <product:AddToCart runat="server" ID="AddToCartControl" />
    </div>
</div>

