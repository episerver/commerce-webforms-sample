<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ErrorModule.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.ErrorModule" %>
<asp:ListView runat="server" ID="ErrorMessages">
    <LayoutTemplate>
        <div class="alert alert-danger">
            <button data-dismiss="alert" class="close" type="button">×</button>
            <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
        </div>
    </LayoutTemplate>
    <ItemTemplate> 
            <asp:Literal ID="ErrorMessageLabel" EnableViewState="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem")%>'></asp:Literal> 
    </ItemTemplate>
</asp:ListView>