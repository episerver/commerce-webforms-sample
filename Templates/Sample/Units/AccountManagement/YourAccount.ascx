<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YourAccount.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.YourAccount" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<%@ Import Namespace="Mediachase.Commerce.Customers" %>
<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
    <div class="col-md-9 col-md-push-3">  
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
        <h3>
            Your Current Account Information 
        </h3>
        <hr />
        <p>
            Name: <strong> <%= WebStringHelper.EncodeForWebString(Mediachase.Commerce.Customers.CustomerContext.Current.CurrentContactName) %></strong> 
        </p>
        <p>
            Number of Orders You Have Placed With Us : <strong><asp:Literal ID="litNumberofOrders" runat="server"></asp:Literal></strong>
        </p>
        <p>
            Date of Last Order : <strong><asp:Literal ID="litLastOrderDate" runat="server"></asp:Literal></strong> 
        </p>
        <p>
            Date Your Account Was Set Up : <strong><%=Mediachase.Commerce.Customers.CustomerContext.Current.CurrentContact.Created%> </strong>
        </p>
        <p style="display: none">
            <a class="btn btn-sm btn-info" href="<%= GetUrl(Settings.AccountPage) %>"><i class="glyphicon glyphicon-cog "></i> Change</a> 
        </p>
        <hr />
        <div class="row">
            <div class="col-md-12">
                <h3>
                    Your Default Shipping Address 
                </h3>
                <hr />
                <asp:ListView ID="shippingAddress" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="AddressId">
                    <EmptyDataTemplate>
                        <p>You don't have a default shipping address set.</p>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <table class="table table-striped table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>Address</th>
                                    <th>Change</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# HttpUtility.HtmlEncode(((CustomerAddress)Container.DataItem).GetAddressString()) %>
                            </td>
                            <td>
                                <asp:HyperLink ID="edit" runat="server" NavigateUrl='<%# GetUrl(Settings.AddressesPage) + "?AddressId=" + Server.UrlEncode(Eval("AddressId").ToString()) %>' Text="Change" CssClass="btn btn-sm btn-primary"><i class="glyphicon glyphicon-edit "></i> Edit
                                </asp:HyperLink>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <hr />
                    <h3>
                        Your Default Billing Address 
                    </h3>
                <hr />
                <asp:ListView ID="billingAddress" runat="server" ItemPlaceholderID="PlaceHolder1" DataKeyNames="AddressId">
                    <EmptyDataTemplate>
                        <p>You don't have a default billing address set.</p>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <table class="table table-striped table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>Address</th>
                                    <th>Change</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# HttpUtility.HtmlEncode(((CustomerAddress)Container.DataItem).GetAddressString()) %>
                            </td>
                            <td>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GetUrl(Settings.AddressesPage) + "?AddressId=" + Server.UrlEncode(Eval("AddressId").ToString()) %>' Text="Change" CssClass="btn btn-sm btn-primary"><i class="glyphicon glyphicon-edit"></i> Edit
                                </asp:HyperLink>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <hr />
            </div>
        </div>
    </div>
    <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:SideNav ID="SideNav" runat="server" />
    </div>
</div>
