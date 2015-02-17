<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddressControl.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.AddressControl" %>

<script type="text/javascript">
    function UseAddressBook(isBilling, shipmentId) {
        $('#' + '<%=addressType.ClientID %>').val(isBilling ? 'billing' : 'shipping');
        if (!isBilling && shipmentId) {
            $('#' + '<%=shipmentId.ClientID %>').val(shipmentId);
        }
        $('#select-existing-address').modal('show');
            }

    function NewAddress(isBilling, shipmentId) {
        $('#' + '<%=addressType.ClientID %>').val(isBilling ? 'billing' : 'shipping');
        if (isBilling) {
            $('#sameAddressTypeText').text('shipping');
        } else {
            $('#sameAddressTypeText').text('billing');
        }
        if (!isBilling && shipmentId) {
            $('#' + '<%=shipmentId.ClientID %>').val(shipmentId);
        }
        $('#create-new-address').modal('show');
    }
</script>

<asp:HiddenField ID="shipmentId" runat="server" />
<asp:HiddenField ID="addressType" runat="server" />
<asp:TextBox ID="addressSelectType" runat="server" CssClass="hide" />

<div id="select-existing-address" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4>
        Select the Address to Use
    </h4>
      </div>
      <div class="modal-body">
    <table class="table table-striped table-bordered table-condensed">
        <thead>
            <tr>
                <th>Address Name</th>
                <th>Address</th>
            </tr>
        </thead>
        <asp:ListView ID="addressBook" runat="server" ItemPlaceholderID="itemPlaceHolder">
            <EmptyDataTemplate>
                <tbody>
                    <tr>
                        <td colspan="2">
                            You don't have any addresses saved currently.
                        </td>
                    </tr>
                </tbody>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <tbody>
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
                </tbody>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:LinkButton ID="useAddress" runat="server" CommandArgument='<%# Eval("AddressId") %>' CommandName="UseAddress" Text='<%# HttpUtility.HtmlEncode(Eval("Name")) %>' />
                    </td>
                    <td> 
                        <address>
                            <asp:Literal ID="address" runat="server" />
                        </address>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </table>
</div> 
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
            <i class="glyphicon glyphicon-remove-sign "></i> Cancel</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
    
</div> 
<div id="create-new-address"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
     <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Add/Edit Address</h4>
          </div>
          <div class="modal-body">
    <p>
        You are editing an Existing Address or You are Creating a New Address
    </p>
    <hr />
                <div class="form-group row">
                    <label class="col-md-12 control-label">Address Name</label> 
                    <div class="col-md-8">
                        <asp:TextBox ID="Name" runat="server" CssClass="form-control" placeholder="Address Name" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="AddressNameRequireField" ControlToValidate="Name" Text="The field is required!" runat="server"  ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield" Display="Dynamic"/>
            </div>
            </div>
                    <div class="form-group row">
                        <label class="col-md-12 control-label">Contact Information</label> 
                        <div class="col-md-8">
                            <asp:TextBox ID="FirstName" runat="server" Cssclass="form-control" placeholder="First Name" MaxLength="64" />
                            <asp:RequiredFieldValidator ID="FirstNameRequiredField" ControlToValidate="FirstName" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>
                        
                            <asp:TextBox ID="LastName" runat="server" Cssclass="form-control" placeholder="Last Name" MaxLength="64" />
                            <asp:RequiredFieldValidator ID="LastNameRequiredField" ControlToValidate="LastName" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>
                       
                            <asp:TextBox ID="Email" runat="server" Cssclass="form-control" placeholder="e-mail Address" MaxLength="64" />
                            <asp:RequiredFieldValidator ID="EmailRequiredField" ControlToValidate="Email" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>
                    <asp:RegularExpressionValidator ID="ValidateEmail" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="Email" Text="Input incorrect email address!" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield" Display="Dynamic"/>
                      
                            <asp:TextBox ID="Phone" runat="server" Cssclass="form-control" placeholder="Phone Number" MaxLength="32" />
                    <asp:RequiredFieldValidator ID="PhoneRequiredField" ControlToValidate="Phone" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield" Display="Dynamic"/>
                </div>
            </div>
            <hr />
                <div class="form-group row">
                    <label class="col-md-12 control-label">Address</label> 
                    <div class="col-md-12">
                        <asp:TextBox ID="CompanyName" runat="server" Cssclass="form-control" placeholder="Company Name" MaxLength="80" />
                        <asp:RequiredFieldValidator ID="CompanyNameRequiredField" ControlToValidate="CompanyName" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>

                        <asp:TextBox ID="StreetAddress" runat="server" Cssclass="form-control" placeholder="Street Address" MaxLength="80" />
                        <asp:RequiredFieldValidator ID="StreetAddressRequiredField" ControlToValidate="StreetAddress" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield" />

                        <asp:TextBox ID="Apartment" runat="server" Cssclass="form-control" placeholder="Apt, Suite, Bldg." MaxLength="80" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Apartment" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"  Display="Dynamic"/>
            </div>
        </div>
    <hr />
        <div class="form-group row">
                <label class="col-md-12 control-label">Address Location</label> 
                <div class="col-md-8">
                    <asp:TextBox ID="City" runat="server" Cssclass="form-control" placeholder="City" MaxLength="64" />
                    <asp:RequiredFieldValidator ID="CityRequiredField" ControlToValidate="City" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>

                    <asp:TextBox ID="State" runat="server" Cssclass="form-control" placeholder="State" MaxLength="64" />
                    <asp:RequiredFieldValidator ID="StateRequiredField" ControlToValidate="State" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield"/>

                    <asp:TextBox ID="Zip" runat="server" Cssclass="form-control" placeholder="Postal Code" MaxLength="20" />
                    <asp:RequiredFieldValidator ID="ZipRequiredField" ControlToValidate="Zip" Text="The field is required!" runat="server" ValidationGroup="CreateAddress" SetFocusOnError="true" CssClass="requiredfield" Display="Dynamic"/>
            <hr />
            <label class="control-label">Country</label> 
                    <asp:DropDownList ID="Country" runat="server" DataTextField="Name" DataMember="Country" DataValueField="Code" CssClass="form-control"/>
        </div>
        </div>
        <div class="form-group row" id="saveAddressBook">
            <label class="col-md-12 control-label"><asp:CheckBox type="checkbox" ID="AddAddressToContact" runat="server" AutoPostBack="false"/> 
            Save Address to Address Book</label> 
        </div>
        <div class="form-group row" id="UseSameAddressContainer" runat="server">
            <label class="col-md-12 control-label"><asp:CheckBox type="checkbox" ID="UseSameAddress" runat="server" AutoPostBack="false"/> 
            Use the same address for <span id="sameAddressTypeText">shipping</span>.</label> 
        </div>
        </div>
          <div class="modal-footer">
                <asp:LinkButton CssClass="btn btn-primary" OnClick="SaveAddress" runat="server" ID="SaveAddressButton" UseSubmitBehavior="true" ValidationGroup="CreateAddress">
                    <i class="glyphicon glyphicon-ok-sign "></i> Save
        </asp:LinkButton>
                <a class="btn btn-default" data-dismiss="modal">
                    <i class="glyphicon glyphicon-remove-sign "></i> Cancel
        </a>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
   
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var allowSaveAddressBook = '<%=AllowSaveAddressBook%>';
        if (allowSaveAddressBook.toLowerCase() === "false") {
            $('#saveAddressBook').remove();
        }
    })
</script>
