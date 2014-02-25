<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SingleShipmentCheckout.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.SingleShipmentCheckout" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" %>
<%@ Register Src="~/Templates/Sample/Units/CartCheckout/SingleShipmentCheckout.ascx" TagPrefix="Sample" TagName="SingleShipmentCheckout" %>

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
         <Sample:SingleShipmentCheckout runat="server" id="SingleShipmentCheckoutID" />
    </asp:PlaceHolder>
</asp:Content>
