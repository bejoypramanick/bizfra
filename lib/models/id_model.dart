
class IdModel {
  final String aadharNumber;
  final String panNumber;
  final String gstNumber;


  IdModel(
      {required this.aadharNumber,
      required this.panNumber,
      required this.gstNumber});

  Map<String, dynamic> toJson() {
    return {
      'aadharNumber': aadharNumber,
      'panNumber': panNumber,
      'gstNumber': gstNumber,
    };
  }
// You can add file paths for document uploads here
}
