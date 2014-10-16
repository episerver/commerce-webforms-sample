<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.MarketNotSupported" CodeBehind="MarketNotSupported.aspx.cs" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <h1>
                Not available in your market
            </h1>
            <hr>
        </div>
    </div>
    <p>
        The requested item is not available in your market.
    </p>
</asp:Content>
