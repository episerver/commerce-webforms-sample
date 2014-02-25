<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartSimpleModule.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.CartSimpleModule" %>
<%@ Register Src="SharedModules/EntryQuantityControl.ascx" TagName="EntryQuantityControl" TagPrefix="cart" %>
<%@ Register Src="SharedModules/LineItemsSimpleView.ascx" TagName="LineItems" TagPrefix="cart" %>
<%@ Register Src="SharedModules/OrderSubtotalSimpleView.ascx" TagName="OrderSubtotal" TagPrefix="cart" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ApplyCoupons.ascx" TagName="ApplyCoupons" TagPrefix="cart" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>

<cart:ApplyCoupons ID="ApplyCouponsID" runat="server"></cart:ApplyCoupons>
<cart:LineItems ID="LineItemsID" runat="server" Editable="true"></cart:LineItems>
<div id="cartDetails" runat="server">
	<cart:OrderSubtotal ID="OrderSubtotalID" runat="server"></cart:OrderSubtotal>
        <hr />
	<div class="col-md-12 C_Proceed-to-Checkout text-right">
        <asp:LinkButton ID="ContinueButton" runat="server" CssClass="btn btn-default col-xs-12 col-sm-3 col-sm-push-5" OnClick="ContinueButton_Click" Text="Continue Shopping" />
        &nbsp;
        <asp:LinkButton ID="goToCheckout" runat="server" CssClass="btn btn-primary col-xs-12 col-sm-3 col-sm-push-6" Text="Proceed to Checkout" UseSubmitBehavior="true" OnClick="CheckoutButton_Click" />
	</div>
</div>
