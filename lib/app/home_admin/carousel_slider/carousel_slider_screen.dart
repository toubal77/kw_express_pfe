import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home_admin/admin_logout.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/add_carousel_slider.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_bloc.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_tile.dart';

import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';
import 'package:provider/provider.dart';

class CarsouselSliderScreen extends StatefulWidget {
  const CarsouselSliderScreen({Key? key}) : super(key: key);

  @override
  _CarsouselSliderScreenState createState() => _CarsouselSliderScreenState();
}

class _CarsouselSliderScreenState extends State<CarsouselSliderScreen> {
  late Stream<List<CarouselSlideModel>> carouselSlider;
  late final CarouselSliderBloc carouselSliderBloc;
  @override
  void initState() {
    final Auth auth = context.read<Auth>();
    final Database database = context.read<Database>();
    carouselSliderBloc = CarouselSliderBloc(
      database: database,
      currentUser: auth,
    );
    carouselSlider = carouselSliderBloc.getCarouselSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: StreamBuilder<List<CarouselSlideModel>>(
        stream: carouselSlider,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              actions: [AdminLogout()],
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.add_business,
                    size: 25,
                    color: iconBackgroundColor,
                  ),
                  color: darkBlue,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddCarouselSlider();
                    }));
                  },
                ),
              ),
              iconTheme: IconThemeData(color: darkBlue),
              title: Text(
                'Carousel Slider',
                style: TextStyle(
                  color: iconBackgroundColor,
                ),
              ),
            ),
            body: buildBody(snapshot),
          );
        },
      ),
    );
  }

  Widget buildBody(AsyncSnapshot<List<CarouselSlideModel>> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final List<CarouselSlideModel> items = snapshot.data!;

      if (items.isNotEmpty) {
        final List<Widget> list = [];

        for (int i = 0; i < items.length; i++) {
          final temp = CarouselSliderTile(
            tuple: items[i],
            carouselSliderBloc: carouselSliderBloc,
          );
          list.add(temp);
        }

        return SingleChildScrollView(child: Column(children: list));
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: EmptyContent(
            title: '',
            message: '',
          ),
        );
      }
    } else if (snapshot.hasError) {
      logger.severe(snapshot.error);
      return EmptyContent(
        title: "Quelque chose s'est mal passé",
        message: "Impossible de charger les éléments pour le moment",
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
