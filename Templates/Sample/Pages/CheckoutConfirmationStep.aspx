<%@ Page Language="C#" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" CodeBehind="CheckoutConfirmationStep.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.CheckoutConfirmationStep" %>
<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <div class="page-header">
                <h1>
                    THANK YOU FOR YOUR ORDER
                </h1>
                <hr />
                <div class="jumbotron">
                    <p>
                          Your order number is :
                          <strong><asp:Literal runat="server" ID="liPONumber"></asp:Literal></strong>
                    </p>
                   
                    <p>
                          Total order :  
                          <strong><asp:Literal runat="server" ID="liTotal"></asp:Literal></strong>
                    </p>
                    
                </div>
            </div>
        </div>
    </div>
</asp:Content>
