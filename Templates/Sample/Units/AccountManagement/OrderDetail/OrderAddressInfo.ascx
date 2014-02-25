<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderAddressInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.OrderAddressInfo" %>
<div style="word-wrap:break-word;">
    <p>
       <strong><%= HttpUtility.HtmlEncode(Name)%></strong>
        <p><%= HttpUtility.HtmlEncode(Line)%></p>
        <p><%= HttpUtility.HtmlEncode(City)%>, <%= HttpUtility.HtmlEncode(PostalCode)%></p>
        <p><%= HttpUtility.HtmlEncode(Country)%></p>
    </p>
</div>
