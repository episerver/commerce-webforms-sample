<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.Warehouses" CodeBehind="Warehouses.aspx.cs" %>

<%@ Register Src="../Units/Warehouse/WarehouseList.ascx" TagName="WarehouseList" TagPrefix="product" %>
<%@ Register Src="../Units/Warehouse/WarehouseDetails.ascx" TagName="WarehouseDetails" TagPrefix="product" %>


<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-sm-12">
            <h1>
                <Episerver:Property propertyname="PageTitle" id="PageTitleID" runat="server" />
            </h1>
            <h4 class="subheader">
                <Episerver:Property propertyname="PageSubHeader" id="PageSubHeaderID" runat="server" />
            </h4>
            <hr>
        </div>
    </div>
    <div class="row C_Business-Control1">
        <div class="col-sm-4 col-md-3">
            <product:WarehouseList runat="server" id="WarehouseList">
            </product:WarehouseList>
        </div>
        <div class="col-sm-8 col-md-9">
            <product:WarehouseDetails runat="server" id="WarehouseDetails">
            </product:WarehouseDetails>
            <Episerver:Property propertyname="BodyMarkup" id="BodyMarkupID" runat="server" />
        </div>
    </div>
</asp:Content>
