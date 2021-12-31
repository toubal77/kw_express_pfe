import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/app/home_admin/approved/approved_bloc.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/utils/logger.dart';

class RestaurentDetailScreen extends StatefulWidget {
  const RestaurentDetailScreen({
    Key? key,
    required this.restaurent,
    required this.bloc,
  }) : super(key: key);
  final Restaurent restaurent;
  final ApprovedBloc bloc;

  @override
  _RestaurentDetailScreenState createState() => _RestaurentDetailScreenState();
}

class _RestaurentDetailScreenState extends State<RestaurentDetailScreen> {
  @override
  void initState() {
    logger.info(widget.restaurent.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "détail de l'utilisateur",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile photo:'),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.restaurent.profilePicture!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text('Couverture photo:'),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.restaurent.couvPicture!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CustomTextForm(
                isEnabled: false,
                titleStyle: TextStyle(),
                initialValue: widget.restaurent.name,
                fillColor: Colors.white70,
                title: 'Nom :',
                hintText: 'Nom...',
                maxLength: 50,
                textInputAction: TextInputAction.next,
                onChanged: (var value) {},
                validator: (String? value) {},
              ),
              CustomTextForm(
                isEnabled: false,
                titleStyle: TextStyle(),
                initialValue: widget.restaurent.bio,
                fillColor: Colors.white70,
                title: 'Bio:',
                hintText: 'Bio...',
                textInputAction: TextInputAction.next,
                onChanged: (var value) {},
                validator: (String? value) {},
              ),
              CustomTextForm(
                isEnabled: false,
                titleStyle: TextStyle(),
                initialValue: widget.restaurent.address,
                fillColor: Colors.white70,
                title: 'Localisation:',
                hintText: 'Oran,Alger...',
                textInputAction: TextInputAction.next,
                onChanged: (var value) {},
                validator: (String? value) {},
              ),
              CustomTextForm(
                isEnabled: false,
                titleStyle: TextStyle(),
                initialValue: widget.restaurent.phoneNumber,
                fillColor: Colors.white70,
                title: 'Numero de telephone:',
                hintText: 'Numero de telephone...',
                textInputAction: TextInputAction.next,
                onChanged: (var value) {},
                validator: (String? value) {},
              ),
              ButtomMedia(
                press: () {
                  widget.bloc.approveUser(widget.restaurent);
                  Fluttertoast.showToast(
                    msg: 'L\'utilisateur approve avec succès',
                    toastLength: Toast.LENGTH_LONG,
                  );
                  Navigator.of(context).pop();
                },
                color: Color(0xff5383EC),
                text: 'approve',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
