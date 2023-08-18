import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:testofcourse/core/data/models/api/creat_post.dart';
import 'package:testofcourse/core/data/models/common_respons.dart';
import 'package:testofcourse/core/data/network/endpoints/creat_post_endpoint.dart';
import 'package:testofcourse/core/data/network/network_config.dart';
import 'package:testofcourse/core/enums/request_type.dart';
import 'package:testofcourse/core/utils/network_utils.dart';

class CreatPostRepositiory {
  Future<Either<String, CreatPostModel>> CreatPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: CreatPostEndPoint.cratePost,
          headers: NetworkConfig.getHeaders(needAuth: false, type: RequestType.POST),
          body: {
            'title': title,
            'body': body,
            'userId': userId
          }).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          return Right(CreatPostModel.fromJson(
            commonResponse.data ?? {},
          ));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  // Future<Either<String, bool>> register({
  //   required String email,
  //   required String password,
  //   required String lastname,
  //   required String firstname,
  //   required int age,
  //   required String photo,
  // }) async {
  //   try {
  //     return NetworkUtil.sendMultipartRequest(
  //       type: RequestType.POST,
  //       url: UserEndPoints.rigester,
  //       fields: {
  //         'Email': email,
  //         'FirstName': firstname,
  //         'LastName': lastname,
  //         'Password': password,
  //         'Age': age.toString(),
  //       },
  //       files: {"Photo": photo},
  //       headers: NetworkConfig.getHeaders(
  //           needAuth: false,
  //           extraHeaders: {
  //             "Host": "training.owner-tech.com",
  //             "Content-Type":
  //                 "multipart/form-data; boundary=--------------------------5014115597297111058551",
  //             "Content-Length": "82554"
  //           },
  //           type: RequestType.MULTIPART),
  //     ).then((response) {
  //       CommonResponse<Map<String, dynamic>> commonResponse =
  //           CommonResponse.fromJson(response);
  //       if (commonResponse.getStatus) {
  //         return Right(commonResponse.getStatus);
  //       } else {
  //         return Left(commonResponse.message ?? ''); //رسالة الخطأ
  //       }
  //     });
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
