class CountriesModel{
  String? name;
  String? code;
  String? asciiname;
  String? phone;
  String? currencyCode;
  
  CountriesModel({
    this.name,
    this.code,
    this.asciiname,
    this.phone,
    this.currencyCode,
    
  });

  CountriesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    asciiname = json['asciiname'];
    phone = json['phone'];
    currencyCode = json['currency_code'];
    
  }
  
}