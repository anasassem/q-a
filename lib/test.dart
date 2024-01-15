import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestQA extends StatelessWidget {
  const TestQA({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                var response = await FirebaseFirestore.instance
                    .collection("admin")
                    .doc("VpjPmXXJ3sjEmYF7ooLz")
                    .get();
                print("@@@@@@@@${response.data()}");
              },
              child: Text("sss")),
        ),
      ),
    );
  }
}
