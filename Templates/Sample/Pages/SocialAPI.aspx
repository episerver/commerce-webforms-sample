<%@ Page Title="SocialAPI" Language="C#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" AutoEventWireup="true" EnableViewState="false" EnableSessionState="ReadOnly" CodeBehind="SocialAPI.aspx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.SocialApi" %>
<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="col-md-9">
    Twitter:
      <asp:Repeater ID="twitterRepeater" runat="server" OnItemDataBound="twitterRepeater_OnItemDataBound">
       <ItemTemplate>
        <table style="border:solid 1px black;width:500px;font-family:Arial">
        <tr>
         <td style="font-weight:bold">
          <asp:Label ID="TwitterDate" runat="server"></asp:Label>
         </td>
        </tr>
        <tr>
         <td style="font-weight:bold">
          <asp:HyperLink ID="TwitterLink" runat="server" Target="_blank"></asp:HyperLink>
         </td>
        </tr>
        <tr>
        </tr>
        <tr>
        </tr>
        </table>
        <br />
       </ItemTemplate>
      </asp:Repeater>
    </div>
    <div class="col-md-9">
    Delicious:
        <asp:Repeater ID="deliciousRepeater" runat="server" OnItemDataBound="deliciousRepeater_OnItemDataBound">
         <ItemTemplate>
          <table style="border:solid 1px black;width:500px;font-family:Arial">
          <tr>
           <td style="font-weight:bold">
            <asp:Label ID="DeliciousDate" runat="server"></asp:Label>
           </td>
          </tr>
          <tr>
           <td style="font-weight:bold">
            <asp:HyperLink ID="DeliciousLink" runat="server"></asp:HyperLink>
           </td>
          </tr>
          <tr>
          </tr>
          <tr>
          </tr>
          </table>
            <br />
       </ItemTemplate>
       </asp:Repeater>
    </div>
        <div class="col-md-9">
    Instagram:
    <br />
        <asp:Repeater ID="instagramRepeater" runat="server" OnItemDataBound="instagramRepeater_OnItemDataBound">
         <ItemTemplate>
            <asp:HyperLink ID="InstagramLink" runat="server"><asp:Image id="InstagramImage" runat="server" /></asp:HyperLink>
            <br />
       </ItemTemplate>
       </asp:Repeater>
    </div>
</asp:Content>
