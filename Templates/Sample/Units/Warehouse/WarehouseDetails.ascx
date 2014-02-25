<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WarehouseDetails.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Warehouse.WarehouseDetails" %>

<div class="row C_Warehouse-Details">
    <div class="col-md-12">
        <h3><%= Translate("/Sample/Warehouse/AvailableProducts")%></h3>
            <asp:Literal runat="server" ID="noOrderMsg" Visible="false" Text="No Orders Yet" />
            <asp:Repeater EnableViewState="False" runat="server" ID="rptWarehouseInventoryList">
                <HeaderTemplate>
                    <h4>
                        <%# GetInventoryList() %>
                    </h4>
                    <table class="table table-striped table-bordered table-condensed">
                        <thead>
                            <tr>                            
                                <th>Entry Name</th>
                                <th>In Stock</th>
                                <th class="hidden-xs hidden-sm">Reserved</th>
                                <th class="hidden-xs hidden-sm">Preorder Qty</th>
                                <th class="hidden-xs hidden-sm">Backorder Qty</th>
                                <th class="hidden-xs hidden-sm">Preorder Available</th>
                                <th class="hidden-xs hidden-sm">Backorder Available</th>
                                <th>Warehouse Code</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>                   
                        <td>
                            <%# GetCatalogEntryName(((Mediachase.Commerce.Inventory.IWarehouseInventory) Container.DataItem).CatalogKey.CatalogEntryCode) %>
                        </td>
                        <td>
                            <%# Eval("InstockQuantity") %>
                        </td>
                        <td class="hidden-xs hidden-sm">
                            <%# Eval("ReservedQuantity") %>
                        </td>
                        <td class="hidden-xs hidden-sm">
                            <%# Eval("PreorderQuantity") %>
                        </td>
                        <td class="hidden-xs hidden-sm">
                            <%# Eval("PreorderQuantity") %>
                        </td>
                        <td class="hidden-xs hidden-sm">
                            <%# Eval("PreorderAvailabilityDate") %>
                        </td>
                        <td class="hidden-xs hidden-sm">
                            <%# Eval("BackorderAvailabilityDate") %>
                        </td>
                        <td>
                            <%# Eval("WarehouseCode") %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
</div>
<div class="row">
    <div class="form-horizontal col-sm-4 col-sm-push-8 col-xs-12 text-right">
      <div class="form-group">
        <label class="col-md-7 col-sm-4 col-xs-8 control-label">Page:</label>
        <div class="col-md-5 col-sm-8 col-xs-4">
          <asp:DropDownList runat="server" ID="PagerID" AutoPostBack="true" OnSelectedIndexChanged="Pager_OnSelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
        </div>
      </div>
    </div>
</div>