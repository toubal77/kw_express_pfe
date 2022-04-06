import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/app/home_restaurent/espace_resto/espace_resto_bloc.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/strings.dart';
import 'package:kw_express_pfe/utils/validators.dart';

class ConfirmationPhoneScreen extends StatefulWidget {
  const ConfirmationPhoneScreen({
    Key? key,
    //   required this.onNextPressed,
    required this.bloc,
    required this.phoneNumber,
  }) : super(key: key);

  final EspaceRestoBloc bloc;
  final String phoneNumber;
  // final ValueChanged<String> onNextPressed;

  @override
  _ConfirmationPhoneScreenState createState() =>
      _ConfirmationPhoneScreenState();
}

class _ConfirmationPhoneScreenState extends State<ConfirmationPhoneScreen> {
  late String code;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
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
          SignUpTitle(title: 'confirmation du numéro'),
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
                      'pour confirmer votre numéro, entrez le code SMS ici :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  CustomTextForm(
                    fillColor: Colors.white70,
                    title: '',
                    hintText: 'CODE',
                    maxLength: 6,
                    isPhoneNumber: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (var value) {
                      code = value;
                    },
                    validator: (String? value) {
                      if (!Validators.isValidVerificationCode(value)) {
                        return invalidVerificationCodeError;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: ButtomMedia(
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.bloc.sendInfo(widget.phoneNumber, code, context);
                    Fluttertoast.showToast(
                      msg: 'Update phone avec succès',
                      toastLength: Toast.LENGTH_LONG,
                    );
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
