import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_bloc.dart';
import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/common_widgets/platform_alert_dialog.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';

class CarouselSliderTile extends StatefulWidget {
  const CarouselSliderTile({
    Key? key,
    required this.tuple,
    required this.carouselSliderBloc,
  }) : super(key: key);

  final CarouselSliderBloc carouselSliderBloc;
  final CarouselSlideModel tuple;
  @override
  _CarouselSliderTileState createState() => _CarouselSliderTileState();
}

class _CarouselSliderTileState extends State<CarouselSliderTile> {
  late bool isSaved;
  double? topPartHeight;

  Widget buildTopPart() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      topPartHeight = boxConstraints.maxHeight;
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 5.0,
              )
            ],
            color: Colors.red,
            borderRadius: BorderRadius.circular(60),
          ),
          child: ElevatedButton(
            onPressed: () async {
              final bool? isSure = await PlatformAlertDialog(
                title: 'Confirmer',
                content: 'es-tu sûr',
                cancelActionText: 'non',
                defaultActionText: 'oui',
              ).show(context);
              if (isSure == true) {
                widget.carouselSliderBloc.deleteCarouselSlider(widget.tuple);
                Fluttertoast.showToast(
                  msg: 'L\'image est supprime avec succès',
                  toastLength: Toast.LENGTH_LONG,
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
            ),
            child: Text('Supprimer'),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        width: SizeConfig.screenWidth,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.tuple.pictureUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: buildTopPart())),
          ],
        ),
      ),
    );
  }
}
