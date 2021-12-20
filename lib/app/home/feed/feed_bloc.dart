import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/database.dart';

class FeedBloc {
  FeedBloc({
    required this.database,
    required this.currentUser,
  });
  final Database database;
  final User currentUser;

  Stream<List<CarouselSlideModel>> getCarouselSliders() {
    return database.streamCollection(
      path: 'carouselSlider',
      builder: (data, id) => CarouselSlideModel.fromMap(data, id),
      queryBuilder: (query) => query,
    );
  }
}
