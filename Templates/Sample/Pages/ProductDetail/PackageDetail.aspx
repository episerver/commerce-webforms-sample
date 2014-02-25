<%@ Page Language="c#" MasterPageFile="../../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductDetail.PackageDetail" CodeBehind="PackageDetail.aspx.cs" %>

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
</asp:Content>