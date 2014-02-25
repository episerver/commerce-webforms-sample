using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EPiServer.Commerce.Sample.BaseControls
{
    /// <summary>
    /// The base catalog list control which provides the category parent node and list of categories in the store
    /// </summary>
    public class BaseCatalogListControl : RendererControlBase<NodeContent>
    {
        /// <summary>
        /// Name of the catalog
        /// </summary>
        private const string CatalogName = "Departmental Catalog";

        /// <summary>
        /// The parent node code
        /// </summary>
        private const string ParentNodeCode = "Departments";

        private NodeContent _parentNode;
        private IEnumerable<NodeContent> _catalogNodeList;

        /// <summary>
        /// Gets the catalog root node.
        /// </summary>
        /// <value>
        /// The catalog root node.
        /// </value>
        public NodeContent CategoryParentNode
        {
            get
            {
                if (_parentNode == null)
                {
                    var rootLink = Locate.ReferenceConverter().GetRootLink();
                    var catalogContent = GetNodeChildren<CatalogContent>(rootLink).FirstOrDefault(catalog => catalog.Name.Equals(CatalogName, StringComparison.OrdinalIgnoreCase));
                    if (catalogContent != null)
                    {
                        _parentNode = GetNodeChildren<NodeContent>(catalogContent.ContentLink).FirstOrDefault(node => node.Name.Equals(ParentNodeCode, StringComparison.OrdinalIgnoreCase));
                    }
                }

                return _parentNode;
            }
        }

        /// <summary>
        /// Gets the catalog node list.
        /// </summary>
        /// <returns>The catalog node list.</returns>
        protected IEnumerable<NodeContent> GetCatalogNodeList()
        {
            return _catalogNodeList ?? (_catalogNodeList = CategoryParentNode != null ? GetNodeChildren<NodeContent>(CategoryParentNode.ContentLink).ToList() : null);
        }
    }
}