<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchingByNarrowing.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.SearchingByNarrowing" MasterPageFile="~/Templates/Sample/MasterPages/StarterDemoDefault.Master" %>
<%@ Register Src="~/Templates/Sample/Units/Searching/SearchingByNarrowing.ascx" TagPrefix="Sample" TagName="SearchingByNarrowing" %>

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
        <Sample:SearchingByNarrowing runat="server" id="SearchingByNarrowingID" />
    </asp:PlaceHolder>
</asp:Content>
