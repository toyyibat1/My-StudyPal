import 'package:data_connection_checker/data_connection_checker.dart';

import '../../core/failure.dart';
import 'data_connection_service.dart';

class DataConnectionCheckerService extends DataConnectionService {
  @override
  Future<void> checkConnection() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (!result) throw Failure('No Internet Connection');
  }
}
