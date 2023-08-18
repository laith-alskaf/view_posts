import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:testofcourse/core/data/models/api/creat_post.dart';
import 'package:testofcourse/core/data/models/common_respons.dart';
import 'package:testofcourse/core/data/network/endpoints/creat_post_endpoint.dart';
import 'package:testofcourse/core/data/network/endpoints/delete_post_endpoint.dart';
import 'package:testofcourse/core/data/network/network_config.dart';
import 'package:testofcourse/core/enums/request_type.dart';
import 'package:testofcourse/core/utils/network_utils.dart';

class DeletePostRepositiory {
  Future<Either<String,dynamic>> DeletePost({required String idPost}) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.DELETE,
          url: DeletePostEndPoint.deletePost+idPost,
          headers: NetworkConfig.getHeaders(needAuth: false, type: RequestType.DELETE),
          ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          return Right(commonResponse.data??'');
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

}
