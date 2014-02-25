<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ErrorModalModule.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules.ErrorModalModule" %>
<div id='errormodal' class="modal fade">
 <div class="modal-dialog">
  <div class="modal-content">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">&times;</a>
        <h3>
            Please verify the follow information:
        </h3>
    </div>
    <div class="modal-body">
        <asp:ListView runat="server" ID="ErrorMessages">
            <LayoutTemplate>
                <div class="alert alert-danger">
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <asp:Literal ID="ErrorMessageLabel" EnableViewState="false" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem")%>'></asp:Literal>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
  </div>
 </div>
</div>