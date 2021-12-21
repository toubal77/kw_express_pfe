import 'package:flutter/material.dart';
import 'package:kw_express_pfe/app/home/feed/widget/build_resto.dart';
import 'package:kw_express_pfe/app/home/feed/carousel_slider/carousel.dart';
import 'package:kw_express_pfe/app/home/feed/feed_bloc.dart';
import 'package:kw_express_pfe/app/home_admin/carousel_slider/carousel_slider_bloc.dart';
import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/common_widgets/empty_content.dart';
import 'package:kw_express_pfe/common_widgets/size_config.dart';
import 'package:kw_express_pfe/constants/app_colors.dart';
import 'package:kw_express_pfe/services/auth.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late FeedBloc bloc;
  late Stream<List<CarouselSlideModel>> carouselSliderStream;
  late Stream<List<Restaurent>> allRestaurent;
  late CarouselSliderBloc carouselSliderBloc;
  late bool isLoadingNextMessages;

  @override
  void initState() {
    isLoadingNextMessages = false;
    bloc = FeedBloc(
      currentUser: context.read<User>(),
      database: context.read<Database>(),
    );
    allRestaurent = bloc.getAllResto();
    carouselSliderBloc = CarouselSliderBloc(
      currentUser: context.read<Auth>(),
      database: context.read<Database>(),
    );
    carouselSliderStream = carouselSliderBloc.getCarouselSliders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Carousel(
              carouselSliderStream: carouselSliderStream,
              isLoadingNextMessages: isLoadingNextMessages,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.only(top: 7, left: 16, right: 16, bottom: 5),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Restaurent?>>(
                stream: allRestaurent,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final List<Restaurent?> typeMenu = snapshot.data!;
                    return ListView.builder(
                      itemCount: typeMenu.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CardBuildRestaurent(
                          res: typeMenu[index],
                          isLoading: false,
                        );
                      },
                    );
                  } else if (!(snapshot.hasData && snapshot.data != null)) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EmptyContent(
                        title: 'Aucune Données',
                        message: '',
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return EmptyContent(
                      title: "Quelque chose s'est mal passé",
                      message:
                          "Impossible de charger les éléments pour le moment",
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
