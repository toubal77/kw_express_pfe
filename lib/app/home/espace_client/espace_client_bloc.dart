import 'package:kw_express_pfe/app/models/bug.dart';
import 'package:kw_express_pfe/app/models/new_resto.dart';
import 'package:kw_express_pfe/app/models/user.dart';
import 'package:kw_express_pfe/services/api_path.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:uuid/uuid.dart';

class EspaceClientBloc {
  EspaceClientBloc({
    required this.database,
    required this.currentUser,
  });
  final Database database;
  final User currentUser;

  final Uuid uuid = Uuid();
  Future<void> sendBugInfo(Bug bug) async {
    await database.setData(
      path: APIPath.bugDocument(uuid.v4()),
      data: bug.toMap(),
      merge: false,
    );
  }

  Future<void> senNewRestoInfo(NewResto newResto) async {
    await database.setData(
      path: APIPath.newRestoDocument(uuid.v4()),
      data: newResto.toMap(),
      merge: false,
    );
  }
}
