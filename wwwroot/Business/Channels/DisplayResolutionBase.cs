using EPiServer.Framework.Localization;
using EPiServer.ServiceLocation;
using EPiServer.Web;

namespace EPiServer.Templates.Alloy.Business.Channels
{
    /// <summary>
    /// Base class for all resolution definitions
    /// </summary>
    public abstract class DisplayResolutionBase : IDisplayResolution
    {
        private static readonly LocalizationService _localizationService = ServiceLocator.Current.GetInstance<LocalizationService>();
        private string _nameOrResourceKey;

        /// <summary>
        /// Initializes a new instance of the <see cref="DisplayResolutionBase"/> class.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="width">The width in pixels.</param>
        /// <param name="height">The height in pixels.</param>
        protected DisplayResolutionBase(string name, int width, int height)
        {
            Id = this.GetType().FullName;
            _nameOrResourceKey = name;
            Width = width;
            Height = height;
        }

        /// <summary>
        /// Gets the unique id for this resolution
        /// </summary>
        public string Id { get; protected set; }

        /// <summary>
        /// Gets the name of resolution.
        /// </summary>
        public string Name
        {
            get
            {
                return Translate(_nameOrResourceKey);
            }
        }

        /// <summary>
        /// Gets the resolution width in pixels.
        /// </summary>
        public int Width { get; protected set; }

        /// <summary>
        /// Gets the resolution height in pixels.
        /// </summary>
        public int Height { get; protected set; }

        private static string Translate(string resurceKey)
        {
            string value;

            if (!_localizationService.TryGetString(resurceKey, out value))
            {
                value = resurceKey;
            }

            return value;
        }
    }
}