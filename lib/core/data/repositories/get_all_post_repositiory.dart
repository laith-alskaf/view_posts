import 'package:dartz/dartz.dart';
import 'package:testofcourse/core/data/models/api/get_all_post.dart';
import 'package:testofcourse/core/data/models/common_respons.dart';
import 'package:testofcourse/core/data/network/endpoints/creat_post_endpoint.dart';
import 'package:testofcourse/core/data/network/network_config.dart';
import 'package:testofcourse/core/enums/request_type.dart';
import 'package:testofcourse/core/utils/network_utils.dart';

class GetAllPostRepositiory {
  Future<Either<String, List<GetAllPost>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CreatPostEndPoint.cratePost,
        headers: NetworkConfig.getHeaders(needAuth: false,type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
        CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<GetAllPost>resultList=[];
          commonResponse.data!.forEach(
                (element)
            { resultList.add(GetAllPost.fromJson(element));
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