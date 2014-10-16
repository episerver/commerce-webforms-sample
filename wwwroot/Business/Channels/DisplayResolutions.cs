namespace EPiServer.Templates.Alloy.Business.Channels
{
    /// <summary>
    /// Defines resolution for desktop displays
    /// </summary>
    public class StandardResolution : DisplayResolutionBase
    {
        public StandardResolution()
            : base("Standard (1366x768)", 1366, 768)
        {
        }
    }

    /// <summary>
    /// Defines resolution for a horizontal iPad
    /// </summary>
    public class IpadHorizontalResolution : DisplayResolutionBase
    {
        public IpadHorizontalResolution()
            : base("iPad horizontal (1024x768)", 1024, 768)
        {
        }
    }

    /// <summary>
    /// Defines resolution for a vertical iPhone 5s
    /// </summary>
    public class IphoneVerticalResolution : DisplayResolutionBase
    {
        public IphoneVerticalResolution()
            : base("iPhone vertical (320x568)", 320, 568)
        {
        }
    }

    /// <summary>
    /// Defines resolution for a vertical Android handheld device
    /// </summary>
    public class AndroidVerticalResolution : DisplayResolutionBase
    {
        public AndroidVerticalResolution()
            : base("Android vertical (480x800)", 480, 800)
        {
        }
    }
}