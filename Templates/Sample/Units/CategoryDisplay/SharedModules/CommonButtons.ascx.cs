using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules
{
    public partial class CommonButtons : RendererControlBase<ProductContent>
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        
        /// <summary>
        /// Set current entry.
        /// </summary>
        /// <param name="entry"></param>
        public void SetEntry(Entry entry)
        {
            Entry = entry;
        }

        /// <summary>
        /// Handles the Click event of the AddToCart control. Add item to Cart.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void AddToCart_Click(object sender, EventArgs e)
        {
            var cart = new CartHelper(Cart.DefaultName);
            var wishList = new CartHelper(CartHelper.WishListName);

            if (Entry == null)
                return;
            
            if (Entry.Entries.Entry != null && Entry.Entries.Entry.Any())
            {
                Entry = Entry.Entries.Entry.First();
            }

            if (!Entry.EntryType.Equals(EntryType.Variation))
                return;

            cart.AddEntry(Entry, 1, false, new[] { wishList });
            Context.RedirectFast(GetUrl(Settings.CartPage));
        }

        /// <summary>
        /// Handles the Click event of the AddWishList control. Add item to Wish List.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void AddWishList_Click(object sender, EventArgs e)
        {
            var cart = new CartHelper(Cart.DefaultName);
            var wishList = new CartHelper(CartHelper.WishListName);

            if (Entry == null)
                return;

            var entry = CatalogContext.Current.GetCatalogEntry(Entry.CatalogEntryId, new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryFull));

            if (entry == null)
                return;

            if (entry.Entries.Entry != null && entry.Entries.Entry.Any())
            {
                entry = entry.Entries.Entry.First();
            }

            if (!entry.EntryType.Equals(EntryType.Variation))
                return;

            wishList.AddEntry(entry, 1, true, new[] { cart });
            Context.RedirectFast(GetUrl(Settings.WishListPage));
        }
    }
}
