<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LineItemsSimpleView.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.LineItemsSimpleView" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<asp:ListView Visible="true" ID="lvCartItems" EnableViewState="true" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="LineItemId,Quantity">
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

                    <div class="row C_Line-Items-Header text-right hidden-xs">
                        <asp:Panel runat="server" ID="InfoHeading">
                            <div class="col-sm-3 col-sm-offset-1 text-center">
                                <strong>
                                    Product Name</strong>
                            </div>
                        </asp:Panel>
                        <asp:Panel runat="server" ID="NameHeading">
                            <div class="col-sm-4 text-left">
                                <strong>
                                    <asp:Literal ID="Literal5" runat="server" Text="Product Name" /></strong>
                            </div>
                        </asp:Panel>
                        <div class="col-sm-2">
                            <strong>
                                <asp:Literal ID="Literal1" runat="server" Text="List Price" /></strong>
                        </div>
                        <div class="col-sm-2">
                            <strong>
                                <asp:Literal ID="Literal2" runat="server" Text="Your Price" /></strong>

                        </div>
                        <div class="col-sm-2">
                            <strong>
                                <asp:Literal ID="Literal3" runat="server" Text="Quantity" /></strong>
                        </div>
                        <div class="col-sm-2">
                            <strong>
                                <asp:Literal ID="Literal4" runat="server" Text="Total" /></strong>
                        </div>
                    </div>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                </div>
            </div>
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div class="row C_Line-Item">
            <div class="col-sm-12  col-xs-12">
                <div class="row C_Line-Item-Pricing text-right">
                    <asp:Panel runat="server" ID="InfoPanel" CssClass="col-sm-4 col-xs-12">
                        <div class="col-sm-5 col-xs-5 C_Actions text-left">
                            <div class="btn-group">
                                <a data-toggle="modal" data-target='<%# "#mymodal" + Container.DataItemIndex%>' class="btn btn-success">
                                    <span class="visible-xs visible-sm"><i class="glyphicon glyphicon-info-sign "></i></span>
                                    <span class="hidden-xs hidden-sm"><i class="glyphicon glyphicon-info-sign "></i> View Info</span>
                                </a>
                                <a class="btn btn-success dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <asp:LinkButton runat="server" ID="UpdateCart" ToolTip='' CommandName="Edit" CausesValidation="false"><i class="glyphicon glyphicon-edit"></i> Edit</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton runat="server" ID="RemoveItem" ToolTip='' CommandName="Delete" CausesValidation="false"><i class="glyphicon glyphicon-trash"></i> Remove</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton runat="server" ID="WishList" ToolTip='' CommandName="Wishlist" CausesValidation="false"><i class="glyphicon glyphicon-heart"></i> Add to Wish List</asp:LinkButton></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-sm-7 col-xs-7 text-left">
                                <a href="<%# ((LineItem)Container.DataItem).GetEntryLink()%>" target="_blank"><%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %></a>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="NamePanel" CssClass="col-sm-4 col-xs-12 text-left">
                            <label class="col-xs-6 visible-xs text-right">Product Name: </label>
                            <a class="col-sm-12 col-xs-6" href="<%# ((LineItem)Container.DataItem).GetEntryLink()%>" target="_blank"><%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %></a>
                    </asp:Panel>
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
                <div id="divItemLevelDiscount" runat="server" class="row text-right C_Line-Item-Discounts-Savings">
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
        <div id='<%# "mymodal" + Container.DataItemIndex%>' class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <a class="close" data-dismiss="modal">&times;</a> 
                        <h4>
                            <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div class="thumbnail">
                            <a href="#">
                                <img src='<%# GetItemImage((LineItem)Container.DataItem)  %>' alt="dx" />
                            </a>
                        </div>
                        Brand:  <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetProductMetaFieldValueFromLineItem("Facet_Brand"))%>
                        <br />
                        Model: <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetProductMetaFieldValueFromLineItem("Info_ModelNumber"))%>
                        <br />
                        SKU:  <%# Eval("CatalogEntryId").ToString() %>
                        <br />
                        Size:  <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetSkuMetaFieldValueFromLineItem("Facet_Size"))%>
                        <br />
                        Color:  <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetSkuMetaFieldValueFromLineItem("Facet_Color"))%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
                    <div class="col-sm-5 col-xs-12 ">
                            <div class="col-sm-5 col-xs-5 C_Actions text-left">
                                <asp:LinkButton ID="UpdateCart" runat="server" CommandName="Update" CausesValidation="false" CssClass="btn btn-success">
                                    <i class="glyphicon glyphicon-ok "></i> Update
                                </asp:LinkButton>
                                <asp:LinkButton runat="server" ID="linkCancel" CommandName="Cancel" CausesValidation="false" CssClass="btn btn-default"><i class="glyphicon glyphicon-remove"></i> Cancel</asp:LinkButton></li>
                        
                            </div>
                            <div class="col-sm-7 col-xs-7 text-left">
                                <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %>
                        </div>
                    </div>
                    <div class="col-sm-1 col-xs-12">
                        <strike>
                            <asp:Literal id="ListPrice" runat="server"></asp:Literal>
                        </strike>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <asp:Literal ID="YourPrice" runat="server"></asp:Literal>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <label class="col-xs-6 visible-xs">Quantity:</label>
                        <div class="col-sm-12 col-xs-6">
                            <asp:TextBox CssClass="form-control text-right" ID="Quantity" runat="server" Text='<%# ((decimal)Eval("Quantity")).ToString("f0") %>'></asp:TextBox>
                        </div>
                        <asp:RangeValidator ID="valRange" runat="server" ErrorMessage="<%$ Resources:EPiServer, Sample.Validation.InvalidNumberMessage %>" MinimumValue="1" MaximumValue="100" ControlToValidate="Quantity" Display="Dynamic" EnableClientScript="true" Type="Integer"></asp:RangeValidator>
                    </div>
                    <div class="col-sm-2 col-xs-12">
                        <strong>
                            <asp:Literal ID="ExtendedPrice" runat="server" />
                        </strong>
                    </div>
                </div>
                <div id="divItemLevelDiscount" runat="server" class="row C_Line-Item-Discounts-Savings">
                    <div class="col-sm-2 col-xs-12">
                        &nbsp;
                    </div>
                    <div class="col-sm-6 col-xs-12 text-right">
                        <hr />
                        <strong>Item Level Discounts Applied </strong>
                        <p class="discount-text">
                            <asp:Literal ID="itemDiscounts" runat="server" />
                        </p>
                    </div>
                    <div class="col-sm-3 col-xs-12">
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
