import 'dart:math';
import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

class UpiPayment extends StatefulWidget {
  final String amount, vpa;

  const UpiPayment(this.amount, this.vpa);

  @override
  UpiPaymentState createState() => UpiPaymentState();
}

class UpiPaymentState extends State<UpiPayment> {
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
