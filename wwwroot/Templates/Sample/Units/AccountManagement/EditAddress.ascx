<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditAddress.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.EditAddress" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row row-offcanvas row-offcanvas-right C_Your-Account-Control">
	<div class="col-md-9 col-md-push-3">
        <div class="pull-right visible-sm visible-xs">
            <button type="button" class="btn btn-info btn-xs" data-toggle="offcanvas">Side bar</button>
        </div>
		<h3>
			Add/Edit Address
		</h3>
		<p>
			You are editing an existing address or you are creating a new address 
		</p>
		<hr />
		<asp:Panel runat="server" DefaultButton="save">
			<div class="form-group row">
				<label class="col-md-12 control-label">Address Name</label> 
				<div class="col-md-8">
					<asp:TextBox ID="addressName" runat="server" CssClass="form-control" placeholder="Address Name" MaxLength="50"></asp:TextBox>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-md-12 control-label">Contact Information</label> 
				<div class="col-md-8">
                    <asp:TextBox ID="firstName" runat="server" CssClass="form-control" placeholder="First Name" MaxLength="64"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ControlToValidate="firstName" CssClass="requiredfield">This is a required field.</asp:RequiredFieldValidator>
                    </small><br />
                    <asp:TextBox ID="lastName" runat="server" CssClass="form-control" placeholder="Last Name" MaxLength="64"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="reqLastName" runat="server" ControlToValidate="lastName" CssClass="requiredfield">This is a required field.</asp:RequiredFieldValidator>
                    </small><br />
                    <asp:TextBox ID="emailAddress" runat="server" CssClass="form-control" placeholder="e-mail Address" MaxLength="64"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="EmailRequiredField" ControlToValidate="emailAddress" Text="The field is required!" runat="server" EnableViewState="false" SetFocusOnError="true" Display="Dynamic" CssClass="requiredfield"/>
                        <asp:RegularExpressionValidator ID="ValidateEmail" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="emailAddress" Text="Input incorrect email address format!" EnableViewState="false" SetFocusOnError="true" CssClass="requiredfield"/>
                    </small>
                    <asp:TextBox ID="phoneNumber" runat="server" CssClass="form-control" placeholder="Phone Number (optional)" MaxLength="32"></asp:TextBox>
                    <small class="error"></small>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-md-12 control-label">Address</label> 
				<div class="col-md-8">
                    <asp:TextBox ID="companyName" runat="server" CssClass="form-control" placeholder="Company Name (Optional)" MaxLength="64"></asp:TextBox> &nbsp;
                    <asp:TextBox ID="address1" runat="server" CssClass="form-control" placeholder="Street Address" MaxLength="80"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="reqAddress1" runat="server" ControlToValidate="address1" CssClass="requiredfield">This is a required field.</asp:RequiredFieldValidator>
                    </small>
                    <asp:TextBox ID="address2" runat="server" CssClass="form-control" placeholder="Apt, Suite, Bldg. (Optional)" MaxLength="80"></asp:TextBox>
				</div>
			</div>
            <hr />
			<div class="form-group row">
				<label class="col-md-12 control-label">Address Location</label> 
				<div class="col-md-8">
                    <asp:TextBox ID="city" runat="server" CssClass="form-control" placeholder="City" MaxLength="64"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="reqCity" runat="server" ControlToValidate="city" CssClass="requiredfield">This is a required field.</asp:RequiredFieldValidator>
                    </small>
                </div>
                <div class="col-md-4">
                    <asp:DropDownList ID="state" runat="server" CssClass="form-control" DataTextField="Name" DataValueField="Name">
                    </asp:DropDownList>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-4">
                    <asp:TextBox ID="zipcode" runat="server" CssClass="form-control" placeholder="Postal Code" MaxLength="20"></asp:TextBox>
                    <small class="error">
                        <asp:RequiredFieldValidator ID="reqZipcode" runat="server" ControlToValidate="zipcode" CssClass="requiredfield" Display="Dynamic">This is a required field.</asp:RequiredFieldValidator>
                    </small>
                    <asp:TextBox ID="region" runat="server" CssClass="form-control" placeholder="Region" MaxLength="64"></asp:TextBox>
                </div>
			</div>
            <hr  class="clearfix"/>
			<div class="form-group row">
                <div class="col-md-4">
                    <asp:DropDownList ID="country" runat="server" CssClass="form-control" DataTextField="Name" DataValueField="Code" OnSelectedIndexChanged="country_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
            </div>
            <hr/>
			<div class="form-group row">
				<div class="col-md-8">
                    <label>
                        <asp:CheckBox ID="defaultShipping" runat="server" ClientIDMode="Static"/>
                        Click to Make this Your Default SHIPPING Address</label>
                    <br />
                    <label>
                        <asp:CheckBox ID="defaultBilling" runat="server" ClientIDMode="Static"/>
                        Click to Make this Your Default BILLING Address</label>
				</div>
			</div>
		</asp:Panel>
		<hr />
		<p>
            <asp:Button ID="save" OnClick="save_Click" runat="server" CssClass="btn btn-small btn-primary" Text="Save" />
            <asp:Button ID="cancel" OnClick="cancel_Click" runat="server" CssClass="btn btn-small btn-default" Text="Cancel" CausesValidation="false" />
		</p>
	</div>
	<div class="col-md-3 col-md-pull-9 col-sm-6 sidebar-offcanvas">
        <CMSNav:SideNav ID="SideNav" runat="server" />
	</div>
</div>