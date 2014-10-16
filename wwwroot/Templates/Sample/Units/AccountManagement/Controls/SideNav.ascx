<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideNav.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.Controls.SideNav" %>
<div class="panel panel-primary">
    <div class="panel-heading">Main Options:</div>
    <div class="list-group">
        <a class="list-group-item" href="<%= GetUrl(Settings.AccountPage) %>"><i class="glyphicon glyphicon-user"></i> Your Account</a>
        <a class="list-group-item" href="<%= GetUrl(Settings.YourOrdersPage) %>"><i class="glyphicon glyphicon-credit-card"></i> Your Orders</a>
        <a class="list-group-item" href="<%= GetUrl(Settings.AddressesPage) %>"><i class="glyphicon glyphicon-list-alt"></i> Your Addresses</a>
        <a class="list-group-item" href="<%= GetUrl(Settings.WishListPage) %>"><i class="glyphicon glyphicon-heart-empty"></i> Your Wish List</a>
        <a class="list-group-item" href="<%= GetUrl(Settings.ChangePasswordPage) %>"><i class="glyphicon glyphicon-lock"></i> Change Password</a>
    </div>
    <div class="panel-heading">More Options:</div>
    <div class="list-group">
        <a class="list-group-item" href="#"><i class="glyphicon glyphicon-file"></i> FAQs</a>
        <a class="list-group-item" href="#"><i class="glyphicon glyphicon-headphones"></i> Customer Service</a>
        <a class="list-group-item" href="#"><i class="glyphicon glyphicon-leaf"></i> Help</a>
    </div>
</div>