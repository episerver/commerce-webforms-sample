<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WarehouseList.ascx.cs"
    Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Warehouse.WarehouseList" %>
<%@ Import Namespace="Mediachase.Commerce.Catalog.Objects" %>
<%@ Import Namespace="Mediachase.Commerce.Website.Helpers" %>
<%@ Import Namespace="Mediachase.Commerce.Inventory" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>

<div class="well">
    <h4>Available Warehouses
    </h4>
    <p>
        These are warehouses you currently have defined as active in the ECF commerce Manager. 
    </p>
    <asp:Repeater EnableViewState="False" runat="server" ID="rptWarehouses">
        <HeaderTemplate>
         <ul class="nav nav-list">
           <li class="nav-header">
            <a href="<%# Request.Url.AbsolutePath %>">  
                   All Warehouses
            </a>
           </li>
        </HeaderTemplate>
        <FooterTemplate></ul></FooterTemplate>
        <ItemTemplate>
            <li>
                <a href="<%# String.Format("?{0}={1}",Constants.WarehouseCodeQuery,((Container.DataItem as IWarehouse).Code)) %>">
                  <i class="glyphicon glyphicon-map-marker"></i>  <%# ( Container.DataItem as IWarehouse).Name %>
                </a>
            </li>
        </ItemTemplate>
    </asp:Repeater>
</div>
