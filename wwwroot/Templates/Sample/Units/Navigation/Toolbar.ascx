<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Toolbar.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation.Toolbar" %>
<!-- ToolBar START -->
<div id="ToolBar">
    <div id="ToolBarContent">
        <asp:LoginStatus ID="LoginStatusCtrl" 
            LoginImageUrl="~/Images/Key.png" LogoutImageUrl="~/Images/UserRed.png" 
            ToolTip="Log in/out" runat="server" />
        <asp:LoginName ID="LoginNameCtrl"  runat="server" />

        <span class="LangAndSearchText">Language</span>
        <select id="LanguageSelection"  title="Language">
            <option id="Swedish" selected="selected">Swedish</option>
            <option id="English">English</option>
            <option id="Norwegian">Norwegian</option>
        </select>
        <span class="LangAndSearchText">Quick Search</span>
        <asp:TextBox ID="QuickSearchTextBox"  runat="server" />
        <asp:ImageButton ImageUrl="~/Images/Search.gif" ID="SearchButton" OnClick="SearchButton_Click" 
            CssClass="ToolBarImage" AlternateText="QuickSearch" ImageAlign="AbsMiddle" runat="server" />
    </div>
</div>
<!-- ToolBar END -->
