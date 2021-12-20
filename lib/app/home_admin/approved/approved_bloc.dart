import 'dart:async';

import 'package:kw_express_pfe/app/models/restaurent.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';

class ApprovedBloc {
  ApprovedBloc({required this.database});

  final Database database;

  Stream<List<Restaurent>> getUnApporvedUsers() {
    final Stream<List<String>> unApprovedIdsStream = database.streamCollection(
        path: 'users',
        builder: (data, id) => id,
        queryBuilder: (query) => query.where('isApproved', isEqualTo: false));

    final Stream<List<Restaurent>> result = unApprovedIdsStream.transform(
      StreamTransformer.fromHandlers(
          handleData: (List<String> event, EventSink output) async {
        final List<Future<Restaurent?>> a = event.map((userId) async {
          return database.fetchDocument(
            path: APIPath.userDocument(userId),
            builder: (data, id) => Restaurent.fromMap(data, id),
          );
        }).toList();
        final List<Restaurent?> b = await Future.wait(a);
        final List<Restaurent> c = b.whereType<Restaurent>().toList();

        output.add(c);
      }),
    );
    return result;
  }

  Future<void> approveUser(User user) async {
    logger.info('approving this user ${user.id}');
    database.setData(
      path: 'users/${user.id}',
      data: {'isApproved': true, 'type': 2},
    );
  }
}
