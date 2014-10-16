<%@ Page Language="c#" MasterPageFile="../../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductDetail.EntryContentDetail" CodeBehind="EntryContentDetail.aspx.cs" %>
<%@ Register TagPrefix="product" TagName="VariationDetails" Src="~/Templates/Sample/Units/ProductDetail/VariationDetails.ascx" %>
<%@ Register TagPrefix="product" TagName="VariationSelector" Src="~/Templates/Sample/Units/ProductDetail/VariationSelector.ascx" %>
<%@ Register TagPrefix="product" TagName="CommonModule" Src="~/Templates/Sample/Units/ProductDetail/SharedModules/CommonModule.ascx" %>

<%@ Import Namespace="EPiServer.Commerce.Sample.Helpers" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-Header">
        <div class="col-md-12">
            <h1>
                <EPiServer:Property runat="server" PropertyName="DisplayName" />
            </h1>
            <hr />
        </div>
    </div>
    <div class="row C_Product-Detail">
        <div class="col-md-3 C_Product-Images">
            <EPiServer:Property runat="server" PropertyName="CommerceMediaCollection" CssClass="img-responsive"></EPiServer:Property>
        </div>
        <div class="col-md-6 C_Product-Detail">
            Code: 
            <EPiServer:Property runat="server" PropertyName="Code" />
        </div>
        <div class="col-md-3 C_Product-ItemSelector">

        </div>
    </div>
    <product:CommonModule runat="server" />
</asp:Content>
