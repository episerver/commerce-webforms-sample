using System;
using System.ComponentModel;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Website;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    /// <summary>
    ///  Displays quantity field for an item
    /// </summary>
    public partial class EntryQuantityControl : System.Web.UI.UserControl
    {
        decimal? _quantity = null;
        /// <summary>
        /// Gets the quantity.
        /// </summary>
        /// <value>The quantity.</value>
        public decimal? Quantity
        {
            get
            {
                if (QuantityTextBox.Visible && !String.IsNullOrEmpty(QuantityTextBox.Text))
                    return Decimal.Parse(QuantityTextBox.Text);
                else if (QuantityDropDown.Visible && !String.IsNullOrEmpty(QuantityDropDown.SelectedValue))
                    return Decimal.Parse(QuantityDropDown.SelectedValue);

                return _quantity;
            }
            set
            {
                _quantity = value;
                EnsureChildControls();
            }
        }

        decimal _minQuantity = 1;
        /// <summary>
        /// Gets or sets the min quantity.
        /// </summary>
        /// <value>The min quantity.</value>
        [Bindable(true)]
        public decimal MinQuantity
        {
            get
            {
                return _minQuantity;
            }
            set
            {
                _minQuantity = value;
                EnsureChildControls();
            }
        }

        decimal _maxQuantity = 10;
        /// <summary>
        /// Gets or sets the min quantity.
        /// </summary>
        /// <value>The min quantity.</value>
        [Bindable(true)]
        public decimal MaxQuantity
        {
            get
            {
                return _maxQuantity;
            }
            set
            {
                _maxQuantity = value;
                EnsureChildControls();
            }
        }

        private bool _readOnly;
        /// <summary>
        /// Gets or sets a value indicating whether [read only].
        /// </summary>
        /// <value><c>true</c> if [read only]; otherwise, <c>false</c>.</value>
        [Bindable(true)]
        public bool ReadOnly
        {
            get
            {
                return _readOnly;
            }
            set
            {
                _readOnly = value;
                EnsureChildControls();
            }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Determines whether the server control contains child controls. If it does not, it creates child controls.
        /// </summary>
        protected override void EnsureChildControls()
        {
            BindQuantity();
            base.EnsureChildControls();
        }

        /// <summary>
        /// Binds the quantity.
        /// </summary>
        private void BindQuantity()
        {
            QuantityDropDown.Items.Clear();
            if (MaxQuantity <= 50)
            {
                for (var index = MinQuantity; index <= MaxQuantity; index++)
                {
                    QuantityDropDown.Items.Add(new ListItem(index.ToString("#"), index.ToString("#")));
                }
            }

            if (ReadOnly || QuantityDropDown.Items.Count == 1)
            {
                QuantityDropDown.Visible = false;
                QuantityTextBox.Visible = false;
                QuantityLabel.Visible = true;
            }
            else if (QuantityDropDown.Items.Count > 1)
            {
                QuantityDropDown.Visible = true;
                QuantityTextBox.Visible = false;
                QuantityLabel.Visible = false;
            }
            else
            {
                QuantityDropDown.Visible = false;
                QuantityTextBox.Visible = true;
                QuantityLabel.Visible = false;
            }

            if (_quantity != null && QuantityTextBox.Visible)
                QuantityTextBox.Text = ((decimal)_quantity).ToString("#.##");
            if (_quantity != null && QuantityDropDown.Visible)
                CommonHelper.SelectListItem(QuantityDropDown, (Int32.Parse(((decimal)_quantity).ToString("#"))).ToString());
            if (_quantity != null && QuantityLabel.Visible)
                QuantityLabel.Text = ((decimal)_quantity).ToString("#.##");
        }
    }
}