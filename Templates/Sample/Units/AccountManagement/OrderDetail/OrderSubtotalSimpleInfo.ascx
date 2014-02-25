<%@ Control Language="C#" AutoEventWireup="True" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.OrderSubtotalSimpleInfo" CodeBehind="OrderSubtotalSimpleInfo.ascx.cs" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>

<div class="col-md-12">
    <div class="row C_Order-Summary-Calculation">
        <div class="well well-sm">
                Cart/Order Summary
        </div>
        <div class="col-md-6 col-md-offset-6 text-right">
            <div class="row">
                <div class="col-xs-8">
                    <strong>
                        Sub Total For Your Cart/Order
                    </strong>
                </div>
                <div class="col-xs-4">
                    <strong><asp:Literal ID="SubTotal" runat="server" /></strong>
                    <br />
                    (exc. Tax)
                </div>
            </div>
             <hr>
            <div class="row C_Order-Level-Discounts-Title">
                <div class="col-xs-8">
                    <h5>
                        Shipping &amp; Handling
                    </h5>
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="ShippingTotal" runat="server" /></strong>
                    (exc. Tax and Discounts)
                </div>
            </div>
            <hr>
            <div class="row C_Shipping-Discounts-Title">
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
                        <asp:Literal ID="ShippingDiscount" runat="server" />
                    </strong>
                </div>
            </div>
            <hr>
            <div class="row C_Shipping-Tax">
                <div class="col-xs-8">
                    <h5>
                        Taxes
                    </h5>
                </div>
                <div class="col-xs-4">
                    <strong>
                        <asp:Literal ID="Taxes" runat="server" />
                    </strong>
                </div>
            </div>
            <hr>
            <div class="row">
            <div class="col-xs-8">
                <strong>
                    Total
                </strong>
            </div>
            <div class="col-xs-4">
                <strong>
                    <asp:Literal ID="Total" runat="server" />
                </strong>
            </div>
            </div>
        </div>
    </div>
</div>
