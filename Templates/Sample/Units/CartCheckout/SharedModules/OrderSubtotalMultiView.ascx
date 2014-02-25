<%@ Control Language="C#" AutoEventWireup="True" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.OrderSubtotalMultiView" CodeBehind="OrderSubtotalMultiView.ascx.cs" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>

<div class="row C_Order-Summary-Calculation">
    <div class="col-xs-12">
        <div class="well well-sm">
            Summary
        </div>
        <div class="row C_SubTotal-Items text-right">
            <div class="col-xs-8">
                    Sub Total For Your Items
            </div>
            <div class="col-xs-4">
                <strong>
                    <asp:Literal ID="OrderSubTotalLineItems" runat="server"></asp:Literal>
                </strong>
            </div>
        </div>
        <hr>
               <div class="row text-right" id="taxAndShipping" runat="server">

            <div class="col-xs-6 text-left">
                <div class="well well-sm">
                    Estimated Tax &amp; Shipping (For Cart)
                    <br />
                    <asp:TextBox ID="EstimatorZip" runat="server" CssClass="small input-text" placeholder="Enter Zip Code" />
                    <asp:Button ID="estimateTaxShipping" runat="server" CssClass="btn" Text="Calculate" />
                </div>
            </div>
        </div>
        <div class="row C_Separator" id="taxSeperator" runat="server">
        <hr>
        </div>
        <div class="row C_Shipping-Tax text-right">
            <div class="col-xs-8">
                <strong>
                    Shipping &amp; Tax
                </strong>
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
    </div>
</div>
