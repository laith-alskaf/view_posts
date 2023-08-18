import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testofcourse/core/data/models/api/get_all_image_post.dart';
import 'package:testofcourse/core/data/models/api/get_all_post.dart';
import 'package:testofcourse/core/data/repositories/delete_post_repositiory.dart';
import 'package:testofcourse/core/data/repositories/get_all_image_post_repositiory.dart';
import 'package:testofcourse/core/enums/message_type.dart';
import 'package:testofcourse/ui/shared/custom_widget/custom_toast.dart';
import 'package:testofcourse/ui/shared/extension_sizebox.dart';
import 'package:testofcourse/ui/views/home_post_view/home_post_view.dart';

class PostView extends StatefulWidget {
  GetAllPost creatPostList;

  PostView({Key? key, required this.creatPostList}) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<GetAllImagePost> getAllImagePost = [];
  bool islooding = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 35),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors:  [
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(47, 61, 74, 0),
              Color.fromRGBO(12, 181, 149, 0.34),
              Color.fromRGBO(12, 181, 149, 0.47),
              Color.fromRGBO(12, 181, 149, 0.47),
              Color.fromRGBO(12, 181, 149, 0.40),
            ],
          ),
        ),
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                // height: 200,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(112, 112, 112, 1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.7),
                      child: InkWell(
                          onTap: () {
                            DeletePostRepositiory()
                                .DeletePost(
                                    idPost: widget.creatPostList.id.toString())
                                .then((value) {
                              value.fold((l) {
                                setState(() {
                                  islooding = false;
                                });
                                CustomToast.showMessage(
                                    messageType: MessageType.REJECTED,
                                    size: size,
                                    message: l);
                              }, (r) {
                                Navigator.pop(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePostView();
                                  },
                                ));
                              });
                            });
                          },
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context, MaterialPageRoute(
                                  builder: (context) {
                                return const HomePostView();
                              }));
                            },
                            child: SvgPicture.asset(
                              'images/delete-svgrepo-com.svg',
                              height: 30,
                              color: Colors.red,
                            ),
                          )),
                    ),
                    Text(
                      widget.creatPostList.title ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(22, 177, 145, 1),
                      ),
                    ),
                    10.ph,
                    SingleChildScrollView(
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.creatPostList.body ?? '',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )
                  ],
                )),
            Text(
              'Album:',
              style: TextStyle(
                  color: Color.fromRGBO(22, 177, 145, 1), fontSize: 27),
            ),
            FutureBuilder(
              future: GetAllImagePostRepositiory()
                  .getAll(idOfPostImage: widget.creatPostList.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  snapshot.data!.fold((l) {
                    CustomToast.showMessage(
                        size: size,
                        message: l,
                        messageType: MessageType.REJECTED);
                  }, (r) {
                    getAllImagePost.clear();
                    getAllImagePost.addAll(r);
                  });
                }
                return snapshot.data == null
                    ? SpinKitCircle(
                        color: Colors.green,
                      )
                    : SizedBox(
                        // height: size.height * 0.5,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getAllImagePost.length,
                          addAutomaticKeepAlives: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    height: 200,
                                    width: size.width,
                                    fadeOutCurve: Curves.easeInOutSine,
                                    fit: BoxFit.cover,
                                    imageUrl: getAllImagePost[index]
                                        .thumbnailUrl
                                        .toString(),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                            color: Colors.green),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
