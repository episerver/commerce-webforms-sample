<%@ Page Language="c#" MasterPageFile="../MasterPages/StarterDemoDefault.Master" Inherits="EPiServer.Commerce.Sample.Templates.Sample.Pages.Home" CodeBehind="Home.aspx.cs" %>

<asp:Content ContentPlaceHolderID="MainContent" ID="content" runat="server">
    <div class="row C_Page-header">
        <div class="col-md-12">
            <EPiServer:Property PropertyName="HomeHero" ID="HomeHeroID" runat="server" />
        </div>
    </div>
    <div class="row C_Background-Education">
        <div class="col-md-12">
            <h2>Demo Site Overview </h2>
            <hr />
            <p>
                This sample has been developed to help you better understand the platform APIs and quickly get your project, demo or proof of concept off the ground and then easily continue development in order to get the project to production ready standard.
            </p>
            <div class="row">
                <div class="col-md-6">
                    <ul>
                        <li>
                            <h3>Responsive Design / Multi-channel </h3>
                            Multiple channels can be developed using a responsive design approach. This allows the users to easily review and manage the online customer experience for different touch-points. Also allowing users to review customer and order activity by channel.
                        </li>
                        <li>
                            <h3>Multiple Shopping Experiences </h3>
                            Multiple approaches to some key e-commerce shopping experiences to browse, search for and purchase products are featured in this sample.
                        </li>
                        <li>
                            <h3>Search, Facets, and Filtering </h3>
                            Out of the box search for effective search and filtering of products.
                        </li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul>
                        <li>
                            <h3>Content Management &amp; Re-Use </h3>
                            All content in the sample site can be content managed and localized appropriate to the market. The site showcases how to use block to efficiently re-use content around the site and to provide re-usable e-commerce components.
                        </li>
                        <li>
                            <h3>Cart, Promotions, and Discounts </h3>
                            Cart functionality that evaluates and displays all of the promotions and discount the customer is eligible for at that point in time.
                        </li>
                        <li>
                            <h3>Customer Self Service </h3>
                            Full features allow customers to self-service their account details and history. 
                        </li>
                    </ul>
                </div>
                <div class="col-md-12">
                    <hr />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
