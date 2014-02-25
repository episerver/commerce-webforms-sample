<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.Default" CodeBehind="default.aspx.cs" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <h1>
                <EPiServer:Property PropertyName="PageTitle" ID="PageTitleID" runat="server" />
            </h1>
            <h4 class="subheader">
                <EPiServer:Property PropertyName="PageSubHeader" ID="PageSubHeaderID" runat="server" />
            </h4>
            <hr>
        </div>
    </div>
    <EPiServer:Property PropertyName="BodyMarkup" ID="BodyMarkupID" runat="server" />
</asp:Content>
