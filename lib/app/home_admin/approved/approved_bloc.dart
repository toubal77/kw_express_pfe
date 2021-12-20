import 'dart:async';

import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';

class ApprovedBloc {
  ApprovedBloc({required this.database});

  final Database database;

  Stream<List<User>> getUnApporvedUsers() {
    final Stream<List<String>> unApprovedIdsStream = database.streamCollection(
        path: 'users',
        builder: (data, id) => id,
        queryBuilder: (query) => query.where('isApproved', isEqualTo: false));

    final Stream<List<User>> result = unApprovedIdsStream.transform(
      StreamTransformer.fromHandlers(
          handleData: (List<String> event, EventSink output) async {
        final List<Future<User?>> a = event.map((userId) async {
          return database.fetchDocument(
            path: APIPath.userDocument(userId),
            builder: (data, id) => User.fromMap2(data, id),
          );
        }).toList();
        final List<User?> b = await Future.wait(a);
        final List<User> c = b.whereType<User>().toList();

        output.add(c);
      }),
    );
    return result;
  }

  Future<void> approveUser(User user) async {
    logger.info('approving this user ${user.id}');
    database.setData(
      path: 'users/${user.id}',
      data: {'isApproved': true},
    );
  }
}
