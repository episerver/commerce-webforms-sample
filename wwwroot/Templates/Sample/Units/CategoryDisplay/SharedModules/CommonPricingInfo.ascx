<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommonPricingInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules.CommonPricingInfo" %>
<ul class="list-unstyled">
    <li class="truncate">List Price:
        <asp:Literal ID="ListPrice" runat="server" Text="Not available" /></li>
    <li class="truncate">Discount Pricing:
        <asp:Literal ID="DiscountPricing" runat="server" Text="Not available" /></li>
    <li class="truncate">You Save:  <strong>
        <asp:Literal ID="DiscountAmount" runat="server" Text="Not available" /></strong></li>
</ul>