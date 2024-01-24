// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:rova_23/utlis/constants/api_end_points.dart';
// import 'package:rova_23/utlis/helpers/app_exceptions.dart';

// class ApiModelNameHelper {
//   final String _baseUrl =
//       "https://localhost:7178/api/CropInfo/GetAllCrops?modelname=";

//   Future<dynamic> getModelName(String modelName) async {
//     var responseJson;

//     Map<String, String> headers = {
//       "Accept": "application/json",
//       //   "Authorization": token
//     };

//     try {
//       final response = await http.get(
//         Uri.parse(_baseUrl +
//             ApiEndPoints.tomatoInfoendpoints +
//             "?modelName=$modelName"),
//         headers: headers,
//       );
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       throw FetchDataException("connection_error");
//     }
//     return responseJson;
//   }

//   dynamic _returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = json.decode(response.body.toString());
//         return responseJson;
//       case 400:
//         throw BadRequestException(errorHandler(response));
//       case 401:
//       case 403:
//         throw UnauthorisedException(response.statusCode.toString());
//       case 422:
//       case 419:
//         throw FetchDataException(errorHandler(response));
//       default:
//         throw FetchDataException(response.statusCode.toString());
//       //'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }

//   String errorHandler(http.Response response) {
//     var responseJson = json.decode(response.body.toString());
//     final map = responseJson['errors'];
//     if (!["", null, false, 0].contains(map)) {
//       List errorsList = [];
//       for (var key in map.keys) {
//         errorsList.add(map[key]);
//       }
//       var errors = errorsList.expand((i) => i).toList();
//       return errors.join('\n');
//     } else {
//       return responseJson['message'];
//     }
//   }
// }
