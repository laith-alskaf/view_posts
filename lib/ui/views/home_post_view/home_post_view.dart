import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testofcourse/core/data/models/api/get_all_post.dart';
import 'package:testofcourse/core/data/repositories/get_all_post_repositiory.dart';
import 'package:testofcourse/core/enums/message_type.dart';
import 'package:testofcourse/ui/shared/custom_widget/custom_toast.dart';
import 'package:testofcourse/ui/shared/extension_sizebox.dart';
import 'package:testofcourse/ui/views/new_post/new_post_view.dart';
import 'package:testofcourse/ui/views/post_view/post_view.dart';

class HomePostView extends StatefulWidget {
  const HomePostView({Key? key}) : super(key: key);

  @override
  State<HomePostView> createState() => _HomePostViewState();
}

class _HomePostViewState extends State<HomePostView> {
  List<GetAllPost> creatPostList = [];

  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
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
            Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: size.width * 0.8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const NewPostView();
                          },
                        ));
                      },
                      child: SvgPicture.asset(
                        'images/create-note-svgrepo-com.svg',
                        height: 40,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: size.width / 5, bottom: 15),
                  child: Image.asset(
                    'images/background.png',
                    width: 200,
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: GetAllPostRepositiory().getAll(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  snapshot.data!.fold((l) {
                    CustomToast.showMessage(
                        size: size,
                        message: l,
                        messageType: MessageType.REJECTED);
                  }, (r) {
                    creatPostList.clear();
                    creatPostList.addAll(r);
                  });
                }
                return snapshot.data == null
                    ? SpinKitCircle(
                        color: Colors.green,
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: creatPostList.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return  PostView(creatPostList: creatPostList[index]);
                                        },
                                      ));
                                },
                                child: Container(
                                    width: size.width * 0.9,
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromRGBO(112, 112, 112, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Text(
                                          creatPostList[index].title ?? '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Color.fromRGBO(22, 177, 145, 1),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        10.ph,
                                        Text(
                                          creatPostList[index].body??'',maxLines: 3,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20,),
                                        )
                                      ],
                                    )),
                              ),
                            ],
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
