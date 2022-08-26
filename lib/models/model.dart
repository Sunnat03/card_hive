class Cards {
  late int id;
  late String name;
  late String cardNumber;
  late String expiryDate;
  late String cvv2;

  Cards(this.id, this.name, this.cardNumber, this.expiryDate, this.cvv2);

  Cards.fromJson(Map<String, dynamic> json ):
        id = json['id'],
        name = json['name'],
        cardNumber = json['cardNumber'],
        expiryDate = json['expiryDate'],
        cvv2 = json['cvv2'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'cardNumber': cardNumber,
    'expiryDate': expiryDate,
    'cvv2': cvv2,
  };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  bool operator == (Object other) {
    return other is Cards && other.id == id;
  }

  @override
  int get hashCode => Object.hash(id, name, cardNumber, expiryDate, cvv2);
}