<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartAddressView.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.CartAddressView" %>
<div class="well" style="word-wrap:break-word;">
    <p>
        <strong><%= IsBillingAddress ? "Bill To:" : "Ship To:" %></strong>
        <br />
        <asp:Literal ID="litAddress" runat="server" />
    </p>
<% if (!UseWarehouseAddress) { %>
    <p>
        <div class="btn-group">
            <% if (AllowSaveAddressBook)
               {%>
                <a class="btn btn-info" onclick="UseAddressBook(<%= IsBillingAddress.ToString().ToLower() %><%= string.IsNullOrEmpty(ShipmentId)? "" : "," + ShipmentId %>);">Use Address Book</a>
                <% if (AllowAddNewAddress) {%>
                    <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#">
                        <span class="caret"></span>
                    </a>

                    <ul class="dropdown-menu">
                        <li>
                            <a class = '<%= (AllowSaveAddressBook ? "" : "btn btn-info")%>' onclick="NewAddress(<%= IsBillingAddress.ToString().ToLower() %>)">Creating a New Address</a>
                        </li>
                    </ul>
                <%} %>
            <%}  else {%>
                <a class ='btn btn-info' onclick="NewAddress(<%= IsBillingAddress.ToString().ToLower() %><%= string.IsNullOrEmpty(ShipmentId)? "" : "," + ShipmentId %>)">Creating a New Address</a>
            <%} %>
        </div>
    </p>
<% } %>
</div>