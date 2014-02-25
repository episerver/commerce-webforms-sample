<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YourWishList.ascx.cs"
    Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.YourWishList" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="Mediachase.Commerce.Orders" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
    <div class="col-md-9 col-md-push-3">
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
        <asp:Literal ID="lblEmptyData" runat="server" Visible="false" Text="There are no items in Wish List." />
        <asp:Repeater ID="CartItemsList" runat="server">
            <HeaderTemplate>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>
                                Product Name
                            </th>
                            <th>
                                Unit Price
                            </th>
                            <th class="action-column">
                                &nbsp;
                            </th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="hideIfOverflow">
                        <a href="<%# ((LineItem)Container.DataItem).GetEntryLink()%>" target="_blank">
                            <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).DisplayName) %></a>
                    </td>
                    <td class="text-right">
                        <asp:Literal ID="YourPrice" runat="server"></asp:Literal><br />
                        <strike>
                            <asp:Literal ID="ListPrice" runat="server"></asp:Literal></strike>
                    </td>
                    <td>
                        <div class="btn-group">
                            <a class="btn btn-info" data-toggle="modal" data-target='<%# "#mymodal" + Container.ItemIndex%>'>
                                <span class="visible-xs"><i class="glyphicon glyphicon-list-alt "></i></span>
                                <span class="hidden-xs"><i class="glyphicon glyphicon-list-alt "></i> View Info</span>
                            </a> 
                            <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                            <ul class="dropdown-menu rightposition">
                                <li>
                                    <asp:LinkButton runat="server" ID="AddCartLink" CommandName="AddToCart" CommandArgument='<%# ((LineItem)Container.DataItem).LineItemId%>'
                                        CausesValidation="false"><i class="glyphicon glyphicon-shopping-cart"></i> Add to Cart</asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton runat="server" ID="RemoveLink" CommandName="Remove" CommandArgument='<%# ((LineItem)Container.DataItem).LineItemId%>'
                                        CausesValidation="false"><i class="glyphicon glyphicon-remove"></i> Remove</asp:LinkButton></li>
                                <li><a href="#"><i class="glyphicon glyphicon-cog"></i>
                                    Post to Facebook</a></li>
                                <li><a href="#"><i class="glyphicon glyphicon-cog"></i>
                                    Post to Twitter</a></li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="glyphicon glyphicon-gift"></i>
                                    Create Custom Gift Card</a></li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="glyphicon glyphicon-envelope"></i>
                                    eMail Share</a></li>
                            </ul>
                        </div>
                        <div id='<%# "mymodal" + Container.ItemIndex%>' class="modal fade">
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
                                        <img src='<%# GetItemImage((LineItem)Container.DataItem)  %>' alt="dx" class="img-responsive"/>
                                    </a>
                                </div>
                                Brand:
                                <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetProductMetaFieldValueFromLineItem("Facet_Brand"))%>
                                <br />
                                Model#:
                                <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetProductMetaFieldValueFromLineItem("Info_ModelNumber"))%>
                                <br />
                                SKU:
                                <%# ((LineItem)Container.DataItem).CatalogEntryId %>
                                - <%# ((LineItem)Container.DataItem).ParentCatalogEntryId %>
                                - <%# ((LineItem)Container.DataItem).Catalog %>
                                <br />
                                Size:
                                <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetSkuMetaFieldValueFromLineItem("Facet_Size"))%>
                                <br />
                                Color:
                                <%# WebStringHelper.EncodeForWebString(((LineItem)Container.DataItem).GetSkuMetaFieldValueFromLineItem("Facet_Color"))%>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                          </div>
                         </div>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody> </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
   <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:SideNav ID="SideNav" runat="server" />
    </div>
</div>
