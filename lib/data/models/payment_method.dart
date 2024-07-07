class PaymentMethod {
  final int id;
  final String cardName;
  final String type;
  final int lastFourDigits;

  PaymentMethod({
    required this.id,
    required this.cardName,
    required this.type,
    required this.lastFourDigits,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      cardName: json['card_name'],
      type: json['type'],
      lastFourDigits: json['last_four'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_name': cardName,
      'type': type,
      'last_four_digits': lastFourDigits,
    };
  }
}
