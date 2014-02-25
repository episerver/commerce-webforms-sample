<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="VariationPriceInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.VariationPriceInfo" %>
List Price: <strike><asp:Label runat="server" ID="ListPrice"></asp:Label></strike><br />
Discount Pricing: <strong><asp:Label runat="server" ID="DiscountPricing"></asp:Label></strong><br />
You Save: <strong><asp:Label runat="server" ID="Savings"></asp:Label></strong>