

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/chat/controller/camera_controller.dart';
import 'package:wow_chat_app/src/screen/chat/controller/chat_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';

class ImagePage extends StatelessWidget {
  ImagePage({super.key});


//  String? imagePath = Get.arguments ;
  final ImageController controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {

    final imagePath = Get.arguments as String;


    // Retrieve the image path
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(  backgroundColor: Colors.black )),

     body: Padding(
       padding: const EdgeInsets.all(10),
       child: Column(
         children: [

          Expanded(child: Stack(
            children: [
              Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(imagePath),width: Get.width,fit: BoxFit.cover,height: Get.height,)), // Display the image
              ),
              Positioned(
                  right: 20,
                  top: 20,
                  child: IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Icon(Icons.cancel,size: 50,),
                  ))
            ],
          ),),
           Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
             ),
             child: Container(
                 alignment: Alignment.bottomCenter,
                 child:TextField(

                   controller: controller.textController,
                   maxLines: 4,
                   minLines: 1,
                   decoration: InputDecoration(
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(50),
                         borderSide: BorderSide(color: Colors.white, width: 0.0),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(50),
                         borderSide: BorderSide(color: Colors.white, width: 0.0),
                       ),
                       hintText: "Text message",
                       prefixIcon: IconButton(
                         icon: Icon(Icons.emoji_emotions_outlined),
                         onPressed: () {},
                       ),
                       suffixIcon: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.spaceBetween, // added line
                         mainAxisSize: MainAxisSize.min,
                         children: [

                           IconButton(
                             icon: const Icon(Icons.send, color: BrandColors.colorButton),
                             onPressed: () {
                             controller.sendImage();
                             },
                           )






                         ],
                       )),
                 )



             ),
           )



         ],
       ),
     ),

    );
  }
}
