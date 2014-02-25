<%@ Control Language="C#" CodeBehind="CommonNodeList.ascx.cs" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules.CommonNodeList" %>
<%@ Import Namespace="EPiServer.Commerce.Sample" %>
<%@ Import Namespace="EPiServer.Commerce.Catalog.ContentTypes" %>
<%@ Import Namespace="EPiServer.Core.Html" %>
<asp:Repeater EnableViewState="False" runat="server" ID="rptCategoryList" >
    <HeaderTemplate>
        <div class="row">
    </HeaderTemplate>
    <FooterTemplate>
        </div>
    </FooterTemplate>
    <ItemTemplate>
        <div class="col-sm-4 col-md-3">
            <div class="thumbnail">
                <a href='<%# GetUrl((NodeContent)Container.DataItem) %>'>
                    <img src="<%# GetMediaUrl((NodeContent)Container.DataItem) %>" alt="dx Asset" />
                </a>
                <div class="caption">
                    <h3 class="truncate">
                        <a href='<%# GetUrl((NodeContent)Container.DataItem) %>'>
                            <%# WebStringHelper.EncodeForWebString(((NodeContent)Container.DataItem).Name) %>
                        </a>
                    </h3>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
