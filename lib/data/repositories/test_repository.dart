import 'package:quiz/data/network/api_provider.dart';
import '../model/networ_respons_model/network_response.dart';

class TestRepository {
  Future<NetworkResponse> getTest({required String token}) async {
    return await ApiProvider.getData(token: token);
  }
}