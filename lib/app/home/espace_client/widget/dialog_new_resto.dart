import 'package:flutter/material.dart';

Future<dynamic> dialogNewResto(
    BuildContext context,
    TextEditingController _nameResto,
    TextEditingController _numClient,
    TextEditingController _addressResto) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Remplissez les champs ci-dessous"),
        content: Container(
          height: 250,
          child: Column(
            children: [
              TextField(
                controller: _nameResto,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Nom du restaurant",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(8),
                ),
                onSubmitted: (val) {
                  _nameResto.text = val.trim();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _numClient,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Numero du telephone",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(8),
                ),
                onSubmitted: (val) {
                  _numClient.text = val.trim();
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _addressResto,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "address du restaurant",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(8),
                ),
                onSubmitted: (val) {
                  _addressResto.text = val.trim();
                },
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  // DatabaseMethodes().sendMessage(
                  //     _nameResto.text,
                  //     _numClient.text,
                  //     _addressResto.text);
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'ENVOYER',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
