<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApplyCoupons.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.ApplyCoupons" %>

<div class="row C_Coupon-Discount-Center">
    <div class="col-md-12">
        <div class="well well-sm">
            Coupons and Promotional Codes
        </div>
        <i>Got a Coupon Code? Enter it and We Will Apply that to your cart as well.</i>
  <asp:Panel DefaultButton="ApplyCouponButton" runat="server" role="form">
          <div class="col-sm-4 col-xs-9">
            <asp:TextBox MaxLength="20" runat="server" ID="DiscountCouponCode" CssClass="form-control"  placeholder="Coupon code"></asp:TextBox>
          </div>
          <div class="col-sm-2 col-xs-3">
              <asp:Button CssClass="btn btn-default" UseSubmitBehavior="true" runat="server" ID="ApplyCouponButton" OnClick="ApplyCouponButton_Click" Text="Apply" />
          </div>
    </asp:Panel>
        <asp:ListView ID="lvDiscount" runat="server" DataKeyNames="DiscountId" ItemPlaceholderID="itemPlaceHolder" OnItemCommand="lvDiscount_ItemCommand">
            <LayoutTemplate>
                <div class="col-xs-12">
                    <h4>
                        Coupons have been applied:
                    </h4>
                    <ul>
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                    </ul>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <li><%# Eval("DiscountCode") %> <asp:LinkButton ID="removeDiscount" runat="server" Text="Remove" CommandName="DeleteCoupon" CommandArgument='<%# Eval("DiscountCode")%>' CssClass="btn btn-danger btn-xs"/></li>
            </ItemTemplate>
        </asp:ListView>
    </div>
</div>