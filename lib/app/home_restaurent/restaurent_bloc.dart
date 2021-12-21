import 'package:kw_express_pfe/app/models/menu_restaurent.dart';
import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:uuid/uuid.dart';

class RestaurentBloc {
  RestaurentBloc({
    required this.database,
    required this.currentUser,
  });

  final Database database;
  final User currentUser;
  final Uuid uuid = Uuid();

  Stream<Restaurent?> getMyResto() {
    return database.streamDocument(
      path: APIPath.userDocument(currentUser.id),
      builder: (data, documentId) => Restaurent.fromMap(data, documentId),
    );
  }

  Stream<List<MenuRestaurent>> getMenuResto() {
    return database.streamCollection(
      path: APIPath.menuRestoCollection(currentUser.id),
      builder: (data, documentId) => MenuRestaurent.fromMap(data, documentId),
    );
  }

  Future<void> sendMenuRestoInfo(MenuRestaurent menuResto) async {
    final Uuid uuid = Uuid();
    String menuRestoId = uuid.v4();
    await database.setData(
      path: APIPath.menuRestoDocument(currentUser.id, menuRestoId),
      data: menuResto.toMap(),
      merge: false,
    );
  }
}
