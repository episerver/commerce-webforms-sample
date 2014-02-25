<%@ Page Language="c#" MasterPageFile="../../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductDetail.VariationDetail" CodeBehind="VariationDetail.aspx.cs" %>
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
            <h4>Short Copy to quickly Highlight the product from a marketing perspective or just drop this line completely. </h4>
            <hr />
        </div>
    </div>
    <div class="row C_Product-Detail">
        <div class="col-md-3 C_Product-Images">    
                <EPiServer:Property runat="server" PropertyName="CommerceMediaCollection" CssClass="img-responsive"></EPiServer:Property>
        </div>
        <div class="col-md-6 C_Product-Detail">
            <product:VariationDetails runat="server" />
        </div>
        <div class="col-md-3 C_Product-ItemSelector">
            <product:VariationSelector runat="server" />
        </div>
    </div>
    <product:CommonModule runat="server" />
</asp:Content>
