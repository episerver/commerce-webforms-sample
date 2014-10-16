<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiShipmentCheckout.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.MultiShipmentCheckout" %>
<%@ Register Src="SharedModules/OrderSubtotalSimpleView.ascx" TagName="OrderSubtotal" TagPrefix="cart" %>
<%@ Register Src="SharedModules/PaymentOptions.ascx" TagName="PaymentOptions" TagPrefix="checkout" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ApplyCoupons.ascx" TagName="ApplyCoupons" TagPrefix="cart" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/ErrorModalModule.ascx" TagPrefix="cart" TagName="ErrorModalModule" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/SplitShipmentControl.ascx" TagPrefix="cart" TagName="SplitShipmentControl" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/CartAddressView.ascx" TagPrefix="cart" TagName="CartAddressView" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/AddressControl.ascx" TagPrefix="cart" TagName="AddressControl" %>

<div class="row">
    <a class="btn btn-link" href="<%=SingleShipmentPageUrl %>" >Ship Items to One Address</a>
</div>

<cart:ErrorModalModule runat="server" id="ErrorModalModule" />
<div class="row C_Billing-Shipping-Addresses">
    <div class="col-md-12">
        <div class="row">
            <div class="col-sm-6">
                <cart:CartAddressView ID="BillingAddressInfo" runat="server" IsBillingAddress="true"></cart:CartAddressView>
            </div>
            <div class="col-sm-6 ">
                 <cart:ApplyCoupons ID="ApplyCouponsID" runat="server" AllowEditCoupons="true"></cart:ApplyCoupons>
            </div>
        </div>
    </div>
</div>

<asp:ListView runat="server" ID="lvSplitShipment">
    <LayoutTemplate>
        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
    </LayoutTemplate>
    <ItemTemplate>
            <h4 id='<%# "ShippingRegion" + ((Mediachase.Commerce.Orders.Shipment)Container.DataItem).Id %>'>Split Shipment Part <%# Container.DataItemIndex + 1 %></h4>
            <cart:SplitShipmentControl runat="server" ID="SplitShipmentControlID" SplitShipment="<%# (Mediachase.Commerce.Orders.Shipment)Container.DataItem %>" />
        </fieldset>
    </ItemTemplate>
</asp:ListView>

<checkout:PaymentOptions ID="PaymentOptionsID" runat="server"></checkout:PaymentOptions>

<cart:OrderSubtotal ID="OrderSubtotal1" runat="server"></cart:OrderSubtotal>
<hr />
<div class="col-md-12">
    <asp:LinkButton ID="CancelButton" runat="server" CssClass="btn btn-default col-xs-12 col-sm-2 col-sm-push-7" OnClick="Cancel_Click" UseSubmitBehavior="false" Text="Cancel" />
    &nbsp;
    <asp:LinkButton ID="goToCheckout" runat="server" CssClass="btn btn-primary col-xs-12 col-sm-2 col-sm-push-8" Text="Place Order" UseSubmitBehavior="true" OnClick="Order_Click"></asp:LinkButton>
</div>

<cart:AddressControl ID="Addresses" runat="server"></cart:AddressControl>