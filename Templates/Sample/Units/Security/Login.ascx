<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Security.Login" %>

<div class="row C_Security-Login">
    <div class="col-md-6 col-md-push-6">
        <h3>
            Returning Customer 
        </h3>
        <p>
            Sign in to your account. 
        </p>
        <div class="well">
            <asp:Panel runat="server" DefaultButton="SignInId" class="form-group">
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span> 
					<input type="text" id="EmailAddress_ExistingId" autocomplete="off" placeholder="Enter Email Address" name="EmailAddress_Existing" class="form-control" runat="server"/>
				</div>
                <asp:RequiredFieldValidator ID="ValidateExistingEmailId" runat="server" ErrorMessage="*" ControlToValidate="EmailAddress_ExistingId" ValidationGroup="ExistingGroup"/>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
					<input type="password" id="Password_ExistingId" autocomplete="off" placeholder="Enter Password" name="Password" class="form-control" runat="server"/>                                 
				</div>
                <asp:RequiredFieldValidator ID="ValidateExistingPasswordId" runat="server" ErrorMessage="*" ControlToValidate="Password_ExistingId" ValidationGroup="ExistingGroup" Display="Dynamic"/>
				<label class="checkbox"><input type="checkbox" name="RememberMe" /> Remember Me Next Time</label> 
                <asp:LinkButton Id="SignInId" CssClass="btn btn-sm btn-info" OnClick="loginExisting_Click" runat="server" CausesValidation="true" ValidationGroup="ExistingGroup" ><i class="glyphicon glyphicon-lock"></i> Sign In</asp:LinkButton>
                <asp:Label ID="SignInFailureText" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label> 
            </asp:Panel>
            
			<a href="#" data-toggle="collapse" data-target="#demo">Forgot Your Password?</a> 
			<div id="demo" class="collapse">
				<p>
					Enter your e-mail and we will send you a link to reset your password. 
				</p>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span> 
					<input type="text" placeholder="Enter Email Address" class="form-control"> 
				</div>
					<a class="btn btn-sm btn-info" href="#"><i class="glyphicon glyphicon-lock"></i> Reset password</a>
			</div>
		</div>
		<div>
		</div>
	</div>
	<div class="col-md-6 col-md-pull-6">
		<h3>
			New Customer? 
		</h3>
		<p>
			<strong>Create an account</strong> to take advantage of the features and benefits that make shopping faster and easier. 
		</p>
        <div class="form-group">
            <asp:Panel ID="RegisterPanel" DefaultButton="CreateNewId" runat="server">
                <input type="text" id="FirstNameId" placeholder="Enter First Name" name="FirstName" class="form-control" runat="server" maxlength="64"/>
                <asp:RequiredFieldValidator ID="FirstNameValidatorId" runat="server" ErrorMessage="*" ControlToValidate="FirstNameId" ValidationGroup="CreateGroup" />
                <input type="text" id="LastNameId" placeholder="Enter Last Name" name="LastName" class="form-control" runat="server" maxlength="64"/>
                <asp:RequiredFieldValidator ID="LastNameValidatorId" runat="server" ErrorMessage="*" ControlToValidate="LastNameId" ValidationGroup="CreateGroup"  Display="Dynamic"/>
                <hr />
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                    <input type="text" id="EmailAddressNewId" autocomplete="off" placeholder="Enter Email Address" name="EmailAddress_New" class="form-control" runat="server" />
                </div>
                <asp:RequiredFieldValidator ID="EmailAddressNewValidatorId" runat="server" ErrorMessage="*" ControlToValidate="EmailAddressNewId" ValidationGroup="CreateGroup"/>
                <asp:RegularExpressionValidator ID="EmailAddressNewRegExValidatorId" runat="server" ErrorMessage="*" ValidationExpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+" ControlToValidate="EmailAddressNewId" ValidationGroup="CreateGroup" Display="Dynamic"/>

                <input type="text" id="EmailAddressConfirmId" autocomplete="off" placeholder="Confirm Email Address" name="EmailAddressNew_Confirm" class="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="ConfirmEmailValidatorId" runat="server" ErrorMessage="*" ControlToValidate="EmailAddressConfirmId" ValidationGroup="CreateGroup"   Display="Dynamic"/>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="EmailAddressNewId"
                    Enabled="true" ControlToValidate="EmailAddressConfirmId" ErrorMessage="Email addresses must match"
                    ValidationGroup="CreateGroup"  Display="Dynamic">
                </asp:CompareValidator>
                <hr />
                <div class="input-group">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                    <input type="password" id="Password_NewId" autocomplete="off" placeholder="Enter Password" name="Password1" class="form-control" runat="server" />
                </div>
                <asp:RequiredFieldValidator ID="PasswordNewValidtorId" runat="server" ErrorMessage="*" ControlToValidate="Password_NewId" ValidationGroup="CreateGroup"/>

                <input type="password" id="PasswordConfirmId" autocomplete="off" placeholder="Confirm Password" name="Password2" class="form-control" runat="server" />
                <asp:RequiredFieldValidator ID="PasswordConfirmValidatorId" runat="server" ErrorMessage="*" ControlToValidate="PasswordConfirmId" ValidationGroup="CreateGroup"  Display="Dynamic"/>
                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password_NewId"
                    Enabled="true" ControlToValidate="PasswordConfirmId" ErrorMessage="Passwords must match"
                    ValidationGroup="CreateGroup"  Display="Dynamic">
                </asp:CompareValidator>
                <hr />
                    <input type="text" placeholder="Enter Zip Code" class="form-control">
                <label class="checkbox"><input type="checkbox" name="SendMeEmail" /> Send me e-mail updates about the latest products and promotions. </label> 
                <div>
                    <asp:LinkButton ID="CreateNewId" CssClass="btn btn-sm btn-info" OnClick="loginCreateNew_Click" runat="server" CausesValidation="true" ValidationGroup="CreateGroup"><i class="glyphicon glyphicon-lock "></i> Create an Account</asp:LinkButton>
                    <asp:Label ID="CreateFailureText" runat="server" CssClass="danger"></asp:Label>
                </div>
            </asp:Panel>
        </div>
    </div>
</div>
