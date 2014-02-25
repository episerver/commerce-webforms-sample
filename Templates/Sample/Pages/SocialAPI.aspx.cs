using System;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;
using log4net;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Framework.Cache;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages
{
    public partial class SocialApi : TemplatePage<SocialAPIPage>
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(SocialApi));

        protected void Page_Load(object sender, EventArgs e)
        {
            Twitter();
            Delicious();
            Instagram();
        }

        #region API Methods

        protected void Twitter()
        {
            //Check to see if the Twitter cache item exists
            if (CacheManager.Get("twitter_JsonCache") == null)
            {
                if (CurrentPage["TwitterUsers"] == null && CurrentPage["TwitterHashTags"] == null)
                    return;

                using (var client = new WebClient())
                {
                    var items = new JArray();

                    var tweetCount = "";
                    var url = "";

                    //Check for requested Tweet count
                    if (CurrentPage["TweetCount"] != null)
                    {
                        if (CurrentPage.Property["TweetCount"].Value != null)
                            tweetCount = CurrentPage.Property["TweetCount"].Value.ToString();
                    }

                    //Perform search for Twitter Users
                    if (CurrentPage["TwitterUsers"] != null)
                    {
                        if (CurrentPage.Property["TwitterUsers"].Value != null)
                        {
                            //Split entered users
                            var property = CurrentPage.Property["TwitterUsers"].Value.ToString();
                            var twitterUsers = property.Split(',');

                            //Call API for each Twitter User
                            foreach (var user in twitterUsers)
                            {
                                try
                                {
                                    url = string.Format("https://twitter.com/statuses/user_timeline/{0}.json?count={1}", user.Trim(), tweetCount);
                                    GetJsonResults(client, url, items, false);
                                }

                                catch (Exception ex)
                                {
                                    _log.Error(string.Format("Problem getting user results from Twitter because {0}", ex));
                                    twitterRepeater.Visible = false;
                                }
                            }
                        }
                    }

                    //Perform search for Twitter Hash Tags
                    if (CurrentPage["TwitterHashTags"] != null)
                    {
                        if (CurrentPage.Property["TwitterHashTags"].Value != null)
                        {
                            //Split entered tags
                            var property = CurrentPage.Property["TwitterHashTags"].Value.ToString();
                            var twitterHashTags = property.Split(',');

                            //Call API for each Twitter tag
                            foreach (var twitterHashtag in twitterHashTags)
                            {
                                try
                                {
                                    url = string.Format("http://search.twitter.com/search.json?q={0}&rpp={1}&with_twitter_user_id=true&result_type=mixed", twitterHashtag.Trim(), tweetCount);
                                    GetJsonResults(client, url, items, true);
                                }
                                catch (Exception ex)
                                {
                                    _log.Error(string.Format("Problem getting hash tag results from Twitter because {0}", ex));
                                    twitterRepeater.Visible = false;
                                }
                            }
                        }
                    }

                    //Cache the json array and bind it to the Twitter repeater
                    CacheManager.Insert("twitter_JsonCache", items, new CacheEvictionPolicy(new TimeSpan(0, 3, 0), CacheTimeoutType.Absolute));
                    twitterRepeater.DataSource = items;
                    twitterRepeater.DataBind();

                }
            }
            //Retrieve the cache item and assign it to the repeater
            else
            {
                var cacheItems = (JArray)CacheManager.Get("twitter_JsonCache");
                twitterRepeater.DataSource = cacheItems;
                twitterRepeater.DataBind();
            }
        }

        protected void Delicious()
        {
            //Check to see if the Delicious cache item exists
            if (CacheManager.Get("delicious_JsonCache") == null)
            {
                if (CurrentPage["DeliciousUsers"] == null && CurrentPage["DeliciousHashTags"] == null)
                    return;

                var items = new JArray();

                using (var client = new WebClient())
                {
                    var url = "";
                    var deliciousCount = "";

                    //Check for requested Delicious links count
                    if (CurrentPage["DeliciousCount"] != null)
                    {
                        if (CurrentPage.Property["DeliciousCount"].Value != null)
                            deliciousCount = CurrentPage.Property["DeliciousCount"].Value.ToString();
                    }

                    //Perform search for Delicious users
                    if (CurrentPage["DeliciousUsers"] != null)
                    {
                        if (CurrentPage.Property["DeliciousUsers"].Value != null)
                        {
                            //Split entered users
                            var property = CurrentPage.Property["DeliciousUsers"].Value.ToString();
                            var delicoiousUsers = property.Split(',');

                            //Call API for each Delicious user
                            foreach (var user in delicoiousUsers)
                            {
                                try
                                {
                                    url = string.Format("http://del.icio.us/v2/json/{0}?count={1}", user.Trim(), deliciousCount);
                                    GetJsonResults(client, url, items, false);
                                }
                                catch (Exception ex)
                                {
                                    _log.Error(string.Format("Problem getting user results from Delicious because {0}", ex));
                                    deliciousRepeater.Visible = false;
                                }
                            }
                        }
                    }

                    //Perform search for Delicious hash tags
                    if (CurrentPage["DeliciousHashTags"] != null)
                    {
                        if (CurrentPage.Property["DeliciousHashTags"].Value != null)
                        {
                            //Split entered tags
                            var property = CurrentPage.Property["DeliciousHashTags"].Value.ToString();
                            var deliciousHashTags = property.Split(',');

                            //Call API for each Delicious tag
                            foreach (var deliciousHashTag in deliciousHashTags)
                            {
                                try
                                {
                                    url = string.Format("http://feeds.delicious.com/v2/json/tag/{0}?{1}", deliciousHashTag, deliciousCount);
                                    GetJsonResults(client, url, items, false);
                                }
                                catch (Exception ex)
                                {
                                    _log.Error(string.Format("Problem getting hash tag results from Delicious because {0}", ex));
                                    deliciousRepeater.Visible = false;
                                }
                            }
                        }
                    }

                    //Cache the json array and bind it to the Delicious repeater
                    CacheManager.Insert("delicious_JsonCache", items, new CacheEvictionPolicy(new TimeSpan(0, 3, 0), CacheTimeoutType.Absolute));
                    deliciousRepeater.DataSource = items;
                    deliciousRepeater.DataBind();
                }
            }
            //Retrieve the cache item and assign it to the repeater
            else
            {
                var cacheItems = (JArray)CacheManager.Get("delicious_JsonCache");
                deliciousRepeater.DataSource = cacheItems;
                deliciousRepeater.DataBind();
            }
        }

        /* Instagram Access Token is retreived via registering your application with Instagram Dev.
        * Steps to retreieve can be found at the following link:  http://instagr.am/developer/authentication/
        * Please use Client-Side (Implicit) Authentication steps
        * */
        protected void Instagram()
        {
            //Check to see if the Instagram cache item exists
            if (CacheManager.Get("instagram_JsonCache") == null)
            {
                if (CurrentPage["InstagramAccessToken"] == null && CurrentPage.Property["InstagramAccessToken"].Value == null)
                    return;

                var instagramAccessToken = CurrentPage.Property["InstagramAccessToken"].Value.ToString();
                var items = new JArray();

                using (var client = new WebClient())
                {
                    var url = "";
                    var instagramCount = "";

                    //Check for requested Instagram images count
                    if (CurrentPage["InstagramCount"] != null)
                    {
                        if (CurrentPage.Property["InstagramCount"].Value != null)
                            instagramCount = CurrentPage.Property["InstagramCount"].Value.ToString();
                    }

                    //Perform search for requested Instagram users
                    //NOTE:  Requested Instagram users are retreived by pulling the usernames from the "following" section of the master Instagram account

                    try
                    {
                        url = string.Format("https://api.instagram.com/v1/users/self/feed?access_token={0}&count={1}", instagramAccessToken, instagramCount);
                        GetInstagramJsonResults(client, url, items);
                    }
                    catch (Exception ex)
                    {
                        _log.Error(string.Format("Problem getting user results from Instagram because {0}", ex));
                        instagramRepeater.Visible = false;
                    }

                    //Perform search for requested Instagram hash tags
                    if (CurrentPage["InstagramHashTags"] != null)
                    {
                        if (CurrentPage.Property["InstagramHashTags"].Value != null)
                        {
                            var property = CurrentPage.Property["InstagramHashTags"].Value.ToString();
                            var instagramHashTags = property.Split(',');

                            foreach (var instagramHashTag in instagramHashTags)
                            {
                                try
                                {
                                    url = string.Format("https://api.instagram.com/v1/tags/{0}/media/recent?access_token={1}&count={2}", instagramHashTag, instagramAccessToken, instagramCount);
                                    GetInstagramJsonResults(client, url, items);
                                }
                                catch (Exception ex)
                                {
                                    _log.Error(string.Format("Problem getting hash tag results from Instagram because {0}", ex));
                                    instagramRepeater.Visible = false;
                                }
                            }
                        }
                    }

                    //Cache the json array and bind it to the Instagram repeater
                    CacheManager.Insert("instagram_JsonCache", items, new CacheEvictionPolicy(new TimeSpan(0, 3, 0), CacheTimeoutType.Absolute));
                    instagramRepeater.DataSource = items;
                    instagramRepeater.DataBind();
                }

            }
            //Retrieve the cache item and assign it to the repeater
            else
            {
                var cacheItems = (JArray)CacheManager.Get("instagram_JsonCache");
                instagramRepeater.DataSource = cacheItems;
                instagramRepeater.DataBind();
            }
        }

        protected JArray GetJsonResults(WebClient client, string url, JArray items, bool twitterHash)
        {
            using (var stream = client.OpenRead(url))
            {
                using (var reader = new StreamReader(stream))
                {
                    JArray jItems;

                    if (twitterHash)
                    {
                        var tagSearch = JObject.Parse(reader.ReadLine());
                        jItems = (JArray)tagSearch["results"];
                    }
                    else
                        jItems = JArray.Parse(reader.ReadLine());

                    foreach (JObject item in jItems)
                    {
                        items.Add(item);
                    }
                }
            }

            return items;
        }

        protected JArray GetInstagramJsonResults(WebClient client, string url, JArray items)
        {
            using (var stream = client.OpenRead(url))
            {
                using (var reader = new StreamReader(stream))
                {
                    var userSearch = JObject.Parse(reader.ReadLine());
                    var userItems = (JArray)userSearch["data"];

                    foreach (JObject item in userItems)
                    {
                        items.Add(item);
                    }
                }
            }

            return items;
        }

        #endregion

        #region DataBind

        protected void twitterRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType != ListItemType.Item) || ((e.Item.ItemType != ListItemType.AlternatingItem)))
                return;

            var twitterLink = ((HyperLink)e.Item.FindControl("TwitterLink"));
            var twitterDate = ((Label)e.Item.FindControl("TwitterDate"));

            //build the tweet link
            var tweetUserToReplace = "";

            //check to see if we are dealing with a user search or a hashtag search
            if (((JObject)e.Item.DataItem)["user"] != null)
                tweetUserToReplace = ((JObject)e.Item.DataItem)["user"]["screen_name"].ToString();
            else if (((JObject)e.Item.DataItem)["from_user"] != null)
                tweetUserToReplace = ((JObject)e.Item.DataItem)["from_user"].ToString();

            //remove excess double quotes from JSON values
            var tweetUser = tweetUserToReplace.Replace("\"", string.Empty);

            var tweetIdToReplace = ((JObject)e.Item.DataItem)["id_str"].ToString();
            var tweetId = tweetIdToReplace.Replace("\"", string.Empty);

            var tweetDateToReplace = ((JObject)e.Item.DataItem)["created_at"].ToString();
            var tweetDate = tweetDateToReplace.Replace("\"", string.Empty);

            //assgign the values to the repeater
            twitterLink.NavigateUrl = string.Format(@"https://twitter.com/{0}/status/{1}", tweetUser, tweetId);

            var twitterLinkText = string.Format(tweetUser, ":", " ", ((JObject)e.Item.DataItem)["text"]);
            twitterLink.Text = twitterLinkText;

            twitterDate.Text = tweetDate;

        }

        protected void deliciousRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType != ListItemType.Item) || ((e.Item.ItemType != ListItemType.AlternatingItem)))
                return;

            var DeliciousLink = ((HyperLink)e.Item.FindControl("DeliciousLink"));
            var DeliciousDate = ((Label)e.Item.FindControl("DeliciousDate"));

            //remove excess double quotes from JSON values
            var deliciousUrlToReplace = ((JObject)e.Item.DataItem)["u"].ToString();
            var deliciousUrl = deliciousUrlToReplace.Replace("\"", string.Empty);

            var deliciousTitleToReplace = ((JObject)e.Item.DataItem)["d"].ToString();
            var deliciousTitle = deliciousTitleToReplace.Replace("\"", string.Empty);

            var deliciousDateToReplace = ((JObject)e.Item.DataItem)["dt"].ToString();
            var date = deliciousDateToReplace.Replace("\"", string.Empty);

            var deliciousUserNameToReplace = ((JObject)e.Item.DataItem)["a"].ToString();
            var deliciousUserName = deliciousUserNameToReplace.Replace("\"", string.Empty);

            //assign values to the repeater
            DeliciousLink.NavigateUrl = deliciousUrl;
            DeliciousLink.Text = deliciousUserName + ":" + "  " + deliciousTitle;

            DeliciousDate.Text = date;
        }

        protected void instagramRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType != ListItemType.Item) || ((e.Item.ItemType != ListItemType.AlternatingItem)))
                return;

            var instagramLink = ((HyperLink)e.Item.FindControl("InstagramLink"));
            var instagramImage = ((Image)e.Item.FindControl("InstagramImage"));

            //remove excess double quotes from JSON values
            var navigateUrlReplace = ((JObject)e.Item.DataItem)["link"].ToString();
            var navigateUrl = navigateUrlReplace.Replace("\"", string.Empty);
            var imageUrlReplace = ((JObject)e.Item.DataItem)["images"]["thumbnail"]["url"].ToString();
            var imageUrl = imageUrlReplace.Replace("\"", string.Empty);

            instagramLink.NavigateUrl = navigateUrl;

            instagramImage.ImageUrl = imageUrl;
            instagramImage.AlternateText = "";
        }

        #endregion
    }

}