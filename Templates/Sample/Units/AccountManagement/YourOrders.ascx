<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YourOrders.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.YourOrders" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
    <div class="col-md-9 col-md-push-3">
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
        <h3>Available Orders</h3>
        <div class="row">
            <div class="col-md-5">
                <asp:DropDownList runat="server" ID="ddlAvailableOrders" OnSelectedIndexChanged="ddlAvailableOrders_SelectedIndexChanged" AutoPostBack="True" CssClass="form-control">
                    <asp:ListItem Value="30" Text="Orders placed in the last 30 days" />
                    <asp:ListItem Value="90" Text="Orders placed in the last 90 days" />
                    <asp:ListItem Value="180" Text="Orders placed in the last 6 months" />
                    <asp:ListItem Value="365" Text="Orders placed in the last 12 months" />
                    <asp:ListItem Value="545" Text="Orders placed in the last 18 months" />
                </asp:DropDownList>
            </div>
        </div>
                <asp:Literal runat="server" ID="noOrderMsg" Visible="false" Text="No Orders Yet" />
            <asp:Repeater EnableViewState="False" runat="server" ID="rptOrderList">
                <HeaderTemplate>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>
                                <th>Order Number</th>
                                <th class="hidden-xs">Orders Date</th>
                                <th class="hidden-xs">Billing Address</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><a href="<%# GetUrl(Settings.OrderDetailPage) + "?po=" + ((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).OrderGroupId %>"><%# ((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).TrackingNumber %> </a></td>
                        <td class="hidden-xs">
                            <%# ((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).Created.ToShortDateString() %>
                        </td>
                        <td class="hidden-xs">
                            <%# GetBillingAddressFullNameHtmlEncoded((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem) %>
                        </td>
                        <td class="text-right">
                            <%# new Mediachase.Commerce.Money(((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).Total, new Mediachase.Commerce.Currency(((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).BillingCurrency)).ToString()%>
                        </td>
                        <td>
                            <%# ((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).Status %>
                        </td>
                        <td>
                            <a class="btn btn-sm btn-info" href="<%# GetUrl(Settings.OrderDetailPage) + "?po=" + ((Mediachase.Commerce.Orders.PurchaseOrder) Container.DataItem).OrderGroupId %>"><i class="glyphicon glyphicon-list-alt "></i> Details</a>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
    </div>
    <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:SideNav ID="SideNav" runat="server" />
    </div>
</div>
