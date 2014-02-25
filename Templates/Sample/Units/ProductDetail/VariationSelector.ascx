<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="VariationSelector.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.VariationSelector" %>
<%@ Register TagPrefix="product" TagName="AddToCart" Src="~/Templates/Sample/Units/ProductDetail/SharedModules/AddToCart.ascx" %>
<%@ Register TagPrefix="product" TagName="ProductPromotions" Src="~/Templates/Sample/Units/ProductDetail/SharedModules/ProductPromotions.ascx" %>
<%@ Register TagPrefix="product" TagName="ProductWarehouseInfo" Src="~/Templates/Sample/Units/ProductDetail/SharedModules/ProductWarehouseInfo.ascx" %>
<%@ Register TagPrefix="product" TagName="EntryPriceInfo" Src="~/Templates/Sample/Units/ProductDetail/VariationPriceInfo.ascx" %>
<div class="well">
    <product:EntryPriceInfo runat="server"/>
    <hr />
    <product:ProductPromotions runat="server" ID="ProductPromotions"></product:ProductPromotions>
    <product:AddToCart runat="server" ID="AddToCart"></product:AddToCart>
    <hr />
    <ul class="list-unstyled">
        <product:ProductWarehouseInfo runat="server" ID="ProductWarehouseInfo"></product:ProductWarehouseInfo>
    </ul>
</div>