
class LocalisationPhoneModel {
  String? ip;
  String? network;
  String? version;
  String? city;
  String? region;
  String? regionCode;
  String? country;
  String? countryName;
  String? countryCode;
  String? countryCodeIso3;
  String? countryCapital;
  String? countryTld;
  String? continentCode;
  bool? inEu;
  String? postal;
  double? latitude;
  double? longitude;
  String? timezone;
  String? utcOffset;
  String? countryCallingCode;
  String? currency;
  String? currencyName;
  String? languages;
  int? countryArea;
  int? countryPopulation;
  String? asn;
  String? org;

  LocalisationPhoneModel({this.ip, this.network, this.version, this.city, this.region, this.regionCode, this.country, this.countryName, this.countryCode, this.countryCodeIso3, this.countryCapital, this.countryTld, this.continentCode, this.inEu, this.postal, this.latitude, this.longitude, this.timezone, this.utcOffset, this.countryCallingCode, this.currency, this.currencyName, this.languages, this.countryArea, this.countryPopulation, this.asn, this.org});

  LocalisationPhoneModel.fromJson(Map<String, dynamic> json) {
    if(json["ip"] is String) {
      ip = json["ip"];
    }
    if(json["network"] is String) {
      network = json["network"];
    }
    if(json["version"] is String) {
      version = json["version"];
    }
    if(json["city"] is String) {
      city = json["city"];
    }
    if(json["region"] is String) {
      region = json["region"];
    }
    if(json["region_code"] is String) {
      regionCode = json["region_code"];
    }
    if(json["country"] is String) {
      country = json["country"];
    }
    if(json["country_name"] is String) {
      countryName = json["country_name"];
    }
    if(json["country_code"] is String) {
      countryCode = json["country_code"];
    }
    if(json["country_code_iso3"] is String) {
      countryCodeIso3 = json["country_code_iso3"];
    }
    if(json["country_capital"] is String) {
      countryCapital = json["country_capital"];
    }
    if(json["country_tld"] is String) {
      countryTld = json["country_tld"];
    }
    if(json["continent_code"] is String) {
      continentCode = json["continent_code"];
    }
    if(json["in_eu"] is bool) {
      inEu = json["in_eu"];
    }
    if(json["postal"] is String) {
      postal = json["postal"];
    }
    if(json["latitude"] is double) {
      latitude = json["latitude"];
    }
    if(json["longitude"] is double) {
      longitude = json["longitude"];
    }
    if(json["timezone"] is String) {
      timezone = json["timezone"];
    }
    if(json["utc_offset"] is String) {
      utcOffset = json["utc_offset"];
    }
    if(json["country_calling_code"] is String) {
      countryCallingCode = json["country_calling_code"];
    }
    if(json["currency"] is String) {
      currency = json["currency"];
    }
    if(json["currency_name"] is String) {
      currencyName = json["currency_name"];
    }
    if(json["languages"] is String) {
      languages = json["languages"];
    }
    if(json["country_area"] is int) {
      countryArea = json["country_area"];
    }
    if(json["country_population"] is int) {
      countryPopulation = json["country_population"];
    }
    if(json["asn"] is String) {
      asn = json["asn"];
    }
    if(json["org"] is String) {
      org = json["org"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ip"] = ip;
    _data["network"] = network;
    _data["version"] = version;
    _data["city"] = city;
    _data["region"] = region;
    _data["region_code"] = regionCode;
    _data["country"] = country;
    _data["country_name"] = countryName;
    _data["country_code"] = countryCode;
    _data["country_code_iso3"] = countryCodeIso3;
    _data["country_capital"] = countryCapital;
    _data["country_tld"] = countryTld;
    _data["continent_code"] = continentCode;
    _data["in_eu"] = inEu;
    _data["postal"] = postal;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["timezone"] = timezone;
    _data["utc_offset"] = utcOffset;
    _data["country_calling_code"] = countryCallingCode;
    _data["currency"] = currency;
    _data["currency_name"] = currencyName;
    _data["languages"] = languages;
    _data["country_area"] = countryArea;
    _data["country_population"] = countryPopulation;
    _data["asn"] = asn;
    _data["org"] = org;
    return _data;
  }
}