<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiShipmentDetails.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.MultiShipmentDetails" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/MultiShipmentOrderSubTotal.ascx" TagPrefix="cart" TagName="OrderSubtotalMultiView" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/OrderAddressInfo.ascx" TagPrefix="Sample" TagName="ShipAddressInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/ShippingMethodInfo.ascx" TagPrefix="Sample" TagName="ShippingMethodInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/LineItemsSimpleInfo.ascx" TagPrefix="Sample" TagName="LineItemsSimpleInfo" %>

<Sample:LineItemsSimpleInfo runat="server" id="LineItemsSimpleInfoID" />

<div class="row C_Billing-Shipping-Addresses">
    <div class="col-md-8 col-sm-6">
        <div class="col-md-6 col-sm-12">
            <div class="well">
                <strong>Ship To:</strong>
                <Sample:ShipAddressInfo runat="server" id="ShipAddressInfo" />
            </div>
        </div>
        <div class="col-md-6 col-sm-12">
            <Sample:ShippingMethodInfo runat="server" id="ShippingMethodInfoID" />
        </div>
    </div>
    
    <div class="col-md-4 col-sm-6">
        <cart:OrderSubtotalMultiView runat="server" id="OrderSubtotalID" />
    </div>
</div>
