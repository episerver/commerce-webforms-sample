using System;
using System.Web;
using System.Web.Profile;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Markets;
using Mediachase.Commerce.Website;
using EPiServer.Security;
using System.Web.SessionState;

namespace EPiServer.Commerce.Sample.Helpers
{
    /// <summary>
    /// Implementation of current market selection that stores information in user profile.
    /// </summary>
    public class MarketStorage : ICurrentMarket
    {
        private const string _marketIdKey = "MarketId";
        private readonly IMarketService _marketService;

        /// <summary>
        /// Initializes a new instance of the <see cref="MarketStorage"/> class.
        /// </summary>
        public MarketStorage()
            : this(ServiceLocation.ServiceLocator.Current.GetInstance<IMarketService>())
        { }

        /// <summary>
        /// Initializes a new instance of the <see cref="MarketStorage"/> class.
        /// </summary>
        /// <param name="marketService">The market service.</param>
        public MarketStorage(IMarketService marketService)
        {
            _marketService = marketService;
        }

        /// <summary>
        /// Gets the <see cref="IMarket"/> selected in the current user profile, if the value is
        /// set and the indicated market is valid; ; otherwise, gets the default <see cref="IMarket"/>.
        /// </summary>
        /// <returns>The current <see cref="IMarket"/>.</returns>
        public IMarket GetCurrentMarket()
        {
            var profileMarketId = GetStoredMarketId();
            
            var marketId = string.IsNullOrEmpty(profileMarketId) ? MarketId.Default : new MarketId(profileMarketId);
            var market = _marketService.GetMarket(marketId);

            if (market == null && marketId != MarketId.Default)
            {
                market = _marketService.GetMarket(MarketId.Default);
            }

            UpdateProfile(market);

            return market;
        }

        /// <summary>
        /// Sets the current market, if <paramref name="marketId"/> represents a valid market;
        /// otherwise, performs no action.
        /// </summary>
        /// <param name="marketId">The market id.</param>
        /// <remarks>This will also set the current currency for the ECF context.</remarks>
        public void SetCurrentMarket(MarketId marketId)
        {
            var market = _marketService.GetMarket(marketId);
            if (market != null)
            {
                UpdateProfile(market);
                SiteContext.Current.Currency = market.DefaultCurrency;
                Globalization.ContentLanguage.PreferredCulture = market.DefaultLanguage;
            }
        }

        /// <summary>
        /// Updates the profile.
        /// </summary>
        /// <param name="market">The market.</param>
        /// <remarks>Store selected market id in profile if user is logged in, otherwise store it in cookie.</remarks>
        private void UpdateProfile(IMarket market)
        {
            var profile = GetProfileStorage();
            if (profile != null)
            {
                UpdateProfile(profile, market);
            }
            else if (HttpContext.Current != null)
            {
                UpdateProfile(HttpContext.Current.Response, market);
            }
        }

        private void UpdateProfile(ProfileBase profileStorage, IMarket market)
        {
            var originalMarketId = profileStorage[_marketIdKey] as string;
            var currentMarketId = market == null || market.MarketId == MarketId.Default ? string.Empty : market.MarketId.Value;
            if (!string.Equals(originalMarketId, currentMarketId, StringComparison.Ordinal))
            {
                profileStorage[_marketIdKey] = currentMarketId;
                profileStorage.Save();
            }
        }

        private void UpdateProfile(HttpResponse response, IMarket market)
        {
            var cookie = response.Cookies[_marketIdKey];
            var originalMarketId = cookie == null ? string.Empty : cookie.Value;
            var currentMarketId = market == null || market.MarketId == MarketId.Default ? string.Empty : market.MarketId.Value;
            if (!string.Equals(originalMarketId, currentMarketId, StringComparison.Ordinal))
            {
                cookie = new HttpCookie(_marketIdKey, currentMarketId);
                response.SetCookie(cookie);
            }
        }

        private ProfileBase GetProfileStorage()
        {
            var httpContext = HttpContext.Current;
            if (httpContext != null && httpContext.User.Identity.IsAuthenticated)
            {
                return httpContext.Profile;
            }
            return null;
        }

        /// <summary>
        /// Gets the stored market identifier.
        /// </summary>
        /// <returns></returns>
        /// <remarks>If user is logged in, try to get market id from profile,
        /// otherwise, get it from cookie.</remarks>
        private string GetStoredMarketId()
        {
            if (HttpContext.Current == null)
            {
                return string.Empty;
            }
            var profileStorage = GetProfileStorage();
            if (profileStorage != null)
            {
                return profileStorage[_marketIdKey] as string;
            }
            var cookie =  HttpContext.Current.Request.Cookies[_marketIdKey];
            if (cookie != null)
            {
                return cookie.Value;
            }
            return string.Empty; 
        }
    }
}