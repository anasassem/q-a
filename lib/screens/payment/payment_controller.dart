// ignore_for_file: avoid_print, use_build_context_synchronously

part of 'payment_imports.dart';

class PaymentController {
  final GenericBloc<PayOptions> payOptionsBloc =
      GenericBloc(PayOptions.daysFree);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String getPaymentAmount() {
    if (payOptionsBloc.state.data == PayOptions.daysFree) {
      return "3.99";
    } else if (payOptionsBloc.state.data == PayOptions.monthly) {
      return "9.99";
    } else if (payOptionsBloc.state.data == PayOptions.yearly) {
      return "49.99";
    } else {
      return "";
    }
  }

  String getPaymentType() {
    if (payOptionsBloc.state.data == PayOptions.daysFree) {
      return "week";
    } else if (payOptionsBloc.state.data == PayOptions.monthly) {
      return "monthly";
    } else if (payOptionsBloc.state.data == PayOptions.yearly) {
      return "yearly";
    } else {
      return "";
    }
  }

  void onSkipPayment(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    if (payOptionsBloc.state.data == PayOptions.daysFree) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(
        {
          "payment_date": DateTime.now(),
          "payment_type": "none",
          "is_payment": true,
          "used_free": true,
          "questions_count": 0
        },
      );
      var data = await firestore.collection("users").doc(uid).get();
      var parsedData = UserModel.fromJson(data.data()!);
      log("data :        \n ${parsedData.toJson()}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
      return;
    }
  }

  void handleDaysFreeSubscription(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    if (payOptionsBloc.state.data == PayOptions.daysFree) {
      await FirebaseFirestore.instance.collection("users").doc(uid).update(
        {
          "payment_date": DateTime.now(),
          "payment_type": "week",
          "is_payment": true,
          "used_free": true
        },
      );
      var data = await firestore.collection("users").doc(uid).get();
      var parsedData = UserModel.fromJson(data.data()!);
      log("data :        \n ${parsedData.toJson()}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
          deviceId: uid!,
        ),
      ));
      return;
    }
  }

  void onPayment(BuildContext context) async {
    var uid = await GetDeviceId().deviceId;
    handleDaysFreeSubscription(context);
    if (payOptionsBloc.state.data != PayOptions.daysFree) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => UsePaypal(
              clientId: "AXdLx_QxCmHavl6E4B5IMxt3i_-XFq0KRKT2z6xYBD-knRwkGp1GG_PNrJ0LCh37oW1fzEr1j0DJ9nfQ",
              secretKey: "EMqvVwaO4QM8Qt45ITV8Pkx9vAMgkyjjMHHbMNcZw1AY4cvUJObDpRRBVjTpQCwfSkolDArwz6IZXeuT",
              returnURL: "https://samplesite.com/return",
              cancelURL: "https://samplesite.com/cancel",
              transactions: [
                {
                  "amount": {
                    "total": getPaymentAmount(),
                    "currency": "USD",
                    "details": {
                      "subtotal": getPaymentAmount(),
                      "shipping": '0',
                      "shipping_discount": 0
                    }
                  },
                  "description": "The payment transaction description.",
                  "item_list": {
                    "items": [
                      {
                        "name": "Q & A",
                        "quantity": 1,
                        "price": getPaymentAmount(),
                        "currency": "USD"
                      }
                    ],
                  }
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                String? uid = await GetDeviceId().deviceId;
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .update({
                  "payment_date": DateTime.now(),
                  "payment_type": getPaymentType(),
                  "is_payment": true,
                });
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Home(
                    deviceId: uid!,
                  ),
                ));
              },
              onError: (error) {
                print("onError: $error");
              },
              onCancel: (params) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Home(
                    deviceId: uid!,
                  ),
                ));
              }),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Home(
            deviceId: uid!,
          ),
        ),
      );
    }
  }
}
