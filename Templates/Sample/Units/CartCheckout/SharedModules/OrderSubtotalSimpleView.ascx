<%@ Control Language="C#" AutoEventWireup="True" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.OrderSubtotalSimpleView" CodeBehind="OrderSubtotalSimpleView.ascx.cs" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>
<div class="row C_Order-Summary-Calculation">
    <div class="col-md-12">
        <div class="well well-sm">
                Cart/Order Summary
        </div>
        <div class="col-md-6 col-md-offset-6 text-right">
             <div class="row">
                <div class="col-xs-8">
                    <strong>
                        Sub Total For Your Items
                    </strong>
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="OrderSubTotalLineItems" runat="server" />
                    </strong>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-xs-8">
                    <strong>Additional Order Level Discounts</strong>
                    <p class="discount-text text-right">
                        <asp:Literal ID="OrderDiscountsMessage" runat="server" />
                    </p>
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="OrderDiscount" runat="server" />
                    </strong>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-xs-8">
                    <strong>
                        Sub Total For Your Cart/Order
                    </strong>
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="OrderSubTotal" runat="server" />
                    </strong>
                </div>
            </div>
            <hr />
            <div class="row " id="taxAndShipping" runat="server">
                <div class="col-xs-8">
                    &nbsp; 
                </div>
                <div class="col-md-4 text-left">
                        Estimated Tax &amp; Shipping (For Cart)
                        <br />
                        <asp:TextBox ID="EstimatorZip" runat="server" CssClass="small input-text" placeholder="Enter Zip Code" />
                        <asp:Button ID="estimateTaxShipping" runat="server" CssClass="btn" Text="Calculate" />
                </div>
            </div>
            <div class="row" id="taxSeperator" runat="server">
                <hr /> 
            </div>
            <div class="row -Tax">
                <div class="col-xs-8">
                    <strong>
                        Shipping &amp; Tax
                    </strong>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    Estimated Shipping Costs
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="shippingTotal" runat="server" />
                    </strong>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    Estimated Tax to Be Collected
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="TaxTotal" runat="server" />
                    </strong>
                </div>
            </div>
            <hr />
        <div class="row">
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
        <hr />
        <div class="row">
            <div class="col-xs-8">
                <strong>
                    Total For Cart
                </strong>
            </div>
            <div class="col-xs-4">
                <strong>
                    <asp:Literal ID="OrderTotal" runat="server" />
                </strong>
            </div>
        </div>
        </div>
    </div>
</div>