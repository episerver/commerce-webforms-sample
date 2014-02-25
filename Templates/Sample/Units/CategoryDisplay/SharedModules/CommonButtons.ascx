<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommonButtons.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules.CommonButtons" %>

<ul class="dropdown-menu">
    <li><asp:LinkButton  ID="btnAddToCart" OnClick="AddToCart_Click" runat="server"><i class="glyphicon glyphicon-shopping-cart"></i> Add to Cart</asp:LinkButton></li>
    <li><asp:LinkButton  ID="btnAddWishList" OnClick="AddWishList_Click" runat="server"><i class="glyphicon glyphicon-heart"></i> Add to Wish List</asp:LinkButton></li>
    <li><a href="#"><i class="glyphicon glyphicon-cog"></i> Post to Facebook</a></li>
    <li><a href="#"><i class="glyphicon glyphicon-cog"></i> Post to Twitter</a></li>
    <li class="divider"></li>
    <li><a href="#"><i class="glyphicon glyphicon-gift"></i> Create Custom Gift Card</a></li>
    <li class="divider"></li>
    <li><a href="#"><i class="glyphicon glyphicon-envelope"></i> eMail Share</a></li>
</ul>