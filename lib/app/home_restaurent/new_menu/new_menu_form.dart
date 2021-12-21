import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/auth/widgets/buttom_media.dart';
import 'package:kw_express_pfe/common_widgets/custom_app_bar.dart';
import 'package:kw_express_pfe/common_widgets/custom_drop_down.dart';
import 'package:kw_express_pfe/common_widgets/custom_scaffold.dart';
import 'package:kw_express_pfe/common_widgets/custom_text_field.dart';
import 'package:kw_express_pfe/common_widgets/sign_up_title.dart';
import 'package:kw_express_pfe/common_widgets/signup_divider.dart';
import 'package:kw_express_pfe/constants/strings.dart';

class NewMenuRestaurentForm extends StatefulWidget {
  const NewMenuRestaurentForm({
    Key? key,
    required this.onSaved,
  }) : super(key: key);
  final void Function({
    required String type,
    required String name,
    required String description,
    required int prix,
  }) onSaved;

  @override
  _NewMenuRestaurentFormState createState() => _NewMenuRestaurentFormState();
}

class _NewMenuRestaurentFormState extends State<NewMenuRestaurentForm> {
  late String type;
  late String name;
  late String description;
  late int prix;
  List<String> typesMenuResto = [
    'PIZZAS',
    'TACOS',
    'SANDWICHS',
    'BURGERS',
    'SALADES',
    'HUMMERS & ROLLS',
    'BIOSSONS FRAICHES',
    'ENTRES CHAUCHED',
    'MILKSHAKE',
    'PLATS',
    'DESSERTS',
    'MENU ENFANTS',
    'BOISSONS CHAUDES',
    'PANINI',
    'POISSONS',
    'TAJINE',
    'TAILLES',
    'VIANDES',
    'SAUCES',
    'ENTRES FROIDES',
    'SUPPLEMENTS',
    'ITALIANO VERO',
    'OMELETTES',
    'VIANDES BLANCHES',
    'VIANDES ROUGES',
    'LES CLASSIQUES',
    'LES SPECIAUX',
    'PLATS CHAUDS',
    'SPINGS ROLLS',
    'MIX BOX',
    'BOISSONS',
    'RECETTES SPECIALES',
    'VIANDES',
    'EXTRAS',
    'COUSCOUS',
    'JUS',
    'COCKTAILS DE FRUITS',
    'SALADES DE FRUITS',
    'CHICKE\'N FRIES',
    'WRAP',
    'FORMULES',
    'A LA BRAISE',
    'P\'TITS +',
    'CALZONE',
    'HOTDOG',
    'DONUTS',
    'BROWNIES',
    'CHURROS',
    'PANCAKE',
    'CHOCOLAT FRUITS',
    'TIRAMISU',
    'CREPES',
    'GAUFRES',
    'CUISINE ORIENTALE',
    'FATAIRS TRADITIONNELES',
    'CUISINE OCCIDENTALE',
    'GRATINS'
  ];
  late final GlobalKey<FormState> _formKey;
  bool isButtonEnabled = true;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    typesMenuResto.sort((a, b) => a[0].compareTo(b[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(vertical: 1);
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            SignUpTitle(title: 'Informations menu'),
            SizedBox(height: 30),
            SignUpDivider(),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: padding,
                      child: CustomDropDown(
                        fillColor: Colors.white70,
                        title: 'Type',
                        hint: 'Type',
                        options: typesMenuResto,
                        validator: (String? value) {
                          if (value == null) {
                            return invalidWilayaError;
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          if (value == 'Choose type') {
                          } else {
                            type = value;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Name:",
                        hintText: "Name...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          name = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Description:",
                        hintText: "Description...",
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          description = value;
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: CustomTextForm(
                        fillColor: Colors.white70,
                        title: "Prix:",
                        hintText: "Prix...",
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (var value) {
                          prix = int.parse(value);
                        },
                        validator: (String? value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 20),
              child: Align(
                child: ButtomMedia(
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSaved(
                        name: name,
                        description: description,
                        prix: prix,
                        type: type,
                      );
                    }
                  },
                  color: Color(0xff5383EC),
                  text: 'Suivant',
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
