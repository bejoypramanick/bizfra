
class BusinessModel {
  final String orgName;
  final String orgType;
  final String expertise;
  final String address;
  final String branches;
  final String website;

  BusinessModel({
    required this.orgName,
    required this.orgType,
    required this.expertise,
    required this.address,
    required this.branches,
    required this.website,
  });

  Map<String, dynamic> toJson() {
    return {
      'orgName': orgName,
      'orgType': orgType,
      'expertise': expertise,
      'address': address,
      'branches': branches,
      'website': website,
    };
  }
}
