import 'package:kw_express_pfe/app/models/order.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';

class CartBloc {
  CartBloc({
    required this.database,
    required this.currentUser,
  });
  final Database database;
  final User currentUser;

  Future<void> saveOrder(Order order) async {
    await database.setData(
      path: APIPath.orderDocument(order.id),
      data: order.toMap(),
    );
  }
}
