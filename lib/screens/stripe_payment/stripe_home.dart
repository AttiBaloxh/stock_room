import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:stock_room_app/screens/stripe_payment/StripeTransactionResponse.dart';
import 'package:stock_room_app/screens/stripe_payment/existe_cards.dart';

class StripeHome extends StatefulWidget {
  static String id = 'StripeHome';
  @override
  _StripeHomeState createState() => _StripeHomeState();
}

class _StripeHomeState extends State<StripeHome> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        var response = await StripeService.payWithNewCard(
            amount: '24000', currency: 'USD');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            duration: new Duration(
                milliseconds: response.success == true ? 1200 : 3000),
          ),
        );

        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExisteCards(),
          ),
        );
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Please wait...');
    await dialog.show();
    var response =
        await StripeService.payWithNewCard(amount: '15000', currency: 'USD');
    await dialog.hide();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message),
        duration:
            new Duration(milliseconds: response.success == true ? 1200 : 3000),
      ),
    );
  }
  @override
  void initState() {
    StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Icon icon;
            Text text;

            switch (index) {
              case 0:
                icon = Icon(Icons.add_circle, color: theme.primaryColor);
                text = Text('Pay via new card');
                break;
              case 1:
                icon = Icon(Icons.credit_card, color: theme.primaryColor);
                text = Text('Pay via existing card');
                break;
            }

            return InkWell(
              onTap: () {
                onItemPress(context, index);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: theme.primaryColor,
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
