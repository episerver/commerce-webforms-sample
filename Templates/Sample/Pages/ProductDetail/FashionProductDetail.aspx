<%@ Page Language="c#" MasterPageFile="../../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductDetail.FashionProductDetail" CodeBehind="FashionProductDetail.aspx.cs" %>
<%@ Register Src="../../Units/ProductDetail/Clothing/ClothingProductDisplayTemplate.ascx" TagName="DisplayTemplate" TagPrefix="product" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
         
         <product:DisplayTemplate runat="server" ID="DisplayTemplateID" />

        </div>
    </div>
   
</asp:Content>
