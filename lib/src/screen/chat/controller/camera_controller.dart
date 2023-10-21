import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wow_chat_app/src/screen/chat/chat_detalis.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class ImageController extends GetxController {

  TextEditingController textController = TextEditingController();

  RxString imagePath = ''.obs;
  RxString chatThread = ''.obs;
  RxString chatId = ''.obs;


  var uuid = Uuid();
  Future<void> pickImage(String chat_thread_id,String chat_id ) async {
    final ImagePicker picker = ImagePicker();
    print(chat_thread_id);
    print(chat_id);
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {

      File file = await xFileToFile(image);
      imagePath.value = image.path;
      chatThread.value =chat_thread_id.toString();
      chatId.value = chat_id.toString();
      print(imagePath);
      Get.toNamed(imagesent, arguments: image.path);


    }
  }
  Future<File> xFileToFile(XFile xFile) async {
    // Get the path of the XFile.
    String filePath = xFile.path;

    // Create a File instance using the path.
    File file = File(filePath);

    return file;
  }




  Future<void> sendImage() async {


    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://engine.fasterbot.net/api/public/photo/upload'),
      );

      // Add the 'pretext' field
      request.fields['pretext'] = 'KoyiFariyad';

      // Attach the image file
      request.files.add(
        await http.MultipartFile.fromPath('photo', 'photo${imagePath.value}'));


      http.StreamedResponse response = await request.send();
      var result= jsonDecode(await response.stream.bytesToString());



      if (response.statusCode == 200) {
        Map<String, dynamic> chatData = {
          "chat_thread_id": chatThread.value,
          "chat_id": chatId.value,
          "photo": result['data']['photo'],
          "photo_name": result['data']['photo_name'],
          "text": textController.text,
        };

        // Send chat data with the image
        Response response1 = await ApiClient.postData("chat/photo/send", json.encode(chatData),);

            if (response1.statusCode == 200) {
              Get.to(ChatDtlsPage());
            } else {
              // Handle failure for sending chat data
            }
      } else {
        // Image uploaded successfully, prepare chat data

        print(response.reasonPhrase);
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print("Error: $e");
    }
  }





}