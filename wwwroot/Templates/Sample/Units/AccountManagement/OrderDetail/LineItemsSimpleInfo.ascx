<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LineItemsSimpleInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.LineItemsSimpleInfo" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<asp:Repeater runat="server" ID="OrderShipment">
    <HeaderTemplate>
        <div class="C_Shipment">
            <div class="row C_Order-Items-List">
                <div class="col-sm-12">
                    <div class="well well-sm">
                            List Items in order
                    </div>
                    <div class="row C_Line-Items-Header text-right hidden-xs">
                        <div class="col-sm-3 text-left">
                            <strong>
                                Product Name
                            </strong>
                        </div>
                        <div class="col-sm-2">
                            <strong>
                                List Price
                            </strong>
                        </div>
                        <div class="col-sm-1">
                            <strong>
                                Discount
                            </strong>
                        </div>
                         <div class="col-sm-2">
                            <strong>
                                Your Price
                            </strong>
                        </div>
                        <div class="col-sm-2">
                            <strong>
                                Quantity
                            </strong>
                        </div>
                        <div class="col-sm-2">
                            <strong>
                                Total
                            </strong>
                        </div>
                    </div>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                </div>
            </div>
        </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div class="row C_Line-Item">
            <div class="col-sm-12">
                <div class="row C_Line-Item-Pricing text-right">
                    <div class="col-sm-3 text-left">
                        <h6>
                            <a href="<%# (Container.DataItem as LineItem).GetEntryLink() %>" target="_blank">
                                <strong>
                                    <%# WebStringHelper.EncodeForWebString((Container.DataItem as LineItem).DisplayName) %> 
                                </strong>
                            </a>
                        </h6>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">List Price: </label>
                        <strike><asp:Literal runat="server" ID="ListPrice"></asp:Literal></strike>
                    </div>
                    <div class="col-sm-1 col-xs-12">
                        <label class="col-xs-6 visible-xs">Discount: </label>
                        <asp:Literal runat="server" ID="Discount"></asp:Literal>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">Your Price: </label>
                        <asp:Literal runat="server" ID="YourPrice"></asp:Literal>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                            <div class="row">
                                <label class="col-xs-6 visible-xs">Quantity: </label>
                                <div class="col-xs-6 col-sm-12"><asp:Literal runat="server" ID="Quantity"></asp:Literal></div>
                            </div>
                            <div class="row">
                                <label class="col-xs-6 visible-xs">Warehouse: </label>
                                <div class="col-xs-6 col-sm-12"> <asp:Literal id="WarehouseName" runat="server"></asp:Literal></div>
                            </div>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">Total: </label>
                        <strong>
                            <asp:Literal runat="server" ID="Total"></asp:Literal>
                        </strong>
                    </div>
                </div>                 
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
