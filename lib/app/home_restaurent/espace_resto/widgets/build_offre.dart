import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home_restaurent/restaurent_bloc.dart';
import 'package:kw_express_pfe/common_widgets/platform_exception_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/remise_drop_down.dart';
import 'package:kw_express_pfe/constants/strings.dart';

buildOffre(BuildContext context, RestaurentBloc bloc) async {
  final padding = EdgeInsets.symmetric(vertical: 1);
  var remise = 0;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Rendez vos clients heureux"),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Padding(
                padding: padding,
                child: RemiseDropDown(
                  fillColor: Colors.white70,
                  title: 'Remise',
                  hint: 'Remise',
                  validator: (String? value) {
                    if (value == null) {
                      return invalidWilayaError;
                    }
                    return null;
                  },
                  onChanged: (String? value) {
                    if (value == null) {
                    } else {
                      switch (value) {
                        case 'Livraison gratuite':
                          remise = -1;
                          break;
                        case '0%':
                          remise = 0;
                          break;
                        case '10%':
                          remise = 10;
                          break;
                        case '20%':
                          remise = 20;
                          break;
                        case '30%':
                          remise = 30;
                          break;
                        case '40%':
                          remise = 40;
                          break;
                        case '50%':
                          remise = 50;
                          break;
                        case '60%':
                          remise = 60;
                          break;
                        case '60%':
                          remise = 60;
                          break;
                        case '70%':
                          remise = 70;
                          break;
                        case '80%':
                          remise = 80;
                          break;
                        case '90%':
                          remise = 90;
                          break;
                        case '100%':
                          remise = 100;
                          break;
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await bloc.makeRemise(remise);
                    Fluttertoast.showToast(
                      msg: 'Remise effectuer avec succès',
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
