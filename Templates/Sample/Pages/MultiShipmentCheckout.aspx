<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MultiShipmentCheckout.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.MultiShipmentCheckout" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/MultiShipmentCheckout.ascx" TagPrefix="Sample" TagName="MultiShipmentCheckout" %>

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
         <Sample:MultiShipmentCheckout runat="server" id="MultiShipmentCheckoutID" />
    </asp:PlaceHolder>
</asp:Content>
