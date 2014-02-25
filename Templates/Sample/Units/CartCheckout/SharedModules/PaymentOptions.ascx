<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentOptions.ascx.cs"
    Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.PaymentOptions" %>
<div class="row C_Order-Payment-Options">
     <div class="col-md-12">
        <div class="well well-sm">
                Payment Options
        </div>
        <div class="row C_Order-Payment-Options">
            <div class="col-md-8 col-md-push-4">
                <asp:Repeater runat="server" ID="PaymentOptionList">
                    <HeaderTemplate>
                            <ul id="tabPayment" class="nav nav-pills nav-justified">
                    </HeaderTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                    <ItemTemplate>
                        <li id='<%# "tab" + GetControlIDFromPayment(Container.DataItem)%>'>
                            <a href="#<%# GetControlIDFromPayment(Container.DataItem)%>" data-toggle="tab">
                                <%# ((Mediachase.Commerce.Orders.PaymentMethod) Container.DataItem).Name.ToString() %>
                            </a>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                <div id="myTabContent" class="tab-content">
                    <asp:PlaceHolder runat="server" ID="PaymentContent" />
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var activeControlId = '<%=ActiveControlId%>';

        $('#tabPayment #tab' + activeControlId).addClass('active');
    })
</script>
