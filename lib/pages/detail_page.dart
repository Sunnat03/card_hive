import 'package:card_hive/models/model.dart';
import 'package:card_hive/pages/home_page.dart';
import 'package:card_hive/service/db_service.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DetailPage extends StatefulWidget {
  static const id = "/detail_page";

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  FocusNode cardNumberFocus = FocusNode();
  FocusNode expiryDateFocus = FocusNode();
  FocusNode cvv2Focus = FocusNode();
  FocusNode cardHolderFocus = FocusNode();

  var maskFormatterNumber = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  var maskFormatterData = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvv2Controller = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();

  void nextExpiryDate() {
    FocusScope.of(context).requestFocus(expiryDateFocus);
  }

  void nextCVV2() {
    FocusScope.of(context).requestFocus(cvv2Focus);
  }

  void nextName() {
    FocusScope.of(context).requestFocus(cardHolderFocus);
  }

  void getCardNumber(String? value) {
    if (value?.length == 19) {
      nextExpiryDate();
    }
  }

  void getExpiryDate(String? value) {
    if (value?.length == 4) {
      nextCVV2();
    }
  }

  void getCVV2(String? value) {
    if (value?.length == 3) {
      nextName();
    }
  }

  void saveCard() async {
    String numberCard = cardNumberController.text.trim();
    String dateExpiry = expiryDateController.text.trim();
    String cvv2 = cvv2Controller.text.trim();
    String holderCard = cardHolderController.text.trim();

    if (numberCard.isNotEmpty &&
        dateExpiry.isNotEmpty &&
        cvv2.isNotEmpty &&
        holderCard.isNotEmpty) {
      Navigator.pop(
          context, Cards(1, holderCard, numberCard, dateExpiry, cvv2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(41, 76, 204, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(41, 76, 204, 1),
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // #Add your card
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Add your card",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              splashRadius: 25,
              onPressed: () {},
              icon: const Icon(Icons.zoom_in_map),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // #Fill in the fields below or use camera phone
            Padding(
              padding: const EdgeInsets.only(right: 70),
              child: Text(
                "Fill in the fields below or use camera phone",
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // #Your card number
            const Padding(
              padding: EdgeInsets.only(right: 225),
              child: Text(
                "Your card number",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: cardNumberController,
                focusNode: cardNumberFocus,
                inputFormatters: [maskFormatterNumber],
                onChanged: getCardNumber,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.adjust_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                onEditingComplete: nextExpiryDate,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 15),
            // #Expiry date, #CVV2
            Row(
              children: const [
                SizedBox(width: 35),
                Text(
                  "Expiry date",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 115),
                Text(
                  "CVV2",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: getExpiryDate,
                      inputFormatters: [maskFormatterData],
                      controller: expiryDateController,
                      focusNode: expiryDateFocus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      onEditingComplete: nextCVV2,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                Center(
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: getCVV2,
                      controller: cvv2Controller,
                      focusNode: cvv2Focus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      onEditingComplete: nextName,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // #Card holder
            const Padding(
              padding: EdgeInsets.only(right: 270),
              child: Text(
                "Card holder",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: cardHolderController,
                focusNode: cardHolderFocus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            // #Save card
            Container(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 50,
              ),
              child: MaterialButton(
                onPressed: saveCard,
                elevation: 0,
                height: 50,
                minWidth: 360,
                color: Colors.red,
                child: const Text(
                  "Save Card",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
