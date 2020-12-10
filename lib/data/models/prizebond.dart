class PrizeBond {
  final int id;
  final String prizeBondNumber;
  final String insertDate;
  final String updateDate;

  PrizeBond({this.id, this.prizeBondNumber, this.insertDate, this.updateDate});

  factory PrizeBond.fromMap(Map<String, dynamic> json) => PrizeBond(
    id: json["id"],
    prizeBondNumber: json["prizeBondNumber"],
    insertDate: json["insertDate"],
    updateDate: json["updateDate"],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prizeBondNumber': prizeBondNumber,
      'insertDate': insertDate,
      'updateDate': updateDate,
    };
  }

  @override
  String toString() => "PrizeBond {id: $id, prizeBondNumber: $prizeBondNumber, insertDate: $insertDate, updateDate: $updateDate}";
}