import 'package:testqa/core/localization/localization_methods.dart';
import 'package:testqa/screens/payment/payment_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BuildPaymentDialog extends StatelessWidget {
  const BuildPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(cardColor: Colors.white),
      child: CupertinoAlertDialog(
        title:  Text(
          tr("youMustPay", context),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          CupertinoDialogAction(
            child:  Text(
              tr("goBack", context),
              style:const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child:  Text(
              tr("pay", context),
              style:const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Payment(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
