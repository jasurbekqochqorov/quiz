import 'package:quiz/data/model/test_model/test_model.dart';
import 'package:quiz/data/network/api_provider.dart';
import '../model/networ_respons_model/network_response.dart';

class TestRepository {
  Future<NetworkResponse> getTest({required int subjectId}) async {
    return await ApiProvider.getData(id: subjectId);
  }
  Future<NetworkResponse> getRating() async {
    return await ApiProvider.getRating();
  }
  Future<NetworkResponse> getQuestion({required String token,required int id}) async {
    return await ApiProvider.getQuestion(token: token,id: id);
  }
  Future<NetworkResponse> getResult({required String token,required int id}) async {
    return await ApiProvider.getResult(token: token,id: id);
  }

  Future<NetworkResponse> postResult({required List<Map<String,dynamic>> answers,required int id}) async {
    return await ApiProvider.postResult(id: id,answers: answers
    );
  }

  Future<NetworkResponse> postPayment({required int summa}) async {
    return await ApiProvider.postPayment(summa: summa);
  }
}