import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home/espace_client/espace_client_bloc.dart';
import 'package:kw_express_pfe/app/models/new_resto.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';

Future<dynamic> dialogNewResto(
  BuildContext context,
  TextEditingController _nameResto,
  TextEditingController _numClient,
  TextEditingController _addressResto,
  EspaceClientBloc bloc,
) {
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
                keyboardType: TextInputType.phone,
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
                onTap: () async {
                  NewResto newResto = NewResto(
                    id: '',
                    name: _nameResto.text,
                    phoneNumber: _numClient.text,
                    address: _addressResto.text,
                  );
                  try {
                    await bloc.senNewRestoInfo(newResto);
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: 'Les informations sont passée avec succès',
                      toastLength: Toast.LENGTH_LONG,
                    );
                  } on Exception catch (e) {
                    PlatformExceptionAlertDialog(exception: e).show(context);
                  }
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
