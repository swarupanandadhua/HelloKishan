import 'dart:math';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upi_pay/upi_pay.dart';

class Payment extends StatefulWidget {
  final String amount, vpa;

  const Payment(this.amount, this.vpa);

  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  String invalidVpaError;
  Future<List<ApplicationMeta>> upiApps;

  @override
  void initState() {
    super.initState();
    upiApps = UpiPay.getInstalledUpiApplications();
  }

  String validateVpa(String value) {
    if (value.isEmpty) {
      return 'UPI Address is required ';
    }
    if (!UpiPay.checkIfUpiAddressIsValid(value)) {
      return 'Invalid UPI Address !';
    }
    return null;
  }

  Future<void> openUPIGateway(ApplicationMeta app) async {
    final err = validateVpa(widget.vpa);
    if (err != null) {
      setState(() => invalidVpaError = err);
      return;
    }
    setState(() => invalidVpaError = null);

    final tid = Random.secure().nextInt(1 << 32).toString();
    debugPrint('Transaction ID: $tid');

    final response = await UpiPay.initiateTransaction(
      transactionRef: tid,
      receiverUpiAddress: widget.vpa,
      receiverName: 'Swarupananda Dhua',
      amount: widget.amount,
      app: app.upiApplication,
    );
    debugPrint(response.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(title: Text('Payment')),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Row(
                    children: <Widget>[
                      Text(widget.vpa),
                    ],
                  ),
                ),
                if (invalidVpaError != null)
                  Container(
                    margin: EdgeInsets.only(top: 4, left: 12),
                    child: Text(
                      invalidVpaError,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Row(
                    children: <Widget>[
                      Text('Amount: '),
                      Text(widget.amount),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 128, bottom: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Pay Using',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      FutureBuilder<List<ApplicationMeta>>(
                        future: upiApps,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Container();
                          }

                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.6,
                            physics: NeverScrollableScrollPhysics(),
                            children: snapshot.data
                                .map(
                                  (i) => Material(
                                    key: ObjectKey(i.upiApplication),
                                    color: Colors.grey[200],
                                    child: InkWell(
                                      onTap: () => openUPIGateway(i),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.memory(
                                            i.icon,
                                            width: 64,
                                            height: 64,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            child: Text(
                                              i.upiApplication.getAppName(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Payment2 extends StatefulWidget {
  final String amount, vpa;

  const Payment2(this.amount, this.vpa);

  @override
  Payment2State createState() => Payment2State();
}

class Payment2State extends State<Payment2> {
  Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    Map<String, dynamic> options = {
      'key': 'rzp_test_UPa3aC3LVTwpVR', // TODO
      'amount': int.parse(widget.amount),
      'name': 'Hello Kishan',
      'description': 'Payment for Hello Kishan',
      'prefill': {
        'contact': '+919609750449',
        'email': 'swarupanandadhua@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error from try...catch is :');
      debugPrint(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment successful.');
    debugPrint(response.toString());
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    debugPrint('handlerErrorFailure: Payment failed.');
    debugPrint(response.toString());
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    debugPrint('External Wallet...');
    debugPrint(response.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razor Pay Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(widget.amount),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Donate Now'),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
