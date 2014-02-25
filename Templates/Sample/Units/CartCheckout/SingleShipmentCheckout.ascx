<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SingleShipmentCheckout.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SingleShipmentCheckout" %>
<%@ Register Src="SharedModules/LineItemsSimpleView.ascx" TagName="LineItems" TagPrefix="cart" %>
<%@ Register Src="SharedModules/OrderSubtotalSimpleView.ascx" TagName="OrderSubtotal" TagPrefix="cart" %>
<%@ Register Src="SharedModules/PaymentOptions.ascx" TagName="PaymentOptions" TagPrefix="checkout" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ApplyCoupons.ascx" TagName="ApplyCoupons" TagPrefix="cart" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ErrorModule.ascx" TagPrefix="cart" TagName="ErrorModule" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ErrorModalModule.ascx" TagPrefix="cart" TagName="ErrorModalModule" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/CartAddressView.ascx" TagPrefix="cart" TagName="CartAddressView" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/AddressControl.ascx" TagPrefix="cart" TagName="AddressControl" %>

<div class="row">
    <a class="btn btn-link" href="<%=MultiShipmentPageUrl %>" >Ship Items to Multiple Addresses</a>
</div>

<cart:ErrorModule runat="server" id="ErrorModule" />
<cart:ErrorModalModule runat="server" id="ErrorModalModule" />
<div class="row C_Billing-Shipping-Addresses" id="ShippingRegion">
	<div class="col-sm-12">
		<div class="row">
			<div class="col-sm-6">
                <cart:CartAddressView ID="BillingAddressInfo" runat="server" IsBillingAddress="true" />
			</div>
			<div class="col-sm-6">
                <cart:CartAddressView ID="ShippingAddressInfo" runat="server" IsBillingAddress="false" />
			</div>
		</div>
	</div>
</div>
<div>
    <cart:ApplyCoupons ID="ApplyCouponsID" runat="server" />
</div>

<cart:LineItems ID="LineItemsID" runat="server" Editable="false" />

<div class="row C_Shipping-Selections" id="ShippingRegion">
	<div class="col-sm-12">
		<div class="well well-sm">
			    Choose Shipping Method for Your Items
        </div>
		<asp:ListView ID="shippingOptions" runat="server" ItemPlaceholderID="itemPlaceHolder" GroupPlaceholderID="groupPlaceHolder" GroupItemCount="3">
			<EmptyDataTemplate>
                <asp:Literal ID="litMessage" runat="server" Text="No Shipping Methods Setup"/>
            </EmptyDataTemplate>
			<LayoutTemplate>
				<div class="row">
					<asp:PlaceHolder runat="server" ID="groupPlaceHolder"></asp:PlaceHolder>
				</div>
			</LayoutTemplate>
			<GroupTemplate>
				<asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
			</GroupTemplate>
			<ItemTemplate>
				<div class="col-sm-4">
					<label class="radio"> 
						<med:GlobalRadioButton GroupName="ChooseShipping" runat="server" ID="rdoChooseShipping" AutoPostBack="true" OnCheckedChanged="ChooseShipping_OnChange"  />
						<%# Eval("ShippingName") %>
					</label> 
					<p>
						<%# Eval("Description") %>
					</p>
					<input type="hidden" id="hiddenShippingId" runat="server" value='<%# Eval("ShippingMethodId") %>' />
				</div>
			</ItemTemplate>
		</asp:ListView>
		<hr />
	</div>
</div>

<checkout:PaymentOptions ID="PaymentOptionsID" runat="server" />

<cart:OrderSubtotal ID="OrderSubtotalID" runat="server" />
<hr />
<div class="col-md-12">
	<asp:LinkButton ID="CancelButton" runat="server" CssClass="btn btn-default col-xs-12 col-sm-2 col-sm-push-7" OnClick="Cancel_Click" UseSubmitBehavior="false" Text="Cancel"></asp:LinkButton>
        &nbsp;
	<asp:LinkButton ID="CheckoutButton" runat="server" CssClass="btn btn-primary col-xs-12 col-sm-2 col-sm-push-8" Text="Place Order" UseSubmitBehavior="true" OnClick="Order_Click"></asp:LinkButton>
</div>

<cart:AddressControl ID="Addresses" runat="server"></cart:AddressControl>
