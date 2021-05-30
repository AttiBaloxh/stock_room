import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51IZcZaBjbHXbOZiYsoc5USMImZ2UEgC0ZOWzCFurd2D2nwiEyx9yEvjDZQZtRrPCVn8hh02LS3bTet9YPQyZgFG1001Ctx8RNO';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            "pk_test_51IZcZaBjbHXbOZiYv0Uta5EKwla3GrjETxOaAn9byKxRNueIP8FX2mPJs4SkOGJjFO7qTBgGu67kxSS8rwsMA3d300NGF7d9To",
        merchantId: "Test",
        androidPayMode: 'test'));
  }

  static  Future<StripeTransactionResponse> payViaExistingCard({
    String amount,
    String currency,
    cards,
  }) async{
    try {
      var paymentMethed = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: cards),  
      );
      var paymentIntent = await StripeService.createPaymentIntent(
        amount,
        currency,
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
            clientSecret: paymentIntent['client_secret'],
            paymentMethodId: paymentMethed.id),
      );
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction successful',
          success: true,
        );
      } else
        return StripeTransactionResponse(
          message: 'Transaction failed}',
          success: false,
        );

    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction failed : ${err.toString()}',
        success: false,
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard({
    String amount,
    String currency,
  }) async {
    try {
      var paymentMethed = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      var paymentIntent = await StripeService.createPaymentIntent(
        amount,
        currency,
      );
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
            clientSecret: paymentIntent['client_secret'],
            paymentMethodId: paymentMethed.id),
      );
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction successful',
          success: true,
        );
      } else
        return StripeTransactionResponse(
          message: 'Transaction failed}',
          success: false,
        );

    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction failed : ${err.toString()}',
        success: false,
      );
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return new StripeTransactionResponse(
      message: message,
      success: false,
    );
  }
  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse(
          StripeService.paymentApiUrl,
        ),
        body: body,
        headers: headers,
      );
      print('  Working...  $paymentApiUrl');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charing user: ${err.toString()}');
    }
    return null;
  }
}
