<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductWarehouseInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.ProductWarehouseInfo" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="EPiServer.Commerce.Sample.Helpers" %>

<script type="text/javascript">
    function SelectWarehouse(inStockQuantity, warehouseCode, warehouseName) {
        $('#litInStock').html(inStockQuantity);
        $('#litInStorePickUp').html('Store:');
        $('#litWarehouseCode').html(warehouseName);
        $('#checkstoresmodal').modal('hide');
        $('#<%=hidWarehouseCode.ClientID%>').val(warehouseCode);
    }
</script>

<asp:HiddenField runat="server" ID="hidWarehouseCode"/>

<div>In Stock: <strong>
    <label id="litInStock"><%= GetDefaultWarehouseInventory().InStockQuantity %></label> units</strong>
</div>
<div>
    <label id="litInStorePickUp"></label><label id="litWarehouseCode"><%= WarehouseHelper.GetWarehouse(Constants.DefaultWarehouseCode) != null ? WarehouseHelper.GetWarehouse(Constants.DefaultWarehouseCode).Name : string.Empty  %></label>
</div>
<div>
    <a data-toggle="modal" href='#' data-target="#checkstoresmodal">
        <strong>Check Stores</strong>
    </a>
</div>
<div>Item Generally Ship Within <strong> 3 </strong> Days </div>
<div id='checkstoresmodal' class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4>
            Warehouse Information
        </h4>
    </div>
    <div class="modal-body">
        <asp:Repeater EnableViewState="False" runat="server" ID="rptWarehouseList" OnItemDataBound="rptWarehouseList_ItemDataBound">
            <HeaderTemplate>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th class="text-center hidden-xs">Availability</th>
                            <th class="text-center hidden-xs">Reserved</th>
                            <th class="text-center">In Stock</th>
                            <th class="text-center">Pick up</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td class="hideIfOverflow">
                        <a href="#<%# String.Format("warehousedetail{0}", GetIdCounter(false))%>" data-toggle="collapse" data-target="<%# String.Format("#warehousedetail{0}", GetIdCounter(true).ToString()) %>">
                            <asp:Literal runat="server" ID="WarehouseName"></asp:Literal>
                        </a>
                        <div id="<%# String.Format("warehousedetail{0}", GetIdCounter(false))%>" class="collapse">
                            <asp:Literal runat="server" ID="WarehouseContactInfo"></asp:Literal>
                            <br />
                            Address:
                            <asp:HyperLink ID="WarehouseAddress" runat="server" Target="_blank"></asp:HyperLink>
                        </div>
                    </td>
                    <td class="text-center hidden-xs">
                        <asp:Literal runat="server" ID="WarehouseIsAvailable"></asp:Literal>
                    </td>
                    <td class="text-center hidden-xs">
                        <%# Eval("ReservedQuantity") %> units
                    </td>
                    <td class="text-center">
                        <%# Eval("InStockQuantity") %> units
                    </td>
                    <td class="text-center">
                        <asp:HyperLink ID="PickUpButton" runat="server" CssClass="btn btn-info col-xs-12">
                                Pick
                        </asp:HyperLink>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
               </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Literal ID="Notification" runat="server"></asp:Literal>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
  </div>
 </div>
</div>