declare @ApplicationId uniqueidentifier
select @ApplicationId = ApplicationId from [Application] where [Name] = N'$(EcfApplicationName)'

--|--------------------------------------------------------------------------------
--| [Country] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Aruba', 0, 1, 'ABW', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Afghanistan', 0, 1, 'AFG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Angola', 0, 1, 'AGO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Anguilla', 0, 1, 'AIA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Albania', 0, 1, 'ALB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Andorra', 0, 1, 'AND', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Netherlands Antilles', 0, 1, 'ANT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('United Arab Emirates', 0, 1, 'ARE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Argentina', 0, 1, 'ARG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Armenia', 0, 1, 'ARM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('American Samoa', 0, 1, 'ASM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Antarctica', 0, 1, 'ATA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('French Southern Territories', 0, 1, 'ATF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Antigua and Barbuda', 0, 1, 'ATG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Australia', 0, 1, 'AUS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Austria', 0, 1, 'AUT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Azerbaijan', 0, 1, 'AZE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Burundi', 0, 1, 'BDI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Belgium', 0, 1, 'BEL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Benin', 0, 1, 'BEN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Burkina Faso', 0, 1, 'BFA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bangladesh', 0, 1, 'BGD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bulgaria', 0, 1, 'BGR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bahrain', 0, 1, 'BHR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bahamas', 0, 1, 'BHS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bosnia and Herzegovina', 0, 1, 'BIH', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Belarus', 0, 1, 'BLR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Belize', 0, 1, 'BLZ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bermuda', 0, 1, 'BMU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bolivia', 0, 1, 'BOL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Brazil', 0, 1, 'BRA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Barbados', 0, 1, 'BRB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Brunei Darussalam', 0, 1, 'BRN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bhutan', 0, 1, 'BTN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Bouvet Island', 0, 1, 'BVT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Botswana', 0, 1, 'BWA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Central African Republic', 0, 1, 'CAF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Canada', 0, 1, 'CAN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cocos (Keeling) Islands', 0, 1, 'CCK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Switzerland', 0, 1, 'CHE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Chile', 0, 1, 'CHL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('China', 0, 1, 'CHN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cote D\Ivoire', 0, 1, 'CIV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cameroon', 0, 1, 'CMR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Congo, the Democratic Republic of the', 0, 1, 'COD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Congo', 0, 1, 'COG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cook Islands', 0, 1, 'COK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Colombia', 0, 1, 'COL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Comoros', 0, 1, 'COM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cape Verde', 0, 1, 'CPV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Costa Rica', 0, 1, 'CRI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cuba', 0, 1, 'CUB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Christmas Island', 0, 1, 'CXR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cayman Islands', 0, 1, 'CYM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cyprus', 0, 1, 'CYP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Czech Republic', 0, 1, 'CZE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Germany', 0, 1, 'DEU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Djibouti', 0, 1, 'DJI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Dominica', 0, 1, 'DMA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Denmark', 0, 1, 'DNK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Dominican Republic', 0, 1, 'DOM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Algeria', 0, 1, 'DZA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Ecuador', 0, 1, 'ECU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Egypt', 0, 1, 'EGY', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Eritrea', 0, 1, 'ERI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Western Sahara', 0, 1, 'ESH', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Spain', 0, 1, 'ESP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Estonia', 0, 1, 'EST', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Ethiopia', 0, 1, 'ETH', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Finland', 0, 1, 'FIN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Fiji', 0, 1, 'FJI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Falkland Islands (Malvinas)', 0, 1, 'FLK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('France', 0, 1, 'FRA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Faroe Islands', 0, 1, 'FRO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Micronesia, Federated States of', 0, 1, 'FSM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Gabon', 0, 1, 'GAB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('United Kingdom', 0, 1, 'GBR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Georgia', 0, 1, 'GEO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Ghana', 0, 1, 'GHA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Gibraltar', 0, 1, 'GIB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guinea', 0, 1, 'GIN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guadeloupe', 0, 1, 'GLP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Gambia', 0, 1, 'GMB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guinea-Bissau', 0, 1, 'GNB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Equatorial Guinea', 0, 1, 'GNQ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Greece', 0, 1, 'GRC', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Grenada', 0, 1, 'GRD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Greenland', 0, 1, 'GRL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guatemala', 0, 1, 'GTM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('French Guiana', 0, 1, 'GUF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guam', 0, 1, 'GUM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Guyana', 0, 1, 'GUY', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Hong Kong', 0, 1, 'HKG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Heard Island and Mcdonald Islands', 0, 1, 'HMD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Honduras', 0, 1, 'HND', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Croatia', 0, 1, 'HRV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Haiti', 0, 1, 'HTI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Hungary', 0, 1, 'HUN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Indonesia', 0, 1, 'IDN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('India', 0, 1, 'IND', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('British Indian Ocean Territory', 0, 1, 'IOT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Ireland', 0, 1, 'IRL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Iran, Islamic Republic of', 0, 1, 'IRN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Iraq', 0, 1, 'IRQ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Iceland', 0, 1, 'ISL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Israel', 0, 1, 'ISR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Italy', 0, 1, 'ITA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Jamaica', 0, 1, 'JAM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Jordan', 0, 1, 'JOR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Japan', 0, 1, 'JPN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Kazakhstan', 0, 1, 'KAZ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Kenya', 0, 1, 'KEN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Kyrgyzstan', 0, 1, 'KGZ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Cambodia', 0, 1, 'KHM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Kiribati', 0, 1, 'KIR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saint Kitts and Nevis', 0, 1, 'KNA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Korea, Republic of', 0, 1, 'KOR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Kuwait', 0, 1, 'KWT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Lao People\s Democratic Republic', 0, 1, 'LAO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Lebanon', 0, 1, 'LBN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Liberia', 0, 1, 'LBR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Libyan Arab Jamahiriya', 0, 1, 'LBY', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saint Lucia', 0, 1, 'LCA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Liechtenstein', 0, 1, 'LIE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Sri Lanka', 0, 1, 'LKA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Lesotho', 0, 1, 'LSO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Lithuania', 0, 1, 'LTU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Luxembourg', 0, 1, 'LUX', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Latvia', 0, 1, 'LVA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Macao', 0, 1, 'MAC', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Morocco', 0, 1, 'MAR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Monaco', 0, 1, 'MCO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Moldova, Republic of', 0, 1, 'MDA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Madagascar', 0, 1, 'MDG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Maldives', 0, 1, 'MDV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mexico', 0, 1, 'MEX', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Marshall Islands', 0, 1, 'MHL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Macedonia, the Former Yugoslav Republic of', 0, 1, 'MKD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mali', 0, 1, 'MLI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Malta', 0, 1, 'MLT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Myanmar', 0, 1, 'MMR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mongolia', 0, 1, 'MNG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Northern Mariana Islands', 0, 1, 'MNP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mozambique', 0, 1, 'MOZ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mauritania', 0, 1, 'MRT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Montserrat', 0, 1, 'MSR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Martinique', 0, 1, 'MTQ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mauritius', 0, 1, 'MUS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Malawi', 0, 1, 'MWI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Malaysia', 0, 1, 'MYS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Mayotte', 0, 1, 'MYT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Namibia', 0, 1, 'NAM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('New Caledonia', 0, 1, 'NCL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Niger', 0, 1, 'NER', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Norfolk Island', 0, 1, 'NFK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Nigeria', 0, 1, 'NGA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Nicaragua', 0, 1, 'NIC', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Niue', 0, 1, 'NIU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Netherlands', 0, 1, 'NLD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Norway', 0, 1, 'NOR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Nepal', 0, 1, 'NPL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Nauru', 0, 1, 'NRU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('New Zealand', 0, 1, 'NZL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Oman', 0, 1, 'OMN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Pakistan', 0, 1, 'PAK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Panama', 0, 1, 'PAN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Pitcairn', 0, 1, 'PCN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Peru', 0, 1, 'PER', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Philippines', 0, 1, 'PHL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Palau', 0, 1, 'PLW', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Papua New Guinea', 0, 1, 'PNG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Poland', 0, 1, 'POL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Puerto Rico', 0, 1, 'PRI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Korea, Democratic People\s Republic of', 0, 1, 'PRK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Portugal', 0, 1, 'PRT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Paraguay', 0, 1, 'PRY', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Palestinian Territory, Occupied', 0, 1, 'PSE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('French Polynesia', 0, 1, 'PYF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Qatar', 0, 1, 'QAT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Reunion', 0, 1, 'REU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Romania', 0, 1, 'ROM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Russian Federation', 0, 1, 'RUS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Rwanda', 0, 1, 'RWA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saudi Arabia', 0, 1, 'SAU', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Serbia and Montenegro', 0, 1, 'SCG', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Sudan', 0, 1, 'SDN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Senegal', 0, 1, 'SEN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Singapore', 0, 1, 'SGP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('South Georgia and the South Sandwich Islands', 0, 1, 'SGS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saint Helena', 0, 1, 'SHN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Svalbard and Jan Mayen', 0, 1, 'SJM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Solomon Islands', 0, 1, 'SLB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Sierra Leone', 0, 1, 'SLE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('El Salvador', 0, 1, 'SLV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('San Marino', 0, 1, 'SMR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Somalia', 0, 1, 'SOM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saint Pierre and Miquelon', 0, 1, 'SPM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Sao Tome and Principe', 0, 1, 'STP', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Suriname', 0, 1, 'SUR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Slovakia', 0, 1, 'SVK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Slovenia', 0, 1, 'SVN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Sweden', 0, 1, 'SWE', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Swaziland', 0, 1, 'SWZ', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Seychelles', 0, 1, 'SYC', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Syrian Arab Republic', 0, 1, 'SYR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Turks and Caicos Islands', 0, 1, 'TCA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Chad', 0, 1, 'TCD', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Togo', 0, 1, 'TGO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Thailand', 0, 1, 'THA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tajikistan', 0, 1, 'TJK', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tokelau', 0, 1, 'TKL', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Turkmenistan', 0, 1, 'TKM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Timor-Leste', 0, 1, 'TLS', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tonga', 0, 1, 'TON', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Trinidad and Tobago', 0, 1, 'TTO', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tunisia', 0, 1, 'TUN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Turkey', 0, 1, 'TUR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tuvalu', 0, 1, 'TUV', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Taiwan, Province of China', 0, 1, 'TWN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Tanzania, United Republic of', 0, 1, 'TZA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Uganda', 0, 1, 'UGA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Ukraine', 0, 1, 'UKR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('United States Minor Outlying Islands', 0, 1, 'UMI', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Uruguay', 0, 1, 'URY', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('United States', -1, 1, 'USA', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Uzbekistan', 0, 1, 'UZB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Holy See (Vatican City State)', 0, 1, 'VAT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Saint Vincent and the Grenadines', 0, 1, 'VCT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Venezuela', 0, 1, 'VEN', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Virgin Islands, British', 0, 1, 'VGB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Virgin Islands, U.s.', 0, 1, 'VIR', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Viet Nam', 0, 1, 'VNM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Vanuatu', 0, 1, 'VUT', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Wallis and Futuna', 0, 1, 'WLF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Samoa', 0, 1, 'WSM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Yemen', 0, 1, 'YEM', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('South Africa', 0, 1, 'ZAF', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Zambia', 0, 1, 'ZMB', @ApplicationId);
INSERT INTO [Country] ([Name], [Ordering], [Visible], [Code], [ApplicationId]) VALUES ('Zimbabwe', 0, 1, 'ZWE', @ApplicationId);

--|--------------------------------------------------------------------------------
--| [StateProvince] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @USACountryId int
select @USACountryId = [CountryId] from [Country] where [Name] = N'United States'

INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Alaska', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Alabama', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('American Samoa', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Arizona', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Arkansas', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('California', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Colorado', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Connecticut', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Delaware', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('District of Columbia', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Federated States of Micronesia', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Florida', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Georgia', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Guam', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Hawaii', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Idaho', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Illinois', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Indiana', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Iowa', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Kansas', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Kentucky', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Louisiana', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Maine', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Marshall Islands', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Maryland', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Massachusetts', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Michigan', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Minnesota', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Mississippi', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Missouri', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Montana', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Nebraska', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Nevada', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('New Hampshire', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('New Jersey', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('New Mexico', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('New York', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('North Carolina', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('North Dakota', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Northern Mariana Islands', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Ohio', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Oklahoma', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Oregon', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Palau', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Pennsylvania', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Puerto Rico', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Rhode Island', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('South Carolina', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('South Dakota', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Tennessee', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Texas', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Utah', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Vermont', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Virgin Islands', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Virginia', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Washington', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('West Virginia', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Wisconsin', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Wyoming', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Africa', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Americas (except Canada)', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Canada', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Europe', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Middle East', 0, 1, @USACountryId);
INSERT INTO [StateProvince] ([Name], [Ordering], [Visible], [CountryId]) VALUES ('Armed Forces Pacific', 0, 1, @USACountryId);

--|--------------------------------------------------------------------------------
--| [Jurisdiction] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @JurisdictionId int
INSERT INTO [Jurisdiction] ([DisplayName], [StateProvinceCode], [CountryCode], [JurisdictionType], [ZipPostalCodeStart], [ZipPostalCodeEnd], [City], [District], [County], [GeoCode], [ApplicationId], [Code]) 
VALUES ('United States', '', 'USA', 2, '', '', '', '', '', '', @ApplicationId, 'USA');
set @JurisdictionId = SCOPE_IDENTITY()
	
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('AB','UK postcode - Aberdeen(AB)', 'GBR-AB','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('AL','UK postcode - St Albans(AL)', 'GBR-AL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('B','UK postcode - Birmingham(B)', 'GBR-B','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BA','UK postcode - Bath(BA)', 'GBR-BA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BB','UK postcode - Blackburn(BB)', 'GBR-BB','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BD','UK postcode - Bradford(BD)', 'GBR-BD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BH','UK postcode - Bournemouth(BH)', 'GBR-BH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BL','UK postcode - Bolton(BL)', 'GBR-BL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BN','UK postcode - Brighton(BN)', 'GBR-BN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BR','UK postcode - Bromley(BR)', 'GBR-BR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BS','UK postcode - Bristol(BS)', 'GBR-BS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('BT','UK postcode - Belfast(BT)', 'GBR-BT','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CA','UK postcode - Carlisle(CA)', 'GBR-CA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CB','UK postcode - Cambridge(CB)', 'GBR-CB','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CF','UK postcode - Cardiff(CF)', 'GBR-CF','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CH','UK postcode - Chester(CH)', 'GBR-CH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CM','UK postcode - Chelmsford(CM)', 'GBR-CM','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CO','UK postcode - Colchester(CO)', 'GBR-CO','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CR','UK postcode - Croydon(CR)', 'GBR-CR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CT','UK postcode - Canterbury(CT)', 'GBR-CT','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CV','UK postcode - Coventry(CV)', 'GBR-CV','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('CW','UK postcode - Crewe(CW)', 'GBR-CW','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DA','UK postcode - Dartford(DA)', 'GBR-DA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DD','UK postcode - Dundee(DD)', 'GBR-DD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DE','UK postcode - Derby(DE)', 'GBR-DE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DG','UK postcode - Dumfries(DG)', 'GBR-DG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DH','UK postcode - Durham(DH)', 'GBR-DH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DL','UK postcode - Darlington(DL)', 'GBR-DL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DN','UK postcode - Doncaster(DN)', 'GBR-DN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DT','UK postcode - Dorchester(DT)', 'GBR-DT','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('DY','UK postcode - Dudley(DY)', 'GBR-DY','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('E','UK postcode - London E(E)', 'GBR-E','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('EC','UK postcode - London EC(EC)', 'GBR-EC','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('EH','UK postcode - Edinburgh(EH)', 'GBR-EH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('EN','UK postcode - Enfield(EN)', 'GBR-EN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('EX','UK postcode - Exeter(EX)', 'GBR-EX','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('FK','UK postcode - Falkirk(FK)', 'GBR-FK','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('FY','UK postcode - Blackpool(FY)', 'GBR-FY','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('G','UK postcode - Glasgow(G)', 'GBR-G','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('GL','UK postcode - Gloucester(GL)', 'GBR-GL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('GU','UK postcode - Guildford(GU)', 'GBR-GU','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('GY','UK postcode - Guernsey(GY)', 'GBR-GY','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HA','UK postcode - Harrow(HA)', 'GBR-HA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HD','UK postcode - Huddersfield(HD)', 'GBR-HD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HG','UK postcode - Harrogate(HG)', 'GBR-HG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HP','UK postcode - Hemel Hempstead(HP)', 'GBR-HP','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HR','UK postcode - Hereford(HR)', 'GBR-HR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HS','UK postcode - Outer Hebride(HS)', 'GBR-HS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HU','UK postcode - Hull(HU)', 'GBR-HU','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('HX','UK postcode - Halifax(HX)', 'GBR-HX','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IG','UK postcode - Ilfor(IG)', 'GBR-IG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IM','UK postcode - Isle of Man(IM)', 'GBR-IM','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IP','UK postcode - Ipswich(IP)', 'GBR-IP','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IV','UK postcode - Inverness(IV)', 'GBR-IV','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IV3', 'IV24','UK postcode - Morayshire(IV3-IV24)', 'GBR-IV3','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('IV26', 'IV99','UK postcode - Morayshire(IV26-IV99)', 'GBR-IV26','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('JE','UK postcode - Jersey(JE)', 'GBR-JE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KA','UK postcode - Kilmarnock(KA)', 'GBR-KA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd,  DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KA27', 'KA28', 'UK postcode - Brodwick & Millport(KA27-KA28)', 'GBR-KA27','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KT','UK postcode - Kingston upon Thames(KT)', 'GBR-KT','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KW','UK postcode - Kirkwall(KW)', 'GBR-KW','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd ,DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KW1', 'KW17','UK postcode - Orkney(KW1-KW17)', 'GBR-KW1','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('KY','UK postcode - Kirkcaldy(KY)', 'GBR-KY','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('L','UK postcode - Liverpool(L)', 'GBR-L','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LA','UK postcode - Lancaster(LA)', 'GBR-LA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LD','UK postcode - Llandrindod Well(LD)', 'GBR-LD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LE','UK postcode - Leicester(LE)', 'GBR-LE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LL','UK postcode - Llandudno(LL)', 'GBR-LL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LN','UK postcode - Lincoln(LN)', 'GBR-LN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LS','UK postcode - Leeds(LS)', 'GBR-LS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('LU','UK postcode - Luton(LU)', 'GBR-LU','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('M','UK postcode - Manchester(M)', 'GBR-M','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('ME','UK postcode - Rochester(ME)', 'GBR-ME','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('MK','UK postcode - Milton Keynes(MK)', 'GBR-MK','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('ML','UK postcode - Motherwell(ML)', 'GBR-ML','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('N','UK postcode - London N(N)', 'GBR-N','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NE','UK postcode - Newcastle upon Tyne(NE)', 'GBR-NE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NG','UK postcode - Nottingham(NG)', 'GBR-NG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NN','UK postcode - Northampton(NN)', 'GBR-NN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NP','UK postcode - Newport(NP)', 'GBR-NP','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NR','UK postcode - Norwich(NR)', 'GBR-NR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('NW','UK postcode - London NW(NW)', 'GBR-NW','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('OL','UK postcode - Oldham(OL)', 'GBR-OL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('OX','UK postcode - Oxford(OX)', 'GBR-OX','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PA','UK postcode - Paisley(PA)', 'GBR-PA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PA20', 'PA99','UK postcode - Argyll(PA20-PA99)', 'GBR-PA20','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PE','UK postcode - Peterborough(PE)', 'GBR-PE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PH','UK postcode - Perth(PH)', 'GBR-PH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PH19', 'PH44','UK postcode - Inverness-Shire(PH19-PH44)', 'GBR-PH19','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PL','UK postcode - Plymouth(PL)', 'GBR-PL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PO','UK postcode - Portsmouth(PO)', 'GBR-PO','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('PR','UK postcode - Preston(PR)', 'GBR-PR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('RG','UK postcode - Reading(RG)', 'GBR-RG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('RH','UK postcode - Redhill(RH)', 'GBR-RH','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('RM','UK postcode - Romford(RM)', 'GBR-RM','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('S','UK postcode - Sheffield(S)', 'GBR-S','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SA','UK postcode - Swansea(SA)', 'GBR-SA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SE','UK postcode - London SE(SE)', 'GBR-SE','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SG','UK postcode - Stevenage(SG)', 'GBR-SG','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SK','UK postcode - Stockport(SK)', 'GBR-SK','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SL','UK postcode - Slough(SL)', 'GBR-SL','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SM','UK postcode - Sutto(SM)', 'GBR-SM','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SN','UK postcode - Swindon(SN)', 'GBR-SN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SO','UK postcode - Southampton(SO)', 'GBR-SO','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SP','UK postcode - Salisbury(SP)', 'GBR-SP','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SR','UK postcode - Sunderland(SR)', 'GBR-SR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SS','UK postcode - Southend on Sea(SS)', 'GBR-SS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('ST','UK postcode - Stoke-on-Trent(ST)', 'GBR-ST','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SW','UK postcode - London SW(SW)', 'GBR-SW','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('SY','UK postcode - Shrewsbury(SY)', 'GBR-SY','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TA','UK postcode - Taunton(TA)', 'GBR-TA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TD','UK postcode - Galashiels(TD)', 'GBR-TD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TF','UK postcode - Telford(TF)', 'GBR-TF','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TN','UK postcode - Tonbridge(TN)', 'GBR-TN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TQ','UK postcode - Torquay(TQ)', 'GBR-TQ','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TR','UK postcode - Truro(TR)', 'GBR-TR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, ZipPostalCodeEnd, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TR2', 'TR25','UK postcode - Truro(TR2-TR25)', 'GBR-TR2','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TS','UK postcode - Cleveland(TS)', 'GBR-TS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('TW','UK postcode - Twickenham(TW)', 'GBR-TW','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('UB','UK postcode - Southall(UB)', 'GBR-UB','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('W','UK postcode - London W(W)', 'GBR-W','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WA','UK postcode - Warrington(WA)', 'GBR-WA','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WC','UK postcode - London WC(WC)', 'GBR-WC','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WD','UK postcode - Watford(WD)', 'GBR-WD','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WF','UK postcode - Wakefield(WF)', 'GBR-WF','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WN','UK postcode - Wigan(WN)', 'GBR-WN','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WR','UK postcode - Worcester(WR)', 'GBR-WR','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WS','UK postcode - Walsall(WS)', 'GBR-WS','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('WV','UK postcode - Wolverhampton(WV)', 'GBR-WV','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('YO','UK postcode - York(YO)', 'GBR-YO','GBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (ZipPostalCodeStart, DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('ZE','UK postcode - Lerwick(ZE)', 'GBR-ZE','GBR', 2,  @ApplicationId)

INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Afghanistan(AFG)', 'AFG', 'AFG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Aland Islands(ALA)', 'ALA', 'ALA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Albania(ALB)', 'ALB', 'ALB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Algeria(DZA)', 'DZA', 'DZA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - American Samoa(ASM)', 'ASM', 'ASM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Andorra(AND)', 'AND', 'AND', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Angola(AGO)', 'AGO', 'AGO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Anguilla(AIA)', 'AIA', 'AIA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Antarctica(ATA)', 'ATA', 'ATA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Antigua and Barbuda(ATG)', 'ATG', 'ATG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Argentina(ARG)', 'ARG', 'ARG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Armenia(ARM)', 'ARM', 'ARM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Aruba(ABW)', 'ABW', 'ABW', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Australia(AUS)', 'AUS', 'AUS', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Austria(AUT)', 'AUT', 'AUT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Azerbaijan(AZE)', 'AZE', 'AZE', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bahamas(BHS)', 'BHS', 'BHS', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bahrain(BHR)', 'BHR', 'BHR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bangladesh(BGD)', 'BGD', 'BGD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Barbados(BRB)', 'BRB', 'BRB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Belarus(BLR)', 'BLR', 'BLR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Belgium(BEL)', 'BEL', 'BEL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Belize(BLZ)', 'BLZ', 'BLZ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Benin(BEN)', 'BEN', 'BEN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bermuda(BMU)', 'BMU', 'BMU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bhutan(BTN)', 'BTN', 'BTN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bolivia(BOL)', 'BOL', 'BOL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bosnia and Herzegovina(BIH)', 'BIH', 'BIH', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Botswana(BWA)', 'BWA', 'BWA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bouvet Island(BVT)', 'BVT', 'BVT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Brazil(BRA)', 'BRA', 'BRA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - British Virgin Islands(VGB)', 'VGB', 'VGB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - British Indian Ocean Territory(IOT)', 'IOT', 'IOT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Brunei Darussalam(BRN)', 'BRN', 'BRN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Bulgaria(BGR)', 'BGR', 'BGR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Burkina Faso(BFA)', 'BFA', 'BFA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Burundi(BDI)', 'BDI', 'BDI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cambodia(KHM)', 'KHM', 'KHM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cameroon(CMR)', 'CMR', 'CMR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Canada(CAN)', 'CAN', 'CAN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cape Verde(CPV)', 'CPV', 'CPV', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cayman Islands(CYM)', 'CYM', 'CYM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Central African Republic(CAF)', 'CAF', 'CAF', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Chad(TCD)', 'TCD', 'TCD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Chile(CHL)', 'CHL', 'CHL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - China(CHN)', 'CHN', 'CHN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Hong Kong Special Administrative Region of China(HKG)', 'HKG', 'HKG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Macao Special Administrative Region of China(MAC)', 'MAC', 'MAC', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Christmas Island(CXR)', 'CXR', 'CXR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cocos (Keeling) Islands(CCK)', 'CCK', 'CCK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Colombia(COL)', 'COL', 'COL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Comoros(COM)', 'COM', 'COM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Congo (Brazzaville)(COG)', 'COG', 'COG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Congo, Democratic Republic of the(COD)', 'COD', 'COD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cook Islands(COK)', 'COK', 'COK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Costa Rica(CRI)', 'CRI', 'CRI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cte d''Ivoire(CIV)', 'CIV', 'CIV', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Croatia(HRV)', 'HRV', 'HRV', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cuba(CUB)', 'CUB', 'CUB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Cyprus(CYP)', 'CYP', 'CYP', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Czech Republic(CZE)', 'CZE', 'CZE', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Denmark(DNK)', 'DNK', 'DNK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Djibouti(DJI)', 'DJI', 'DJI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Dominica(DMA)', 'DMA', 'DMA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Dominican Republic(DOM)', 'DOM', 'DOM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Ecuador(ECU)', 'ECU', 'ECU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Egypt(EGY)', 'EGY', 'EGY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - El Salvador(SLV)', 'SLV', 'SLV', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Equatorial Guinea(GNQ)', 'GNQ', 'GNQ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Eritrea(ERI)', 'ERI', 'ERI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Estonia(EST)', 'EST', 'EST', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Ethiopia(ETH)', 'ETH', 'ETH', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Falkland Islands (Malvinas)(FLK)', 'FLK', 'FLK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Faroe Islands(FRO)', 'FRO', 'FRO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Fiji(FJI)', 'FJI', 'FJI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Finland(FIN)', 'FIN', 'FIN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - France(FRA)', 'FRA', 'FRA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - French Guiana(GUF)', 'GUF', 'GUF', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - French Polynesia(PYF)', 'PYF', 'PYF', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - French Southern Territories(ATF)', 'ATF', 'ATF', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Gabon(GAB)', 'GAB', 'GAB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Gambia(GMB)', 'GMB', 'GMB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Georgia(GEO)', 'GEO', 'GEO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Germany(DEU)', 'DEU', 'DEU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Ghana(GHA)', 'GHA', 'GHA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Gibraltar(GIB)', 'GIB', 'GIB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Greece(GRC)', 'GRC', 'GRC', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Greenland(GRL)', 'GRL', 'GRL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Grenada(GRD)', 'GRD', 'GRD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guadeloupe(GLP)', 'GLP', 'GLP', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guam(GUM)', 'GUM', 'GUM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guatemala(GTM)', 'GTM', 'GTM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guernsey(GGY)', 'GGY', 'GGY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guinea(GIN)', 'GIN', 'GIN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guinea-Bissau(GNB)', 'GNB', 'GNB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Guyana(GUY)', 'GUY', 'GUY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Haiti(HTI)', 'HTI', 'HTI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Heard Island and Mcdonald Islands(HMD)', 'HMD', 'HMD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Holy See (Vatican City State)(VAT)', 'VAT', 'VAT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Honduras(HND)', 'HND', 'HND', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Hungary(HUN)', 'HUN', 'HUN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Iceland(ISL)', 'ISL', 'ISL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - India(IND)', 'IND', 'IND', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Indonesia(IDN)', 'IDN', 'IDN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Iran, Islamic Republic of(IRN)', 'IRN', 'IRN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Iraq(IRQ)', 'IRQ', 'IRQ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Ireland(IRL)', 'IRL', 'IRL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Isle of Man(IMN)', 'IMN', 'IMN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Israel(ISR)', 'ISR', 'ISR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Italy(ITA)', 'ITA', 'ITA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Jamaica(JAM)', 'JAM', 'JAM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Japan(JPN)', 'JPN', 'JPN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Jersey(JEY)', 'JEY', 'JEY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Jordan(JOR)', 'JOR', 'JOR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Kazakhstan(KAZ)', 'KAZ', 'KAZ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Kenya(KEN)', 'KEN', 'KEN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Kiribati(KIR)', 'KIR', 'KIR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Korea, Democratic People''s Republic of(PRK)', 'PRK', 'PRK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Korea, Republic of(KOR)', 'KOR', 'KOR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Kuwait(KWT)', 'KWT', 'KWT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Kyrgyzstan(KGZ)', 'KGZ', 'KGZ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Lao PDR(LAO)', 'LAO', 'LAO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Latvia(LVA)', 'LVA', 'LVA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Lebanon(LBN)', 'LBN', 'LBN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Lesotho(LSO)', 'LSO', 'LSO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Liberia(LBR)', 'LBR', 'LBR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Libyan Arab Jamahiriya(LBY)', 'LBY', 'LBY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Liechtenstein(LIE)', 'LIE', 'LIE', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Lithuania(LTU)', 'LTU', 'LTU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Luxembourg(LUX)', 'LUX', 'LUX', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Macedonia, Republic of(MKD)', 'MKD', 'MKD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Madagascar(MDG)', 'MDG', 'MDG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Malawi(MWI)', 'MWI', 'MWI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Malaysia(MYS)', 'MYS', 'MYS', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Maldives(MDV)', 'MDV', 'MDV', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mali(MLI)', 'MLI', 'MLI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Malta(MLT)', 'MLT', 'MLT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Marshall Islands(MHL)', 'MHL', 'MHL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Martinique(MTQ)', 'MTQ', 'MTQ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mauritania(MRT)', 'MRT', 'MRT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mauritius(MUS)', 'MUS', 'MUS', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mayotte(MYT)', 'MYT', 'MYT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mexico(MEX)', 'MEX', 'MEX', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Micronesia, Federated States of(FSM)', 'FSM', 'FSM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Moldova(MDA)', 'MDA', 'MDA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Monaco(MCO)', 'MCO', 'MCO', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mongolia(MNG)', 'MNG', 'MNG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Montenegro(MNE)', 'MNE', 'MNE', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Montserrat(MSR)', 'MSR', 'MSR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Morocco(MAR)', 'MAR', 'MAR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Mozambique(MOZ)', 'MOZ', 'MOZ', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Myanmar(MMR)', 'MMR', 'MMR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Namibia(NAM)', 'NAM', 'NAM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Nauru(NRU)', 'NRU', 'NRU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Nepal(NPL)', 'NPL', 'NPL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Netherlands(NLD)', 'NLD', 'NLD', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Netherlands Antilles(ANT)', 'ANT', 'ANT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - New Caledonia(NCL)', 'NCL', 'NCL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - New Zealand(NZL)', 'NZL', 'NZL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Nicaragua(NIC)', 'NIC', 'NIC', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Niger(NER)', 'NER', 'NER', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Nigeria(NGA)', 'NGA', 'NGA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Niue(NIU)', 'NIU', 'NIU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Norfolk Island(NFK)', 'NFK', 'NFK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Northern Mariana Islands(MNP)', 'MNP', 'MNP', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Norway(NOR)', 'NOR', 'NOR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Oman(OMN)', 'OMN', 'OMN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Pakistan(PAK)', 'PAK', 'PAK', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Palau(PLW)', 'PLW', 'PLW', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Palestinian Territory, Occupied(PSE)', 'PSE', 'PSE', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Panama(PAN)', 'PAN', 'PAN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Papua New Guinea(PNG)', 'PNG', 'PNG', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Paraguay(PRY)', 'PRY', 'PRY', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Peru(PER)', 'PER', 'PER', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Philippines(PHL)', 'PHL', 'PHL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Pitcairn(PCN)', 'PCN', 'PCN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Poland(POL)', 'POL', 'POL', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Portugal(PRT)', 'PRT', 'PRT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Puerto Rico(PRI)', 'PRI', 'PRI', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Qatar(QAT)', 'QAT', 'QAT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Runion(REU)', 'REU', 'REU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Romania(ROU)', 'ROU', 'ROU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Russian Federation(RUS)', 'RUS', 'RUS', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Rwanda(RWA)', 'RWA', 'RWA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint-Barthlemy(BLM)', 'BLM', 'BLM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint Helena(SHN)', 'SHN', 'SHN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint Kitts and Nevis(KNA)', 'KNA', 'KNA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint Lucia(LCA)', 'LCA', 'LCA', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint-Martin (French part)(MAF)', 'MAF', 'MAF', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint Pierre and Miquelon(SPM)', 'SPM', 'SPM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saint Vincent and Grenadines(VCT)', 'VCT', 'VCT', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Samoa(WSM)', 'WSM', 'WSM', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - San Marino(SMR)', 'SMR', 'SMR', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Sao Tome and Principe(STP)', 'STP', 'STP', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Saudi Arabia(SAU)', 'SAU', 'SAU', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Senegal(SEN)', 'SEN', 'SEN', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Serbia(SRB)', 'SRB', 'SRB', 2,  @ApplicationId)
INSERT INTO Jurisdiction (DisplayName, Code, CountryCode, JurisdictionType, ApplicationId) VALUES('Country - Seychelles(SYC)', 'SYC', 'SYC', 2,  @ApplicationId)

--|--------------------------------------------------------------------------------
--| [JurisdictionGroup] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @JurisdictionGroupId int
INSERT INTO [JurisdictionGroup]
([ApplicationId], [DisplayName], [JurisdictionType], [Code])
VALUES
(@ApplicationId, 'United States', 2, 'USA');
set @JurisdictionGroupId = SCOPE_IDENTITY()

--|--------------------------------------------------------------------------------
--| [JurisdictionRelation] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [JurisdictionRelation]
([JurisdictionId], [JurisdictionGroupId])
VALUES
(@JurisdictionId, @JurisdictionGroupId);
--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [OrderStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(1, 'OnHold', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(2, 'PartiallyShipped', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(3, 'InProgress', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(4, 'Completed', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(5, 'Cancelled', @ApplicationId);

INSERT INTO [OrderStatus]
([OrderStatusId], [Name], [ApplicationId])
VALUES
(6, 'AwaitingExchange', @ApplicationId);
--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [OrderShipmentStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(1, 'AwaitingInventory', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(2, 'Cancelled', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(3, 'InventoryAssigned', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(4, 'OnHold', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(5, 'Packing', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(6, 'Released', @ApplicationId);

INSERT INTO [OrderShipmentStatus]
([OrderShipmentStatusId], [Name], [ApplicationId])
VALUES
(7, 'Shipped', @ApplicationId);

--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [ReturnFormStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(1, 'Complete', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(2, 'Canceled', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(3, 'AwaitingStockReturn', @ApplicationId);

INSERT INTO [ReturnFormStatus]
([ReturnFormStatusId], [Name], [ApplicationId])
VALUES
(4, 'AwaitingCompletion', @ApplicationId);
--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [OrderNoteTypes] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(1, 'Info', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(2, 'Shipment', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(3, 'ReturnsExchange', @ApplicationId);

INSERT INTO [OrderNoteType]
([OrderNoteTypeId], [Name], [ApplicationId])
VALUES
(4, 'Payments', @ApplicationId);

--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [ShippingOption] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @ShippingOptionId1 uniqueidentifier, @ShippingOptionId2 uniqueidentifier
set @ShippingOptionId1 = newid()
set @ShippingOptionId2 = newid()

INSERT INTO [ShippingOption]
([ShippingOptionId], [Name], [Description], [SystemKeyword], [ClassName], [Created], [Modified], [ApplicationId])
VALUES
(@ShippingOptionId1, 'Weight/Jurisdiction Gateway', '', 'WeightJurisdiction', 'Mediachase.Commerce.Plugins.Shipping.WeightJurisdictionGateway, Mediachase.Commerce.Plugins.Shipping', '10/07/2008 18:21:01', '10/08/2008 18:54:12', @ApplicationId);

INSERT INTO [ShippingOption]
([ShippingOptionId], [Name], [Description], [SystemKeyword], [ClassName], [Created], [Modified], [ApplicationId])
VALUES
(@ShippingOptionId2, 'Generic Gateway', '', 'Generic', 'Mediachase.Commerce.Plugins.Shipping.Generic.GenericGateway, Mediachase.Commerce.Plugins.Shipping', '01/01/2007 00:00:00', '01/01/2007 00:00:00', @ApplicationId);

--|--------------------------------------------------------------------------------
--| [ShippingMethod] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @ShippingMethodId1 uniqueidentifier, @ShippingMethodId2 uniqueidentifier, @ShippingMethodId3 uniqueidentifier
set @ShippingMethodId1 = newid()
set @ShippingMethodId2 = newid()
set @ShippingMethodId3 = newid()

INSERT INTO [ShippingMethod]
([ShippingMethodId], [ShippingOptionId], [ApplicationId], [LanguageId], [IsActive], [Name], [Description], [BasePrice], [Currency], [DisplayName], [IsDefault], [Ordering], [Created], [Modified])
VALUES
(@ShippingMethodId1, @ShippingOptionId1, @ApplicationId, 'en', 1, 'Default Shipping', 'Calculates shipping based on weight and zone.', 2, 'USD', 'Ground Shipping', 1, 0, '10/07/2008 18:21:37', '10/08/2008 20:27:44');

INSERT INTO [ShippingMethod]
([ShippingMethodId], [ShippingOptionId], [ApplicationId], [LanguageId], [IsActive], [Name], [Description], [BasePrice], [Currency], [DisplayName], [IsDefault], [Ordering], [Created], [Modified])
VALUES
(@ShippingMethodId2, @ShippingOptionId2, @ApplicationId, 'en', 1, 'Online Download', NULL, 10, 'USD', 'Fixed Shipping Rate', 0, 0, '01/01/2007 00:00:00', '01/01/2007 00:00:00');

INSERT INTO [ShippingMethod]
([ShippingMethodId], [ShippingOptionId], [ApplicationId], [LanguageId], [IsActive], [Name], [Description], [BasePrice], [Currency], [DisplayName], [IsDefault], [Ordering], [Created], [Modified])
VALUES
(@ShippingMethodId3, @ShippingOptionId2, @ApplicationId, 'en', 1, 'In Store Pickup', NULL, 0, 'USD', 'In Store Pickup', 0, 0, '2013-04-17 10:11:32', '2013-04-17 10:11:32');

--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [ShippingMethodCase] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [ShippingMethodCase]
([Total], [Charge], [ShippingMethodId], [JurisdictionGroupId], [StartDate], [EndDate])
VALUES
(0, 10, @ShippingMethodId1, @JurisdictionGroupId, '10/08/2008 00:00:00', '10/08/2020 00:00:00');

--|--------------------------------------------------------------------------------
--| [PaymentMethod] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
VALUES (newid(), @ApplicationId, 'Pay By Phone', 'Pay by phone payment', 'en', 'Generic', 'Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce', 1, 1, 'Mediachase.Commerce.Plugins.Payment.GenericPaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00');

INSERT INTO [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
VALUES (newid(), @ApplicationId, 'Pay By Credit Card', 'Pay By Credit Card', 'en', 'Authorize', 'Mediachase.Commerce.Orders.CreditCardPayment, Mediachase.Commerce', 1, 0, 'Mediachase.Commerce.Plugins.Payment.Authorize.AuthorizePaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00');

INSERT INTO [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
VALUES (newid(), @ApplicationId, 'Pay per Telefon', 'Pay per Telefon', 'de', 'Generic', 'Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce', 1, 1, 'Mediachase.Commerce.Plugins.Payment.GenericPaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00');

INSERT INTO [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
VALUES (newid(), @ApplicationId, 'Pago por telfono', 'Pago por telfono', 'es', 'Generic', 'Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce', 1, 1, 'Mediachase.Commerce.Plugins.Payment.GenericPaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00');

INSERT INTO [PaymentMethod] ([PaymentMethodId], [ApplicationId], [Name], [Description], [LanguageId], [SystemKeyword], [PaymentImplementationClassName], [IsActive], [IsDefault], [ClassName], [SupportsRecurring], [Ordering], [Created], [Modified])
VALUES (newid(), @ApplicationId, 'ExchangePayment', 'Exchange Payment', 'en', 'Exchange', 'Mediachase.Commerce.Orders.OtherPayment, Mediachase.Commerce', 0, 0, 'Mediachase.Commerce.Plugins.Payment.GenericPaymentGateway, Mediachase.Commerce.Plugins.Payment', 1, 2, '04/20/2010 00:00:00', '04/20/2010 00:00:00');

--|--------------------------------------------------------------------------------
--| [MarketPaymentMethods] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------

INSERT INTO [MarketPaymentMethods] ([PaymentMethodId], [MarketId])
SELECT pm.PaymentMethodId, m.MarketId 
FROM [PaymentMethod] pm 
CROSS JOIN [Market] m
WHERE NOT EXISTS (SELECT * FROM [MarketPaymentMethods] mpm WHERE mpm.PaymentMethodId = pm.PaymentMethodId AND mpm.MarketId = m.MarketId);

--|--------------------------------------------------------------------------------
--| [ReturnReasonDictionary] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO ReturnReasonDictionary ([ReturnReasonText], [ApplicationId], [Ordering], [Visible]) VALUES('Faulty', @ApplicationId, 0, 1);
INSERT INTO ReturnReasonDictionary ([ReturnReasonText], [ApplicationId], [Ordering], [Visible]) VALUES('Unwanted Gift', @ApplicationId, 0, 1);
INSERT INTO ReturnReasonDictionary ([ReturnReasonText], [ApplicationId], [Ordering], [Visible]) VALUES('Incorrect Item', @ApplicationId, 0, 1);
GO

------------------------- Bring the SchemaVersion up to the current level -----------------------
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 73) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_OrderSystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_OrderSystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO
