<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderDetailsMultiShipment.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetailsMultiShipment" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/OrderSubtotalSimpleInfo.ascx" TagPrefix="Sample" TagName="OrderSubtotalSimpleInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/OrderAddressInfo.ascx" TagPrefix="Sample" TagName="OrderAddressInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/PaymentInfo.ascx" TagPrefix="Sample" TagName="PaymentInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/CouponsInfo.ascx" TagPrefix="Sample" TagName="CouponsInfo" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/OrderDetail/MultiShipmentDetails.ascx" TagPrefix="Shippment" TagName="MultiShipmentDetails" %><%@ Register Src="~/Templates/Sample/Units/CartCheckout/SharedModules/SplitShipmentControl.ascx" TagPrefix="cart" TagName="SplitShipmentControl" %>

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
                <div class="col-md-6">
                    <div class="well">
                        <p>
                            <strong>Bill To:</strong>
                            <Sample:OrderAddressInfo runat="server" id="BillAddressInfo" />
                        </p>
                    </div>
                </div>
            </div>

            <asp:ListView runat="server" ID="lvSplitShipment">
                <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                        <h4>Shipment <%# Container.DataItemIndex + 1 %></h4>
                        <Shippment:MultiShipmentDetails runat="server" ID="SplitShipmentControlID" SplitShipment="<%# (Mediachase.Commerce.Orders.Shipment)Container.DataItem %>" />
                </ItemTemplate>
            </asp:ListView>

            <Sample:CouponsInfo runat="server" id="CouponsInfoID" />
            <Sample:PaymentInfo runat="server" id="PaymentInfoID" />
            
            <Sample:OrderSubtotalSimpleInfo runat="server" id="OrderSubtotalSimpleInfoID" />
            <div class="col-md-12">
                <a class="btn btn-default col-md-2" href="<%= GetUrl(Settings.YourOrdersPage) %>"><i class="glyphicon glyphicon-arrow-left"></i> Back</a>
            </div>
        </asp:PlaceHolder>
    </div>
    <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:sidenav id="SideNav" runat="server" />
    </div>
</div>
