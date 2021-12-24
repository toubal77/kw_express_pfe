import 'package:kw_express_pfe/app/models/carousel_slide.dart';
import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/types_menu.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
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

  Stream<List<Restaurent>> getAllResto() {
    return database.streamCollection(
      path: APIPath.usersCollection(),
      builder: (data, documentId) => Restaurent.fromMap(data, documentId),
      queryBuilder: (query) => query.where(
        'type',
        isEqualTo: 2,
      ),
    );
  }

  Stream<List<MenuRestaurent>> getMenuResto(String id) {
    return database.streamCollection(
      path: APIPath.menuRestoCollection(id),
      builder: (data, documentId) => MenuRestaurent.fromMap(data, documentId),
    );
  }

  Stream<List<TypeMenu>> getTypesMenu(String id) {
    return database.streamCollection(
      path: APIPath.typesMenuCollection(id),
      builder: (data, documentId) => TypeMenu.fromMap(data, documentId),
    );
  }
}
