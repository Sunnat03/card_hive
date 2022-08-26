import 'package:card_hive/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class MakeCards extends StatelessWidget {
  final Cards card;

  const MakeCards({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      isHolderNameVisible: true,
      obscureCardNumber: false,
      cardNumber: card.cardNumber,
      expiryDate: card.expiryDate,
      cardHolderName: card.name,
      cvvCode: card.cvv2,
      showBackView: false,
      onCreditCardWidgetChange:
          (CreditCardBrand) {}, //true when you want to show cvv(back) view
    );
  }
}
