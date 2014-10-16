<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CartSimpleModule.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.CartSimpleModule" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/CartSimpleModule.ascx" TagPrefix="Sample" TagName="CartSimpleModule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
    <asp:PlaceHolder runat="server" ID="modulePlaceHolder">
        <Sample:CartSimpleModule runat="server" id="CartSimpleModuleID" />
    </asp:PlaceHolder>
</asp:Content>
