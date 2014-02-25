<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LineItemsMultiView.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.LineItemsMultiView" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<asp:ListView Visible="true" ID="lvCartItems" EnableViewState="true" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="LineItemId,Quantity" >
    <EmptyDataTemplate>
        <div class="row">
            <div class="col-sm-12">
                <h5>
                    You have no items in your shopping cart.
                </h5>
            </div>
        </div>
    </EmptyDataTemplate>
    <LayoutTemplate>
        <div class="C_Shipment">
            <div class="row C_Order-Items-List">
                <div class="col-sm-12">
                    <div class="well well-sm">
                        Items In Your Cart/Being Ordered
                    </div>
                    <div class="row C_Line-Items-Header text-right hidden-xs hidden-sm">
                        <div class="col-sm-4 text-left">
                            <strong><asp:Literal runat="server" Text="Product Name" /></strong> 
 
                        </div>
                        <div class="col-sm-2">
                            <strong><asp:Literal ID="Literal1" runat="server" Text="List Price" /></strong> 
                        </div>
                        <div class="col-sm-2">
                            <strong><asp:Literal ID="Literal2" runat="server" Text="Your Price" /></strong> 
 
                        </div>
                        <div class="col-sm-2">
                            <strong><asp:Literal ID="Literal3" runat="server" Text="Quantity" /></strong> 
                        </div>
                        <div class="col-sm-2">
                            <strong><asp:Literal ID="Literal4" runat="server" Text="Total" /></strong>
                        </div>
                        <hr />
                    </div>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                </div>
            </div>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div class="row C_Line-Item">
            <div class="col-sm-12  col-xs-12">
                <div class="row C_Line-Item-Pricing text-right">
                    <div class="col-sm-4 text-left">
                        <label class="col-xs-6 visible-xs text-right">Product Name: </label>
                        <a class="col-xs-6 col-sm-12" href="<%# ((LineItem)Container.DataItem).GetEntryLink()%>" target="_blank"><%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %></a>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">List Price: </label>
                        <strike>
                            <asp:Literal id="ListPrice" runat="server"></asp:Literal>
                        </strike>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">Your Price: </label>
                        <asp:Literal ID="YourPrice" runat="server"></asp:Literal>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <div class="row">
                            <label class="col-xs-6 visible-xs">Quantity: </label>
                            <div class="col-xs-6 col-sm-12"><%# ((decimal)Eval("Quantity")).ToString("f0") %></div>
                        </div>
                        <div class="row">
                            <label class="col-xs-6 visible-xs">Warehouse: </label>
                            <div class="col-xs-6 col-sm-12"><asp:Literal ID="WarehouseName" runat="server"></asp:Literal></div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">Extented Price: </label>
                        <strong>
                            <asp:Literal ID="ExtendedPrice" runat="server"></asp:Literal>
                        </strong>
                    </div>
                </div>
                <div ID="divItemLevelDiscount" runat="server" class="row text-right C_Line-Item-Discounts-Savings">
                    <div class="col-sm-2 hidden-xs">
                        &nbsp;
                    </div>
                    <div class="col-sm-6 col-xs-6">
                        <hr />
                        <strong>Item Level Discounts Applied </strong>
                        <p class="discount-text">
                            <asp:Literal ID="itemDiscounts" runat="server" />
                        </p>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <hr />
                        YOU SAVE : 
                        <strong>
                            <asp:Literal ID="DiscountAmount" runat="server" />
                        </strong>
                    </div>
                </div>
            </div>
        </div>
        <hr />
    </ItemTemplate>
    <EditItemTemplate>
        <div class="row C_Line-Item">
            <div class="col-sm-12">
                <div class="row C_Line-Item-Pricing text-right">
                    <div class="col-sm-2 C_Actions text-left">
                        <asp:LinkButton ID="UpdateCart" runat="server" CommandName="Update" CausesValidation="false" CssClass="btn btn-success">
                            <i class="glyphicon glyphicon-ok "></i> Update
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="linkCancel" CommandName="Cancel" CausesValidation="false" CssClass="btn"><i class="glyphicon glyphicon-remove"></i> Cancel</asp:LinkButton></li>
                        
                    </div>
                    <div class="col-sm-3 text-left">
                        <h5>
                            <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %>
                        </h5>
                    </div>
                    <div class="col-sm-2">
                        <strike>
                            <asp:Literal id="ListPrice" runat="server"></asp:Literal>
                        </strike>
                    </div>
                    <div class="col-sm-2">
                        <asp:Literal id="YourPrice" runat="server"></asp:Literal>
                    </div>
                    <div class="col-sm-1">
                        <asp:TextBox style="text-align:right" Width="30"  ID="Quantity" runat="server" Text='<%# ((decimal)Eval("Quantity")).ToString("f0") %>' />
                        <asp:RangeValidator ID="valRange" runat="server" ErrorMessage="Must enter a valid number" MinimumValue="1" MaximumValue="100" ControlToValidate="Quantity" Display="Dynamic" EnableClientScript="true" Type="Integer"></asp:RangeValidator>
                    </div>
                    <div class="col-sm-2">
                        <strong>
                            <asp:Literal id="ExtendedPrice" runat="server" />
                        </strong> 
                    </div>
                </div>
                <div ID="divItemLevelDiscount" runat="server" class="row C_Line-Item-Discounts-Savings">
                    <div class="col-sm-2 hidden-xs">
                        &nbsp;
                    </div>
                    <div class="col-sm-6 col-xs-6">
                        <hr />
                        <strong>Item Level Discounts Applied </strong>
                        <p class="discount-text">
                            <asp:Literal ID="itemDiscounts" runat="server" />
                        </p>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <hr />
                        YOU SAVE : 
                        <strong>
                            <asp:Literal ID="DiscountAmount" runat="server" />
                        </strong>
                    </div>
                </div>
            </div>
        </div>
        <hr>
    </EditItemTemplate>
</asp:ListView>
