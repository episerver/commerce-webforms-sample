<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" AutoEventWireup="true" CodeBehind="EditAddress.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.EditAddress" %>
<%@ Register Src="~/Templates/Sample/Units/AccountManagement/EditAddress.ascx" TagName="EditAddress" TagPrefix="Sample" %>

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
        <Sample:EditAddress ID="EditAddressID" runat="server"></Sample:EditAddress>
    </asp:PlaceHolder>
</asp:Content>