﻿<%@ Page Language="c#" MasterPageFile="../../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductListing.DepartmentNodeWithItems" CodeBehind="DepartmentNodeWithItems.aspx.cs" %>
<%@ Register Src="../../Units/CategoryDisplay/DepartmentNodeWithEntries.ascx" TagName="DisplayTemplate" TagPrefix="product" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
         <product:DisplayTemplate runat="server" ID="DisplayTemplateID" ShowVariations="true" />

        </div>
    </div>
   
</asp:Content>
