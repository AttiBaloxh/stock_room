import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '.././stripe_payment/StripeTransactionResponse.dart';

class ExisteCards extends StatefulWidget {
  static String id = 'ExisteCards';
  @override
  _ExisteCardsState createState() => _ExisteCardsState();
}

class _ExisteCardsState extends State<ExisteCards> {
  List cards = [
    {
      'cardNumber': '6011111111111117',
      'expiryDate': '04/24',
      'cardHolderName': 'Aqeel baloch',
      'cvvCode': '007',
      'isCvvFocused': false
    },
    {
      'cardNumber': '3566002020360505',
      'expiryDate': '04/30',
      'cardHolderName': 'Assar baloch',
      'cvvCode': '770',
      'isCvvFocused': false
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
        amount: '1500', currency: 'USD', cards: stripeCard);
    await dialog.hide();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: 1200),
        ))
        .closed
        .then(
      (_) {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            var card = cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
