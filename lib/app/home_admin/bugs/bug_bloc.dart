import 'package:kw_express_pfe/app/models/bug.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';

class BugBloc {
  BugBloc({
    required this.database,
    required this.currentUser,
  });
  final Database database;
  final User currentUser;

  Stream<List<Bug>> getAllRect() {
    return database.streamCollection(
      path: APIPath.bugCollection(),
      builder: (data, documentId) => Bug.fromMap(data, documentId),
    );
  }

  Future removeBug(String id) {
    return database.deleteDocument(path: APIPath.bugDocument(id));
  }
}
