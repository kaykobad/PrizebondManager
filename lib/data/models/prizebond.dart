class PrizeBond {
  final int id;
  final String prizeBondNumber;
  final DateTime insertDate;
  final DateTime updateDate;

  PrizeBond({this.id, this.prizeBondNumber, this.insertDate, this.updateDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prizeBondNumber': prizeBondNumber,
      'insertDate': insertDate,
      'updateDate': updateDate,
    };
  }
}