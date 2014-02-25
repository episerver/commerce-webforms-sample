<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MarketSelector.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls.MarketSelector" %>
<asp:Repeater ID="MarketList" runat="server" OnItemDataBound="MarketList_ItemDataBound" OnItemCommand="MarketList_ItemCommand">
    <HeaderTemplate>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" data-target="dropdown-menu" href="#">
                <asp:Literal ID="litCurrentMarket" runat="server"></asp:Literal> <i class="caret"></i>
            </a>
            <ul class="dropdown-menu rightposition">
    </HeaderTemplate>
    <FooterTemplate>
            </ul>
        </li>
    </FooterTemplate>
    <ItemTemplate>
        <li id="liMarketItem" runat="server">
            <asp:LinkButton ID="linkSetMarket" runat="server" CommandArgument="<%# ((Mediachase.Commerce.IMarket) Container.DataItem).MarketId %>" CommandName="SetMarket"><%# ((Mediachase.Commerce.IMarket) Container.DataItem).MarketName %></asp:LinkButton>
        </li>
    </ItemTemplate>
</asp:Repeater>