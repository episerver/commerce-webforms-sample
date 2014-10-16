<%@ Control Language="C#" CodeBehind="DepartmentNodeWithEntries.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.DepartmentNodeWithEntries" %>
<%@ Import Namespace="EPiServer.Commerce.Catalog.ContentTypes" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<%@ Register Src="SharedModules/CategoryTopMenu.ascx" TagName="CategoryTopMenu" TagPrefix="catalog" %>
<%@ Register Src="SharedModules/CommonButtons.ascx" TagName="CommonButtons" TagPrefix="catalog" %>
<%@ Register Src="SharedModules/CommonPricingInfo.ascx" TagName="CommonPricingInfo" TagPrefix="catalog" %>
<%@ Register Src="../Navigation/PagingMenu.ascx" TagName="PagingMenu" TagPrefix="catalog" %>
<script type="text/javascript">
    $(function () {
        setViewMode = function (viewName) {
            //reset style 
            $('#gridContent').removeClass('listview');
            $('#gridContent > div').removeAttr('class');

            //set custom view mode
            if (viewName == 'ListView') {
                $('#gridContent').addClass('listview');
                $('#gridContent > div').addClass('col-md-12 col-sm-12');
            } else if (viewName == 'SmallGrid') {
                $('#gridContent > div').addClass('col-md-2 col-sm-3');
            } else {
                $('#gridContent > div').addClass('col-md-3 col-sm-4');
            }
        };

        // Change view 
        $('#viewlist a').click(function (event) {
            event.preventDefault();
            var currentMode = $(this).attr('mode');

            $('#viewlist a').each(function () {
                if ($(this).attr('mode') != currentMode) {
                    $(this).parent().removeClass('active');
                } else {
                    $(this).parent().addClass('active');
                }
            });

            setViewMode(currentMode);
        });

        setViewMode('LargeGrid');
    });
</script>

<div class="row C_Business-Control4">
    <div class="col-md-12">
        <catalog:CategoryTopMenu ID="CategoryTopMenuID" runat="server" />
        <h1>You Are Shopping in the <EPiServer:Property PropertyName="DisplayName" runat="server" /> Department </h1>
        <hr />
        <div class="row">
            <div class="col-md-8 hidden-xs">
                <ul id="viewlist" class="nav nav-pills">
                    <li class="active"><a href="#" mode="LargeGrid"><i class="glyphicon glyphicon-th-large"></i> Large Grid</a></li>
                    <li><a href="#" mode="SmallGrid"><i class="glyphicon glyphicon-th"></i> Small Grid</a></li>
                    <li><a href="#" mode="ListView"><i class="glyphicon glyphicon-th-list"></i> List View</a></li>
                </ul>
            </div>
            <asp:DataPager QueryStringField="p" ID="pagerTop" PageSize="20" runat="server" PagedControlID="EntriesList"  class="pull-right"  >
                <Fields>
                    <asp:TemplatePagerField>
                        <PagerTemplate>
                            <catalog:PagingMenu runat="server" FirstItemIndex='<%# Container.StartRowIndex %>' PageSize='<%# Container.PageSize %>' TotalItems='<%# Container.TotalRowCount %>' />
                        </PagerTemplate>
                    </asp:TemplatePagerField>
                </Fields>
            </asp:DataPager>
        </div>
        <asp:ListView Visible="true" ID="entriesList" EnableViewState="false" runat="server" ItemPlaceholderID="itemPlaceHolder">
            <EmptyDataTemplate>
                <h3>There are no results.</h3>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <div id="gridContent" class="row">
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="col-md-3 col-sm-4">
                    <div class="thumbnail">
                        <asp:HyperLink runat="server" NavigateUrl='<%# GetUrl((EntryContentBase) Container.DataItem) %>'>
                            <asp:Image runat="server" ID="Image1" AlternateText="dx Asset" />
                        </asp:HyperLink>
                        <div class="caption">
                            <h4 class="truncate">
                                <asp:HyperLink runat="server" NavigateUrl='<%# GetUrl((EntryContentBase) Container.DataItem) %>'>
                                        <%#  WebStringHelper.EncodeForWebString(((EntryContentBase) Container.DataItem).DisplayName) %>
                                </asp:HyperLink>
                            </h4>
                            <hr />
                            <ul class="list-unstyled">
                                <li class="truncate">Brand:
                                    <%# WebStringHelper.EncodeForWebString(GetFacetBrand((EntryContentBase) Container.DataItem)) %></li>
                                <li>In Stock:
                                    <asp:Literal ID="InStock" runat="server"></asp:Literal></li>
                                <li class="truncate">Model:
                                    <%# WebStringHelper.EncodeForWebString(GetModelNumber((EntryContentBase) Container.DataItem)) %></li>
                                <li class="truncate">Customer Reviews: ****</li>
                            </ul>
                            <hr />
                            <catalog:CommonPricingInfo runat="server" ID="PricingInfo" />
                            <hr />
                            <asp:PlaceHolder runat="server" Visible="False" ID="PromotionsHolder">
                                <strong>Promotions:</strong>
                                <ul class="list-unstyled">
                                    <asp:Literal ID="Promotions" runat="server"></asp:Literal>    
                                </ul>
                                <hr />
                            </asp:PlaceHolder>
                            <div class="btn-group">
                                <a class="btn btn-info" href="<%# GetUrl((EntryContentBase) Container.DataItem) %>"><i class="glyphicon glyphicon-list-alt"></i> View Detail</a>
                                <a class="btn btn-info dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a>
                                <catalog:CommonButtons runat="server" ID="CommonButtons" />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
        <div class="pull-right">
            <asp:DataPager QueryStringField="p" ID="pagerBottom" PageSize="20" runat="server" PagedControlID="EntriesList">
                <Fields>
                    <asp:TemplatePagerField>
                        <PagerTemplate>
                            <catalog:PagingMenu runat="server" FirstItemIndex='<%# Container.StartRowIndex %>' PageSize='<%# Container.PageSize %>' TotalItems='<%# Container.TotalRowCount %>' />
                        </PagerTemplate>
                    </asp:TemplatePagerField>
                </Fields>
            </asp:DataPager>
        </div>
        
        <hr />
    </div>
</div>