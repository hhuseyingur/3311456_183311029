import 'package:bunudaoku/models/Gazete.dart';
import 'package:flutter/material.dart';

class GazeteDetay extends StatelessWidget {
  Gazete gazete;
  GazeteDetay({required this.gazete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gazete.gazeteadi),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 50),
              child: Column(
                children: [
                  //Center(child: Text(gazete.kitapyazar)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Gazete No : ",
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Text(gazete.gazeteno),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
