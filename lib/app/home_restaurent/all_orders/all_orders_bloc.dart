import 'package:kw_express_pfe/app/models/order.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';

class AllOrdersBloc {
  AllOrdersBloc({
    required this.database,
    required this.currentUser,
  });
  final Database database;
  final User currentUser;

  Stream<List<Order>> getMyOrder() {
    return database.streamCollection(
      path: APIPath.orderCollection(),
      builder: (data, documentId) => Order.fromMap(data, documentId),
      queryBuilder: (query) => query.where(
        'idResto',
        isEqualTo: currentUser.id,
      ),
    );
  }

  Future<void> changeStatus(Order order, String status) {
    return database.updateData(
      path: APIPath.orderDocument(order.id),
      data: {
        'status': status,
      },
    );
  }
}
