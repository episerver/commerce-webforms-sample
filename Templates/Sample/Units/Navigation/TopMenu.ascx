<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopMenu.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation.TopMenu" %>
<nav class="navbar navbar-inverse" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>

      <a href="/" target="new" class="navbar-brand visible-xs">
        <img style="max-width: 136px;" src="/templates/UX/skin.sample/img/episerver_logo_inver.png" alt="">
      </a>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<EPiServer:MenuList PageLink="<%# EPiServer.Core.PageReference.StartPage %>" ID="MenuListCtrl" runat="server">
    <HeaderTemplate>
    <ul class="nav navbar-nav">
    </HeaderTemplate>
    <ItemTemplate>
        <li>
            <EPiServer:Property PropertyName="PageLink" ID="TopMenuPropPageLink1" runat="server" />
        </li>
    </ItemTemplate>
    <SelectedTemplate>
        <li class="active">
            <EPiServer:Property PropertyName="PageLink" ID="TopMenuPropPageLink2" runat="server" />
        </li>
    </SelectedTemplate>
    <FooterTemplate>
    </ul>
    </FooterTemplate>
</EPiServer:MenuList>
    <a href="#" id="search-btn" class="navbar-form navbar-right visible-sm"><span class="glyphicon glyphicon-search"></span></a>
    <asp:Panel ID="Panel1" DefaultButton="SearchButton" runat="server" CssClass="navbar-form navbar-right">
      
      <div id="search-form" class="form-group col-xs-12 hidden-sm">
          <div class="col-xs-9">
              <asp:TextBox CssClass="form-control" placeholder="Search" ID="SearchKeywords" runat="server" />
          </div>
          <asp:Button CssClass="btn btn-info col-xs-3" OnClick="PerformSearch" ID="SearchButton" Text="Search"  runat="server" />
      </div>
        
    </asp:Panel>
  </div><!-- /.navbar-collapse -->
</nav>
<script>
    $(function () {
        $('#search-btn').click(function (e) {
            e.preventDefault();
            $('#search-form').toggleClass('hidden-sm');
        });
    });
</script>