<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingMethodInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail.ShippingMethodInfo" %>

<div class="row">
    <div class="col-md-12">
        <div class="well well-sm">
            Shipping Method
            <p>
                <strong>1 package via: </strong>
                <asp:Literal ID="ShippingMethod" runat="server" />
            </p>
        </div>
    </div>
</div>
