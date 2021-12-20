import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/carousel_slider.dart';
import 'package:kw_express_pfe/services/firebase_auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                FirebaseAuthService().signOut();
              },
              child: Text('Sing out'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddImages();
                    },
                  ),
                );
              },
              child: Text('Add images'),
            ),
          ],
        ),
      ),
    );
  }
}
