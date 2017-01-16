########################################################
## MySQL_extend_eanprod_nl_nl.sql                v2.7 ##
## (International) Japanese data tables               ##
## This is a suplemental script that you can use to   ##
## extend the database eanprod and add languages.     ##
## we choose as a convention to use name_xx_xx        ##
## table names are lowercase so it will work for all  ## 
## MySQL platforms the same.                          ##
########################################################
## 2.7 - Created the ActivePropertyBusinessModel_xx_XX
USE eanprod;

########################################################
##                                                    ##
## TABLES CREATED FROM THE EAN RELATIONAL DOWNLOADED  ##
## FILES, but with the language code as:              ##
## ar_SA,es_ES,fr_FR,it_IT,es_es,tr_TR,cs_CZ,es_MX,   ##
## hr_HR,ko_KR,no_NO,ru_RU,uk_UA,da_DK,et_EE,hu_HU,   ##
## lt_LT,nl_NL,sk_SK,vi_VN,de_DE,fi_FI,in_ID,lv_LV,   ##
## pl_PL,sv_SE,zh_CN,el_GR,fr_CA,is_IS,ms_MY,pt_BR,   ##
## th_TH,zh_TW                                        ##
########################################################

## ActivePropertyList - structure is different for en_US version
DROP TABLE IF EXISTS activepropertylist_nl_nl;
CREATE TABLE activepropertylist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	Name VARCHAR(70),
    Location VARCHAR(80),
    CheckInTime VARCHAR(10),
	CheckOutTime VARCHAR(10),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## table to correct search term for a region
## notice there are NO spaces between words
## AliasRegionList - structure is the same as US version
DROP TABLE IF EXISTS aliasregionlist_nl_nl;
CREATE TABLE aliasregionlist_nl_nl
(
	RegionID INT NOT NULL,
	LanguageCode VARCHAR(5),
	AliasString VARCHAR(255),
    TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
##	PRIMARY KEY (RegionID, AliasString)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE INDEX idx_aliasregionlist_nl_nl_regionid ON aliasregionlist_nl_nl(RegionID);


## AreaAttractionsList - structure is the same as US version
DROP TABLE IF EXISTS areaattractionslist_nl_nl;
CREATE TABLE areaattractionslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	AreaAttractions TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## ActivePropertyList - structure is different for US version
DROP TABLE IF EXISTS attributelist_nl_nl;
CREATE TABLE attributelist_nl_nl
(
	AttributeID INT NOT NULL,
	LanguageCode VARCHAR(5),
	AttributeDesc VARCHAR(255),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (AttributeID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## CountryList - structure is different for US version
DROP TABLE IF EXISTS countrylist_nl_nl;
CREATE TABLE countrylist_nl_nl
(
	CountryID INT NOT NULL,
	LanguageCode VARCHAR(5),
## max of 191 so it will not break index max of 767 bytes (Unicode are 4x)
	CountryName VARCHAR(191),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (CountryID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## add indexes by country code & country name
CREATE INDEX idx_countrylist_nl_nl_countryname ON countrylist_nl_nl(CountryName);
## as the field ContryCode is not present, no index exist like the US version


## DinningDescriptionList - structure is the same as US version
DROP TABLE IF EXISTS diningdescriptionlist_nl_nl;
CREATE TABLE diningdescriptionlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	DiningDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PolicyDescriptionList - structure is the same for US version
DROP TABLE IF EXISTS policydescriptionlist_nl_nl;
CREATE TABLE policydescriptionlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PolicyDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;



## PropertyAttributeLink - structure is the same as US version
DROP TABLE IF EXISTS propertyattributelink_nl_nl;
CREATE TABLE propertyattributelink_nl_nl
(
	EANHotelID INT NOT NULL,
	AttributeID INT NOT NULL,
	LanguageCode VARCHAR(5),
	AppendTxt VARCHAR(191),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
## table so far do not present the same problem as GDSpropertyattributelink
	PRIMARY KEY (EANHotelID, AttributeID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## PropertyDescriptionList - structure is the same as US version
DROP TABLE IF EXISTS propertydescriptionlist_nl_nl;
CREATE TABLE propertydescriptionlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## PropertyTypeList - structure is the same as US version
DROP TABLE IF EXISTS propertytypelist_nl_nl;
CREATE TABLE propertytypelist_nl_nl
(
	PropertyCategory INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyCategoryDesc VARCHAR(256),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (PropertyCategory)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## RecreationDescriptionList - structure is the same as US version
DROP TABLE IF EXISTS recreationdescriptionlist_nl_nl;
CREATE TABLE recreationdescriptionlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	RecreationDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## RegionList - structure is different for US version
## table is RegionList, while US is ParentRegionList
DROP TABLE IF EXISTS regionlist_nl_nl;
CREATE TABLE regionlist_nl_nl
(
  RegionID INT NOT NULL,
  LanguageCode VARCHAR(5),
  RegionName VARCHAR(255),
  RegionNameLong VARCHAR(510),
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (RegionID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## SpaDescriptionList - structure is the same as US version
DROP TABLE IF EXISTS spadescriptionlist_nl_nl;
CREATE TABLE spadescriptionlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	SpaDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## Multiple rooms per each hotel - so a compound primary key
## RoomTypeList - structure is different for US version
DROP TABLE IF EXISTS roomtypelist_nl_nl;
CREATE TABLE roomtypelist_nl_nl
(
	EANHotelID INT NOT NULL,
	RoomTypeID INT NOT NULL,
	LanguageCode VARCHAR(5),
	RoomTypeName VARCHAR(200),
	RoomTypeDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID, RoomTypeID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;


## WhatToExpectList - structure is the same as US version
DROP TABLE IF EXISTS whattoexpectlist_nl_nl;
CREATE TABLE whattoexpectlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	WhatToExpect TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## new files from minorrev=24 
## PropertyLocationList (new)
DROP TABLE IF EXISTS propertylocationlist_nl_nl;
CREATE TABLE propertylocationlist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyLocationDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyAmenitiesList (new)
DROP TABLE IF EXISTS propertyamenitieslist_nl_nl;
CREATE TABLE propertyamenitieslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyAmenitiesDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyRoomsList (new)
DROP TABLE IF EXISTS propertyroomslist_nl_nl;
CREATE TABLE propertyroomslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyRoomsDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyBusinessAmenitiesList (new)
DROP TABLE IF EXISTS propertybusinessamenitieslist_nl_nl;
CREATE TABLE propertybusinessamenitieslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyBusinessAmenitiesDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyNationalRatingList (new)
DROP TABLE IF EXISTS propertynationalratingslist_nl_nl;
CREATE TABLE propertynationalratingslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyNationalRatingsDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyFeesList (new)
DROP TABLE IF EXISTS propertyfeeslist_nl_nl;
CREATE TABLE propertyfeeslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyFeesDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyMandatoryFeesList (new)
DROP TABLE IF EXISTS propertymandatoryfeeslist_nl_nl;
CREATE TABLE propertymandatoryfeeslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyMandatoryFeesDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## PropertyRenovationList (new)
DROP TABLE IF EXISTS propertyrenovationslist_nl_nl;
CREATE TABLE propertyrenovationslist_nl_nl
(
	EANHotelID INT NOT NULL,
	LanguageCode VARCHAR(5),
	PropertyRenovationsDescription TEXT,
  TimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;

## Business Models for pre-pay & post-pay properties
### Business Model Flag - Expedia Collect (1), Hotel Collect (2) and ETP (3) inventory.
DROP TABLE IF EXISTS activepropertybusinessmodel_nl_nl;
CREATE TABLE activepropertybusinessmodel_nl_nl 
(
  EANHotelID INT NOT NULL,
  LanguageCode VARCHAR(5),
  Name VARCHAR(70),
  Location VARCHAR(80),
  CheckInTime VARCHAR(10),
  CheckOutTime VARCHAR(10),
  BusinessModelMask INT,
  TimeStamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (EANHotelID)
) CHARACTER SET utf8 COLLATE utf8_unicode_ci;
