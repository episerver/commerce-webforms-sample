using EPiServer.Commerce.Catalog.Linking;
namespace EPiServer.Commerce.Sample
{
    /// <summary>
    /// Commerce Sample Constants
    /// </summary>
    public static class Constants
    {
        /// <summary>
        /// The last visited url of CatalogNode.     
        /// </summary>
        public const string LastCatalogPageUrl = "LastCatalogPageUrl";

        /// <summary>
        /// Cart Validate workflow name
        /// </summary>
        public const string CartValidateWorkflowName = "CartValidate";
    
        /// <summary>
        /// The amount type of value based
        /// </summary>
        public const string AmountTypeValueBased = "Value";

        /// <summary>
        /// The ware house code query string
        /// </summary>
        public const string WarehouseCodeQuery = "code";

        /// <summary>
        /// The default warehouse's 
        /// </summary>
        public const string DefaultWarehouseCode = "default";

        /// <summary>
        /// The Exchange Payment Method code query string
        /// </summary>
        public const string ExchangePaymentType = "Mediachase.Commerce.Orders.ExchangePayment, Mediachase.Commerce";
        
        /// <summary>
        /// The Invoice Payment Method 
        /// </summary>
        public const string InvoicePaymentType = "Mediachase.Commerce.Orders.InvoicePayment, Mediachase.Commerce";

        /// <summary>
        /// The Other Payment Method 
        /// </summary>
        public const string OtherPaymentType = "Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce";

        /// <summary>
        /// The GiftCard Payment Method
        /// </summary>
        public const string GiftCardPaymentType = "Mediachase.Commerce.Orders.GiftCardPayment, Mediachase.Commerce";

        /// <summary>
        /// The CashCard Payment Method
        /// </summary>
        public const string CashCardPaymentType = "Mediachase.Commerce.Orders.CashCardPayment, Mediachase.Commerce";

        /// <summary>
        /// The CreditCard Payment Method
        /// </summary>
        public const string CreditCardPaymentType = "Mediachase.Commerce.Orders.CreditCardPayment, Mediachase.Commerce";

        /// <summary>
        /// The last coupon code
        /// </summary>
        public const string LastCouponCode = "LastCouponCode";

        /// <summary>
        /// The "Default" group name
        /// </summary>
        public const string DefaultGroupName = AssociationGroup.DefaultName;

        /// <summary>
        /// The "CrossSell" group name
        /// </summary>
        public const string CrossSellGroupName = "CrossSell";

        /// <summary>
        /// The "Accessories" group name
        /// </summary>
        public const string UpSellGroupName = "UpSell";
    }
}
