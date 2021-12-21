import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
}
