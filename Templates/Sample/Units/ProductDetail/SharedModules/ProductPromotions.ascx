<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductPromotions.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.ProductPromotions" %>

<asp:PlaceHolder runat="server" Visible="False" ID="PromotionsHolder">
    <strong>Promotions:</strong>
    <ul class="list-unstyled">
        <asp:Literal ID="Promotions" runat="server"></asp:Literal>    
    </ul>
    <hr />
</asp:PlaceHolder>