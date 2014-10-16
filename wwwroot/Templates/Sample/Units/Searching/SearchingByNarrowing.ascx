<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchingByNarrowing.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.Searching.SearchingByNarrowing" %>
<%@ Import Namespace="Mediachase.Commerce.Website.Search" %>
<%@ Import Namespace="Mediachase.Search" %>
<%@ Import Namespace="Mediachase.Commerce.Catalog.Objects" %>
<%@ Import Namespace="Mediachase.Commerce.Website.Helpers" %>
<%@ Import Namespace="EPiServer.Commerce.Sample.Helpers" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<div class="row C_Search-Browse-Filter">
    <div class="col-md-3">
        <asp:Repeater runat="server" ID="ActiveFilterList" EnableViewState="false">
            <HeaderTemplate>
                <div class="well">
                    <ul class="list-unstyled">
                        <li>
                            <h3>
                                Active Filters
                            </h3>
                        </li>
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <%# Eval("Name") %>:<%# Eval("ValueName") %>
                    <asp:HyperLink ID="activefacet" runat="server" Text="[X]" NavigateUrl='<%# Eval("RemoveUrl") %>'>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul> <a href='<%# SearchFilterHelper.Current.GetCleanUrl() %>'>Clear All</a> </div>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Repeater runat="server" ID="FilterList" EnableViewState="false">
            <HeaderTemplate>
                <div class="well">
                    <h3>
                        Narrow By
                    </h3>
            </HeaderTemplate>
            <ItemTemplate>
                <ul class="nav nav-list">
                    <li class="nav-header">
                        <%# Eval("Name") %></li>
                    <asp:Repeater runat="server" ID="ValueList" DataSource='<%# Eval("Facets") %>'>
                        <ItemTemplate>
                            <li><a href='<%# GetFacetUrl((ISearchFacet) Container.DataItem) %>'>
                                <%# Eval("Name").ToString().Trim() %>(<%# Eval("Count") %>) </a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </ItemTemplate>
            <FooterTemplate>
                </div>
                <hr />
            </FooterTemplate>
        </asp:Repeater>
    </div>
    <div class="col-md-9">
        <h3>
            Search Results
        </h3>
        <hr />
        <div class="row">
            <div class="col-md-4">
                <ul class="nav nav-pills">
                    <li><a href="#"><i class="glyphicon glyphicon-th-large"></i>Large Grid</a></li>
                    <%--  <li class="active"><a href="page-search-browse-filter-small-grid.html"><i class="glyphicon glyphicon-th "></i>Small Grid</a></li>
                    <li><a href="page-search-browse-filter-list-view.html"><i class="glyphicon glyphicon-th-list"></i>List View</a></li>--%>
                    <li>
                        <asp:LinkButton ID="lnkGrid" CssClass="btn" runat="server" Text="Small Grid" OnClick="lnkGrid_Click" />
                    </li>
                    <li>
                        <asp:LinkButton ID="lnkList" CssClass="btn" runat="server" Text="List View" OnClick="lnkList_Click" /></li>
                </ul>
            </div>
            <div class="col-md-5">
                <%--     <asp:DropDownList runat="server" ID="SortBy" AutoPostBack="true">
                    <asp:ListItem Text="Product Name" Value="name"></asp:ListItem>
                   <asp:ListItem Text="Price Low to High" Value="plh"></asp:ListItem>
                    <asp:ListItem Text="Price High to Low" Value="phl"></asp:ListItem>
                </asp:DropDownList>--%>
                <div class="pagination pagination-right">
                    <ul>
                        <li>
                            <asp:DataPager QueryStringField="p" ID="DataPager3" runat="server" PagedControlID="EntriesList" PageSize="25">
                                <Fields>
                                    <med:CmsNumericPagerField NextPageText="&gt; &gt;" CurrentPageLabelCssClass="" PreviousPageText="&lt; &lt;" />
                                </Fields>
                            </asp:DataPager>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <asp:ListView Visible="true" ID="EntriesList" EnableViewState="true" runat="server" GroupItemCount="4" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="CatalogEntryId" OnPagePropertiesChanging="EntriesList_PagePropertiesChanging">
            <EmptyDataTemplate>
                <h4>
                    Sorry, no matching results
                </h4>
            </EmptyDataTemplate>
            <GroupTemplate>
                <ul class="thumbnails">
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                </ul>
            </GroupTemplate>
            <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="groupPlaceholder"></asp:PlaceHolder>
            </LayoutTemplate>
            <ItemTemplate>
                <li class="col-md-2">
                    <div class="thumbnail">
                        <asp:HyperLink ID="HyperLink5" runat="server" CssClass="thumbnail" NavigateUrl='<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>'>
                  

                         <img src= "<%# AssetHelper.GetAssetUrl((Entry) (Container.DataItem)) %>" /></a>
                   

                        </asp:HyperLink>
                        <div class="caption">
                            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>'>
                            <%# StoreHelper.GetEntryDisplayName((Entry) Container.DataItem) %>
                            </asp:HyperLink>
                            <hr />
                            <strike>$100.00</strike><strong>
                                <%# GetPrice((Entry) Container.DataItem) %>
                            </strong>
                            <hr />
                            <div class="btn-group">
                                <a class="btn btn-info" href="<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>"><i class="glyphicon glyphicon-list-alt"></i>View Detail</a> <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><i class="glyphicon glyphicon-heart"></i>Add to Wishlist</a></li>
                                    <li><a href="#"><i class="glyphicon glyphicon-cog"></i>Post to Facebook</a></li>
                                    <li><a href="#"><i class="glyphicon glyphicon-cog"></i>Post to Twitter</a></li>
                                    <li class="divider"></li>
                                    <li><a href="#"><i class="glyphicon glyphicon-gift"></i>Create Custom Gift Card</a></li>
                                    <li class="divider"></li>
                                    <li><a href="#"><i class="glyphicon glyphicon-envelope"></i>eMail Share</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </li>
            </ItemTemplate>
        </asp:ListView>
        <asp:ListView Visible="true" ID="listView" EnableViewState="true" runat="server" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="CatalogEntryId" OnPagePropertiesChanging="listView_PagePropertiesChanging">
            <EmptyDataTemplate>
                <h4>
                    Sorry, no matching results</h4>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>
                                Image
                            </th>
                            <th>
                                Name/Description
                            </th>
                            <th>
                                Price
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td style="width: 20%;">
                        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="thumbnail" NavigateUrl='<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>'>
                            <img Style="max-height: 200px;" src= "<%# AssetHelper.GetAssetUrl((Entry) (Container.DataItem)) %>" /></a>
                        </asp:HyperLink>
                    </td>
                    <td style="width: 60%;">
                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>'>
                            <%# StoreHelper.GetEntryDisplayName((Entry) Container.DataItem) %>
                        </asp:HyperLink>
                        <br />
                        <br />
                        <p>
                            <%# WebStringHelper.EncodeForWebString(((Entry) (Container.DataItem)).ItemAttributes["Info_Description"].ToString()) %>
                        </p>
                        <br />
                        Inventory:<strong>
                            <%# ((Entry) (Container.DataItem)).Inventory != null
                                  ? ((Entry) (Container.DataItem)).Inventory.InStockQuantity.ToString("f0")
                                  : "" %>
                            Available</strong>
                        <br />
                        This Item Generally Ships Within 3 Days.
                    </td>
                    <td style="width: 20%;">
                        List Price: <strike> $100.00<%--<%# ((Entry) (Container.DataItem)).ItemAttributes.ListPrice.FormattedPrice %>--%></strike>
                        <br />
                        <br />
                        Your Price: <strong>
                            <%-- <%# StoreHelper.GetSalePrice((Entry) Container.DataItem, 1).FormattedPrice %>--%>$80.00</strong>
                        <br />
                        <br />
                        You Save <strong>$XX.XX</strong>
                        <hr />
                        <div class="btn-group">
                            <a class="btn btn-info" href="<%# ResolveUrl(StoreHelper.GetEntryUrl((Entry) Container.DataItem)) %>"><i class="glyphicon glyphicon-list-alt"></i>View Detail</a> <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#"><i class="glyphicon glyphicon-heart"></i>Add to Wishlist</a></li>
                                <li><a href="#"><i class="glyphicon glyphicon-cog"></i>Post to Facebook</a></li>
                                <li><a href="#"><i class="glyphicon glyphicon-cog"></i>Post to Twitter</a></li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="glyphicon glyphicon-gift"></i>Create Custom Gift Card</a></li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="glyphicon glyphicon-envelope"></i>eMail Share</a></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <hr />
    </div>
</div>
