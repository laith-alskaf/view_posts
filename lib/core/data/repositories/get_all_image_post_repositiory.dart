import 'package:dartz/dartz.dart';
import 'package:testofcourse/core/data/models/api/get_all_image_post.dart';
import 'package:testofcourse/core/data/models/api/get_all_post.dart';
import 'package:testofcourse/core/data/models/common_respons.dart';
import 'package:testofcourse/core/data/network/endpoints/creat_post_endpoint.dart';
import 'package:testofcourse/core/data/network/endpoints/get_all_image_post.dart';
import 'package:testofcourse/core/data/network/network_config.dart';
import 'package:testofcourse/core/enums/request_type.dart';
import 'package:testofcourse/core/utils/network_utils.dart';

class GetAllImagePostRepositiory {
  Future<Either<String, List<GetAllImagePost>>> getAll({required String idOfPostImage}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: '/albums/'+idOfPostImage+GetAllImagePostEndPoint.getAllImagePost,
        headers: NetworkConfig.getHeaders(needAuth: false,type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
        CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<GetAllImagePost>resultList=[];
          commonResponse.data!.forEach(
                (element)
            { resultList.add(GetAllImagePost.fromJson(element));
            },
          );
          return Right(resultList);}
        else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}