<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.Search" CodeBehind="Search.aspx.cs" %>

<%@ Import Namespace="Mediachase.Commerce.Catalog.Objects" %>
<%@ Import Namespace="Mediachase.Commerce.Website.Helpers" %>
<%@ Import Namespace="EPiServer.Commerce.Sample.Helpers" %>
<%@ Import Namespace="EPiServer.Commerce.Extensions" %>
<%@ Import Namespace="EPiServer.Globalization" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<%@ Register Src="~/Templates/Sample/Units/CategoryDisplay/SharedModules/CommonButtons.ascx" TagName="CommonButtons" TagPrefix="catalog" %>
<%@ Register Src="~/Templates/Sample/Units/CategoryDisplay/SharedModules/CommonPricingInfo.ascx" TagName="CommonPricingInfo" TagPrefix="catalog" %>
<%@ Register Src="~/Templates/Sample/Units/Navigation/PagingMenu.ascx" TagName="PagingMenu" TagPrefix="catalog" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <h1>
                Keyword Search Example
            </h1>
            <h4>
                Enter a Keyword Search which will search across all of the catalogs you have loaded right now. Be sure and try to use slight mispellings or related words to test out the fuzzy search and replacement values.
            </h4>
        </div>
    </div>
    <div class="row C_Keyword-Search">
        <div class="col-md-12">
            <h3>Search By Keyword(s)
            </h3>
            <div class="well">
                <div class="controls">
                    <asp:Panel ID="SearchPanel" DefaultButton="searchButton" runat="server" CssClass="form-inline">
                        <div class="form-group">
                            <asp:TextBox ID="search" placeholder="Enter Keyword(s)" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:DropDownList ID="ClassType" runat="server" CssClass="form-control" >
                                <asp:ListItem Selected="True" Value="All">All</asp:ListItem>
                                <asp:ListItem Value="Product">Only Products</asp:ListItem>
                                <asp:ListItem Value="Variation">Only Items</asp:ListItem>
                                <asp:ListItem Value="Bundle">Only Bundles</asp:ListItem>
                                <asp:ListItem Value="Package">Packages</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="searchButton" CssClass="btn btn-info" runat="server" Text="Search" OnClick="Search_Click" />
                   </asp:Panel>
                </div>
            </div>
            <asp:PlaceHolder Visible="False" ID="SearchResultSummaryPlaceHolder" runat="server">
            <div class="row ">
                <div class="col-md-8">
                    <h2>Search Result</h2>
                    <p>You search for&nbsp;<i><%: search.Text %></i> resulted in&nbsp;<asp:Literal ID="NumberOfHits" runat="server" />&nbsp;hits.</p>
                </div>
                 <div class="pull-right">
                    <asp:DataPager QueryStringField="p" ID="pagerTop" PageSize="20" runat="server" PagedControlID="searchResults">
                        <Fields>
                            <asp:TemplatePagerField>
                                <PagerTemplate>
                                    <catalog:PagingMenu runat="server" FirstItemIndex='<%# Container.StartRowIndex %>' PageSize='<%# Container.PageSize %>' TotalItems='<%# Container.TotalRowCount %>' />
                                </PagerTemplate>
                            </asp:TemplatePagerField>
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
            </asp:PlaceHolder>
            <asp:ListView ID="searchResults" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="CatalogEntryId">
                <LayoutTemplate>
                    <div class="row row-border hidden-xs">
                        <div class="col-sm-2"><strong>Image</strong></div>
                        <div class="col-sm-7"><strong>Name / Description</strong></div>
                        <div class="col-sm-3"><strong>Price</strong></div>
                    </div>
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="row row-border">
                        <div class="col-sm-2">
                            <asp:HyperLink runat="server" CssClass=""  NavigateUrl='<%# ((Entry)Container.DataItem).GetProductLink(ContentLanguage.PreferredCulture.Name)%>'>
                                <img src= "<%# AssetHelper.GetAssetUrl((Entry)(Container.DataItem))%>" class="img-responsive" /></a>
                            </asp:HyperLink>
                        </div>
                        <div class="col-sm-7">
                            <h4><asp:HyperLink runat="server" NavigateUrl='<%# ((Entry)Container.DataItem).GetProductLink(ContentLanguage.PreferredCulture.Name)%>'>
                            <%# Server.HtmlEncode(StoreHelper.GetEntryDisplayName((Entry)Container.DataItem))%>
                            </asp:HyperLink></h4>
                            <p>
                                <%# ((Entry)(Container.DataItem)).ItemAttributes["Info_Description"].ToString()%>
                            </p>
                            <p>Inventory: <strong>
                                <%# ((Entry)(Container.DataItem)).Inventory != null
                                  ? ((Entry)(Container.DataItem)).Inventory.InStockQuantity.ToString("f0")
                                  : ""%>
                                Available</strong>
                            </p>
                            <p>
                                This Item Generally Ships Within 3 Days.
                            </p>
                        </div>
                        <div class="col-sm-3">
                            <catalog:CommonPricingInfo runat="server" ID="PricingInfo" /> 
                            <div class="btn-group">            
                                <a class="btn btn-info" href="<%# ((Entry)Container.DataItem).GetProductLink(ContentLanguage.PreferredCulture.Name)%>"><i class="glyphicon glyphicon-list-alt"></i> View Detail</a>
                                <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                <catalog:CommonButtons runat="server" ID="CommonButtons" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <div class="pull-right">
                <asp:DataPager QueryStringField="p" ID="pagerBottom" PageSize="20" runat="server" PagedControlID="searchResults">
                    <Fields>
                        <asp:TemplatePagerField>
                            <PagerTemplate>
                                <catalog:PagingMenu runat="server" FirstItemIndex='<%# Container.StartRowIndex %>' PageSize='<%# Container.PageSize %>' TotalItems='<%# Container.TotalRowCount %>' />
                            </PagerTemplate>
                        </asp:TemplatePagerField>
                    </Fields>
                </asp:DataPager>
            </div>
        </div>
    </div>
</asp:Content>