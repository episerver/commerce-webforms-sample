<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YourAddresses.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.YourAddresses" %>
<%@ Import Namespace="Mediachase.Commerce.Customers" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
    <div class="col-md-9 col-md-push-3">          
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
        <h3> Available Addresses</h3>
        <p>
            <a class="btn btn-sm btn-info" href="<%= GetUrl(Settings.EditAddressPage) %>"><i class="glyphicon glyphicon-plus "></i> Add New</a>
        </p>
        <asp:ListView ID="addresses" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="AddressId">
            <EmptyDataTemplate>
                <p>You don't have any addresses saved currently.</p>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>Name </th>
                            <th class="hidden-xs">Date Updated</th>
                            <th>Address</th>
                            <th class="hidden-xs">Status</th>
                            <th>&nbsp;</th>
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
                        <asp:HyperLink ID="name" runat="server" NavigateUrl='<%#  GetUrl(Settings.EditAddressPage) + "?AddressId=" + Server.UrlEncode(Eval("AddressId").ToString()) %>' Text='<%# HttpUtility.HtmlEncode(Eval("Name")) %>'>
                        </asp:HyperLink>
                    </td>
                    <td class="hidden-xs">
                        <%# Convert.ToDateTime(Eval("Modified")).ToShortDateString() %>
                    </td>
                    <td>
                        <%# HttpUtility.HtmlEncode(((CustomerAddress)Container.DataItem).GetAddressString()) %>
                    </td>
                    <td class="hidden-xs">
                        <%# GetDefaults((CustomerAddress)Container.DataItem)%>
                    </td>
                    <td>
                        <asp:HyperLink ID="edit" runat="server" NavigateUrl='<%# GetUrl(Settings.EditAddressPage) + "?AddressId=" + Server.UrlEncode(Eval("AddressId").ToString()) %>' CssClass="btn btn-sm btn-primary col-xs-12">
                            <i class="glyphicon glyphicon-edit "></i> Edit
                        </asp:HyperLink>
                        &nbsp;
                        <asp:LinkButton ID="delete" runat="server" CssClass="btn btn-sm btn-danger col-xs-12" CommandName="deleteAddress" CommandArgument='<%# DataBinder.Eval((Mediachase.Commerce.Customers.CustomerAddress)Container.DataItem,"AddressId") %>'>
                            <i class="glyphicon glyphicon-trash"></i> Delete
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <div class="col-md-3 col-md-pull-9 col-sm-6 sidebar-offcanvas">
        <cmsnav:sidenav id="SideNav" runat="server" />
    </div>
</div>
