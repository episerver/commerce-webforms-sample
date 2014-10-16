<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangeAccountInfo.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.ChangeAccountInfo" %>
<%@ Register TagPrefix="CMSNav" TagName="SideNav" Src="Controls/SideNav.ascx" %>

<div class="row C_Account-Control">
	<div class="col-md-9 col-md-push-3">
		<h3>
			Edit Account Information
		</h3>
		<p>
			You are editing Your Account Information
		</p>
		<hr />
		<fieldset>
			<legend>User Name, Roles and Password</legend> 
			<div class="form-group">
				<label class="control-label">Your User Name.</label> 
				<div class="controls docs-input-sizes">
					<h5>
						casekraker/chris@mediachase.com
					</h5>
					<hr />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">Your Roles/Privileges.</label> 
				<div class="controls">
					<h5>
						- Everyone
					</h5>
					<h5>
						- Registered
					</h5>
				</div>
			</div>
		</fieldset>
		<hr />
		<fieldset>
			<legend>Contact Information and Preferences</legend> 
			<div class="form-group">
				<label class="control-label">Contact Information</label> 
				<div class="controls">
					<input type="text" placeholder="First Name" class="col-md-6" />
					<input type="text" placeholder="Middle Name" class="col-md-6" />
					<input type="text" placeholder="Last Name" class="col-md-6" />
					<input type="text" placeholder="e-mail Address" class="col-md-4" />
					<span class="help-inline">Please correct the error</span> 
					<hr />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label">Shopping Preferences</label> 
				<div class="controls">
					<h6>
						Preferred Language
					</h6>
					<select>
						<option value="30"> English </option>
						<option value="90"> French </option>
					</select>
					<h6>
						Preferred Currency
					</h6>
					<select>
						<option value="30"> US Dollars </option>
						<option value="90"> Lira </option>
					</select>
				</div>
			</div>
		</fieldset>
		<hr />
		<p>
			<a class="btn btn-sm btn-info" href="#">Save</a> <a class="btn btn-sm btn-info" href="#"> Cancel</a>
		</p>
	</div>    
	<div class="col-md-3 col-md-pull-9">
        <CMSNav:SideNav ID="SideNav" runat="server" />
	</div>
</div>