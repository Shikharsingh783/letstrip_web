import 'package:dio/dio.dart';
import 'package:letstrip/models/base_response.dart';
import 'package:letstrip/models/dummy_response_model.dart';
import 'package:letstrip/models/saved_itinerary.dart';
import 'package:letstrip/network/dio_client.dart';
import 'package:letstrip/network/environment.dart';
import 'package:letstrip/repositories/auth_repo.dart';

class ItineraryRepository {
  static final ItineraryRepository _instance = ItineraryRepository._internal();
  late final DioClient _dioClient;
  String baseUrl = Environment.itineraryBaseUrl;
  static const maxAttempts = 3;

  ItineraryRepository._internal() {
    _dioClient = DioClient();
  }

  factory ItineraryRepository() => _instance;

  Future<BaseResponse<DummyResponseModel>> getItinerary(data) async {
    var attempt = 1;
    Response response = await _dioClient.postRequest(
        endPoint: '${baseUrl}itinerary',
        requiresAuthorizationHeader: true,
        data: data);

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return BaseResponse.fromJson(
          response.data, (json) => DummyResponseModel.fromJson(json));
    } else {
      while (attempt <= maxAttempts) {
        attempt++;
        getItinerary(data);
      }
      throw BaseApiException("Max attempts reached", response.statusCode!);
    }
  }

  Future<BaseResponse<List<SavedItineraryModel>>> getAllItineraries() async {
    try {
      Response response = await _dioClient.getRequest(
          endPoint: '${baseUrl}itinerary', requiresAuthorizationHeader: true);

      if (response.statusCode == 200) {
        BaseResponse<List<SavedItineraryModel>> result =
            BaseResponse.fromListJson(
                response.data,
                (dynamic json) => (json as List<dynamic>)
                    .map((json) => SavedItineraryModel.fromJson(json))
                    .toList());
        return result;
      } else {
        throw BaseApiException(response.statusMessage!, response.statusCode!);
      }
    } catch (ex) {
      throw BaseApiException(ex.toString(), ex.hashCode);
    }
  }
}
