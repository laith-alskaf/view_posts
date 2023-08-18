import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testofcourse/core/data/repositories/create_post_repositiory.dart';
import 'package:testofcourse/core/enums/message_type.dart';
import 'package:testofcourse/ui/shared/custom_widget/custom_buttom.dart';
import 'package:testofcourse/ui/shared/custom_widget/custom_text_form_field.dart';
import 'package:testofcourse/ui/shared/custom_widget/custom_toast.dart';
import 'package:testofcourse/ui/shared/extension_sizebox.dart';
import 'package:testofcourse/ui/views/home_post_view/home_post_view.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}


class _NewPostViewState extends State<NewPostView> {
  TextEditingController body = TextEditingController();
  TextEditingController title = TextEditingController();
  bool islooding = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
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
          Center(
            child: Image.asset(
              'images/background.png',
              width: 200,
            ),
          ),
          30.ph,
          Text(
            'Add new post',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          10.ph,
          Container(
            height: 102,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: TextFormFieldSIgnUP(
              hintText: 'Title',
              controller:title ,
            ),
          ),
          Container(
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(112, 112, 112, 1),
                  )),
              child: TextFormFieldSIgnUP(
                hintText: 'Body',
                controller: body,
              )
            // Text('Body',style: TextStyle(fontSize: 30,color: Color.fromRGBO(0, 0, 0, 0.2)),) ,
          ),
          islooding
              ? SpinKitCircle(
            color: Colors.green,
            size: 35,
          ) : CustomButton(
            text: "Save",
            backgroundColor: Color.fromRGBO(48, 64, 77, 1),
            onPressed: () {
              setState(() {
                islooding = true;
              });
              CreatPostRepositiory()
                  .CreatPost(
                title: title.text,
                body: body.text,
                userId:1,
              ).then((value) {
                value.fold((l) {
                  setState(() {
                    islooding = false;
                  });

                  CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      size: size,
                      message: l);
                }, (r) {
                  Navigator.pop(context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePostView();
                        },
                      ));
                });
              });
            },
          )
        ],
      )
    ),
    ));



  }
}
