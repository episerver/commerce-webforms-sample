<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.ChangePassword" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row row-offcanvas row-offcanvas-right C_Account-Control">
    <div class="col-md-9 col-md-push-3">
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
        <h3>
            Change Account Password 
            <asp:Label ID="PasswordSuccessful" EnableViewState="false" runat="server" ForeColor="ForestGreen" />
        </h3>
        <p>
            You are changing your account password. 
        </p>
        <hr />
        <div class="form-group row">
            <label class="col-md-12 control-label">Enter Your Current Password.</label> 
            <div class="col-md-5">
                <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" Cssclass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                    ErrorMessage="This field is required" CssClass="danger"
                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                <asp:Label ID="passwordError" EnableViewState="false" runat="server" ForeColor="Red" />
            </div>
        </div>
        <hr />
        <div class="form-group row">
            <label class="col-md-12 control-label">Enter Your New Password Twice for Confirmation.</label>
            <div class="col-md-5">
                <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" Cssclass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                    ErrorMessage="This field is required"
                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                <br />
                <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" Cssclass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                    ErrorMessage="This field is required"
                    ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                    ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="The new passwords don't match"
                    ValidationGroup="ChangePassword1"></asp:CompareValidator>
            </div>
        </div>
        <p>
            <asp:Button ID="save" CssClass="btn btn-sm btn-primary" runat="server" Text="Save" OnClick="savePassword_Click"/>
            <asp:Button ID="cancel" CssClass="btn btn-sm btn-default icon-remove-sign" runat="server" Text="Cancel" OnClick="cancel_Click" />
        </p>
    </div>
    <div class="col-md-3 col-md-pull-9 sidebar-offcanvas">
        <CMSNav:SideNav ID="SideNav" runat="server" />
    </div>
</div>
