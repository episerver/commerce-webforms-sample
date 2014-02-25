<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderDetailsSingleShipment.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetailsSingleShipment" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/LineItemsSimpleInfo.ascx" TagPrefix="Sample" TagName="LineItemsSimpleInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/OrderSubtotalSimpleInfo.ascx" TagPrefix="Sample" TagName="OrderSubtotalSimpleInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/OrderAddressInfo.ascx" TagPrefix="Sample" TagName="OrderAddressInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/PaymentInfo.ascx" TagPrefix="Sample" TagName="PaymentInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/ShippingMethodInfo.ascx" TagPrefix="Sample" TagName="ShippingMethodInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/CouponsInfo.ascx" TagPrefix="Sample" TagName="CouponsInfo" %>

<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
    <div class="col-md-9 col-md-push-3">
        <div class="row">
            <div class="col-xs-12">
                <div class="pull-right visible-sm visible-xs">
                    <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
                </div>
            </div>
        </div>
        <asp:Label ID="InvalidOrder" Visible="false" runat="server">
            The order ID is invalid.
        </asp:Label>
        <asp:PlaceHolder ID="OrderDetailContent" runat="server">
            <div class="row">
                <div class="col-sm-6">
                    <div class="well">
                        <p>
                            <strong>Bill To:</strong>
                            <Sample:OrderAddressInfo runat="server" id="BillAddressInfo" />
                        </p>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="well">
                        <p>
                            <strong>Ship To:</strong>
                            <Sample:OrderAddressInfo runat="server" id="ShipAddressInfo" />
                        </p>
                    </div>
                </div>
            </div>
            <Sample:CouponsInfo runat="server" id="CouponsInfoID" />
            <Sample:LineItemsSimpleInfo runat="server" id="LineItemsSimpleInfoID" />
            <Sample:ShippingMethodInfo runat="server" id="ShippingMethodInfoID" />
            <Sample:PaymentInfo runat="server" id="PaymentInfoID" />

            <Sample:OrderSubtotalSimpleInfo runat="server" id="OrderSubtotalSimpleInfoID" />
            <div class="col-md-12">
                <a class="btn btn-default col-sm-2" href="<%= GetUrl(Settings.YourOrdersPage) %>"><i class="glyphicon glyphicon-arrow-left"></i> Back</a>
            </div>
        </asp:PlaceHolder>
    </div>
    <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:sidenav id="SideNav" runat="server" />
    </div>
</div>
