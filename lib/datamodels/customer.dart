class Customer {
  int id;
  String firstName;
  String lastName;
  String emailAddress;
  String dateOfBirth;
  String gender;
  String idType;
  String idNumber;
  String address;
  String city;
  String state;
  String country;
  int postCode;
  String nationality;
  String photos;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.dateOfBirth,
    this.gender,
    this.idType,
    this.idNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postCode,
    this.nationality,
    this.photos,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    emailAddress = json['EmailAddress'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    idType = json['IdType'];
    idNumber = json['IdNumber'];
    address = json['Address'];
    city = json['City'];
    state = json['State'];
    country = json['Country'];
    postCode = json['PostCode'];
    nationality = json['Nationality'];
    photos = json['Photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['EmailAddress'] = this.emailAddress;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Gender'] = this.gender;
    data['IdType'] = this.idType;
    data['IdNumber'] = this.idNumber;
    data['Address'] = this.address;
    data['City'] = this.city;
    data['State'] = this.state;
    data['Country'] = this.country;
    data['PostCode'] = this.postCode;
    data['Nationality'] = this.nationality;
    data['Photos'] = this.photos;
    return data;
  }
}
