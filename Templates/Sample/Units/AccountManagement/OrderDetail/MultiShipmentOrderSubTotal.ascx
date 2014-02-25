<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiShipmentOrderSubTotal.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.MultiShipmentOrderSubTotal" %>

<%@ Import Namespace="Mediachase.Commerce.Orders" %>

<div class="well well-sm">
    Summary
</div>
<div class="row C_SubTotal-Items text-right">
    <div class="col-xs-8">
            Sub Total For Your Items
    </div>
    <div class="col-xs-4">
        <strong>
            <asp:Literal ID="OrderSubTotalLineItems" runat="server" />
        </strong>
    </div>
</div>
<hr>
<div class="row C_Shipping-Tax text-right">
    <div class="col-xs-8">
         <strong>   Shipping &amp; Tax</strong>
    </div>
    <div class="col-xs-4">
        &nbsp;
    </div>
</div>
<div class="row C_Estimated-Shipping-Tax text-right">
    <div class="col-xs-8">
        Estimated Shipping Costs
    </div>
    <div class="col-xs-4">
        <strong>
            <asp:Literal ID="shippingTotal" runat="server" />
        </strong>
    </div>
</div>
<hr>
<div class="row C_Shipping-Discounts-Title text-right">
    <div class="col-xs-8">
        <strong>
            Additional Shipping Discounts
        </strong>
        <p class="discount-text text-right">
            <asp:Literal ID="ShippingDiscountsMessage" runat="server" />
        </p>
    </div>
    <div class="col-xs-4">
        <strong>
            <asp:Literal ID="shippingDiscount" runat="server" />
        </strong>
    </div>
</div>