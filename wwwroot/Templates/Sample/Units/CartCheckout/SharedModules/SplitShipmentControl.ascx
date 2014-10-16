<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SplitShipmentControl.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.SplitShipmentControl" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/OrderSubtotalMultiView.ascx" TagPrefix="cart" TagName="OrderSubtotalMultiView" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/LineItemsMultiView.ascx" TagPrefix="cart" TagName="LineItemsMultiView" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/CartAddressView.ascx" TagPrefix="cart" TagName="CartAddressView" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>

<cart:LineItemsMultiView ID="LineItemsID" runat="server"></cart:LineItemsMultiView>
<div class="row C_Billing-Shipping-Addresses">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-3">
                <cart:CartAddressView ID="ShippingAddressInfo" runat="server" IsBillingAddress="false" AllowAddNewAddress="false" ></cart:CartAddressView>
            </div>
            <div class="col-sm-4">
                <div class="well">
                    <p>
                        <strong>
                            Choose Shipping Method for Your Items
                        </strong>
                    </p>
                    <asp:ListView ID="shippingOptions" runat="server" ItemPlaceholderID="itemPlaceHolder" GroupPlaceholderID="groupPlaceHolder" GroupItemCount="3">
                        <EmptyDataTemplate>
                            <asp:Literal ID="litMessage" runat="server" Text="No Shipping Methods Setup"/>
                        </EmptyDataTemplate>
                        <LayoutTemplate>
                            <div class="row">
                                <asp:PlaceHolder runat="server" ID="groupPlaceHolder" />
                            </div>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder" />
                        </GroupTemplate>
                        <ItemTemplate>
                            <div class="col-sm-12" >
                                <label class="radio">
                                    <med:GlobalRadioButton GroupName='<%# "ChooseShipping" + this.SplitShipment.Id %>' runat="server" ID="rdoChooseShipping" AutoPostBack="true" OnCheckedChanged="ChooseShipping_Onchange" />
                                    <%# Eval("ShippingName").ToString().ToHtmlEncode() %>
                                </label>
                                <p>
                                    <%# Eval("Description").ToString().ToHtmlEncode() %>
                                </p>
                                <input type="hidden" id="hiddenShippingId" runat="server" value='<%# Eval("ShippingMethodId") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
            <div class="col-sm-5">
                <cart:OrderSubtotalMultiView runat="server" id="OrderSubtotalID" />
            </div>
        </div>
    </div>
</div>


