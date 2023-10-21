
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:http/http.dart' as http;


class ImageViewPage extends StatelessWidget {
  String images;
  ImageViewPage({Key? key,required this.images}) : super(key: key);

  Future<void> _saveImageToGallery() async {
      String url=images.toString().startsWith("https://")? images:"https://engine.fasterbot.net/images$images";


    try {
      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final result = await ImageGallerySaver.saveImage(bytes);
        if (result != null && result.isNotEmpty) {
              Get.snackbar("Image saved", "",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
        } else {
          print("Failed to save image to gallery");
        }
      } else {
        print("Failed to download image");
      }
    } catch (e) {
      print("Error saving image to gallery: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.backgroundColor,
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: BrandColors.colorButton ,
        titleSpacing: 0.0,
        actions: [
          IconButton(onPressed: (){ _saveImageToGallery();}, icon: Icon(Icons.save_alt,size: 25,)),

        ],
      ),
      body: Container(
        color: BrandColors.backgroundColor,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(5),
              child: Center(child: CachedNetworkImage(
                imageUrl:images.toString().startsWith("https://")? "$images":"https://engine.fasterbot.net/images$images",
                imageBuilder: (context, imageProvider) =>
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                      ],
                    ),
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                    // Shimmer.fromColors(
                    //   baseColor: Colors.grey.withOpacity(0.2),
                    //   highlightColor:
                    //   Colors.grey.withOpacity(0.25),
                    //   child: Container(
                    //     height: 150.h,
                    //     width: 150.w,
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey.shade300,
                    //         borderRadius:
                    //         BorderRadius.circular(10)),
                    //   ),
                    // ),
                errorWidget: (context, url, error) =>
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            BorderRadius.circular(
                                10)),
                        child: const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ))),
              ),),
            )),

          ],
        ),
      ),
    );
  }
}
