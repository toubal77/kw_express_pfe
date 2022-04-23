import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/espace_resto_bloc.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/update_phone/confirmation_phone_screen.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class UpdatePhoneScreen extends StatefulWidget {
  const UpdatePhoneScreen({
    Key? key,
    //   required this.onNextPressed,
  }) : super(key: key);

  // final ValueChanged<String> onNextPressed;

  @override
  _UpdatePhoneScreenState createState() => _UpdatePhoneScreenState();
}

class _UpdatePhoneScreenState extends State<UpdatePhoneScreen> {
  late String code;
  late String phoneNumber;
  late final GlobalKey<FormState> _formKey;
  late final EspaceRestoBloc bloc;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    final Auth auth = context.read<Auth>();
    final Database database = context.read<Database>();
    bloc = EspaceRestoBloc(
      database: database,
      auth: auth,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Espace Client',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 6.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          SignUpTitle(title: 'change le numéro de telephone'),
          SizedBox(height: 30),
          SignUpDivider(),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'please enter your new phone number :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: CustomTextForm(
                      fillColor: Colors.white70,
                      title: 'Numéro de téléphone:',
                      maxLength: 10,
                      isPhoneNumber: true,
                      onChanged: (var value) {
                        phoneNumber = value;
                        phoneNumber = phoneNumber.replaceFirst(RegExp('0'), '');
                        phoneNumber = '+213$phoneNumber';
                      },
                      prefix: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '+213',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 57,
                              child: VerticalDivider(
                                thickness: 1,
                                width: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || !value.startsWith('0')) {
                          return invalidPhoneNumberError;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: ButtomMedia(
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    bloc.verifyPhoneNumber(phoneNumber);
                    // Fluttertoast.showToast(
                    //   msg: 'Update phone avec succès',
                    //   toastLength: Toast.LENGTH_LONG,
                    // );
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ConfirmationPhoneScreen(
                        bloc: bloc,
                        phoneNumber: phoneNumber,
                      );
                    }));
                  }
                },
                color: Color(0xff5383EC),
                text: 'Terminier',
              ),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
