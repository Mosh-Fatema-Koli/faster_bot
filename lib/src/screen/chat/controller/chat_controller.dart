import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wow_chat_app/src/screen/chat/model/unread_chat_details_model.dart';
import 'package:wow_chat_app/src/screen/chat/model/unread_chat_details_model.dart';
import 'package:wow_chat_app/src/screen/tab/model/unread_chat_model.dart';
import 'package:wow_chat_app/src/service/helper/socket_helper.dart';

import '../../../service/api/api_checker.dart';
import '../../../service/api/api_client.dart';
import '../../../service/api/api_service.dart';
import '../../../service/helper/Prefs_helper.dart';
import '../../../service/utils/app_constent.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;


class ChatDController extends GetxController {
  TextEditingController textController = TextEditingController();

  // RxMap<DateTime, List<ChatDetailsModel>> timeGroupChat = <DateTime, List<ChatDetailsModel>>{}.obs;
  RxList<ChatDetailsModel> chatList = <ChatDetailsModel>[].obs;
  var isMassageEmpty = false.obs;
  var isLoading = true.obs;

  late Record audioRecorder;
  late AudioPlayer audioPlayer;
  RxString audioPath = "".obs;
  RxBool isVoiceRecording = false.obs;
  RxInt recordingTime = 0.obs; // Recording time in seconds
  Timer? timer;





  @override
  void onInit() {
    // TODO: implement onInit
    audioPlayer = AudioPlayer();
    audioRecorder = Record();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioRecorder.dispose();
    audioPlayer.dispose();
    timer?.cancel();
    super.dispose();
  }


  late ScrollController scrollController;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var totalPage = (-1);
  var currentPage = (-1);

  fastLoad(String id) async {
    page = 1;
    isFirstLoadRunning(true);
    var deviceToken = await PrefsHelper.getString(AppConstants.deviceId);
    var sessionToken = await PrefsHelper.getString(AppConstants.sessionId);
    var userId = await PrefsHelper.getString(AppConstants.userId);
    var headers = {
      'x-device': deviceToken,
      'x-user': userId,
      'x-session': sessionToken
    };
    // var headers = {
    //   'x-device': '651e63e09446654dcf1f0bc7',
    //   'x-user': '651e640e9446654dcf1f0bca',
    //   'x-session': '651e640e9446654dcf1f0bcc'
    // };

    Response response = await ApiClient.getData(
      "${ApiConstant.chatListApi}$id/$page/30",
      headers: headers,
    );
    if (response.statusCode == 200) {
      currentPage = response.body['data']['current_page'];
      totalPage = response.body['data']['total_pages'];
      var demoList = List<ChatDetailsModel>.from(response.body['data']['list']
          .map((x) => ChatDetailsModel.fromJson(x)));
      // timeGroupChat.clear();
      // groupMessageByDate(demoList, false);
      chatList.clear();
      chatList.value = demoList;
      chatList.refresh();
      // scrollToEnd();
      scrollTime();
    } else {
      ApiChecker.checkApi(response);
    }
    isFirstLoadRunning(false);
  }

  loadMore(String id) async {
    print("load more");
    if (isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false &&
        totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      var deviceToken = await PrefsHelper.getString(AppConstants.deviceId);
      var sessionToken = await PrefsHelper.getString(AppConstants.sessionId);
      var userId = await PrefsHelper.getString(AppConstants.userId);
      var headers = {
        'x-device': deviceToken,
        'x-user': userId,
        'x-session': sessionToken
      };
      // var headers = {
      //   'x-device': '651e63e09446654dcf1f0bc7',
      //   'x-user': '651e640e9446654dcf1f0bca',
      //   'x-session': '651e640e9446654dcf1f0bcc'
      // };

      Response response = await ApiClient.getData(
        "${ApiConstant.chatListApi}$id/$page/30",
        headers: headers,
      );
      currentPage = response.body['data']['current_page'];
      totalPage = response.body['data']['total_pages'];
      if (response.statusCode == 200) {
        var demoList = List<ChatDetailsModel>.from(response.body['data']['list']
            .map((x) => ChatDetailsModel.fromJson(x)));
        chatList.addAll(demoList);
        chatList.refresh();
        // groupMessageByDate(demoList, true);
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  // groupMessageByDate(List<ChatDetailsModel> chatList, bool loadmore) {
  //   chatList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  //   for (var message in chatList) {
  //     print("message : ${message.originalTimestamp!.year}");
  //     final date = DateTime(message.originalTimestamp!.year,
  //         message.originalTimestamp!.month, message.originalTimestamp!.day);
  //     print("=====> date :$date");
  //     timeGroupChat.putIfAbsent(date, () => []);
  //     if (loadmore) {
  //       timeGroupChat[date]?.insert(0, message);
  //       timeGroupChat.refresh();
  //     } else {
  //       timeGroupChat[date]?.add(message);
  //       timeGroupChat.refresh();
  //     }
  //   }
  // }

  var text = "";

  sendMessage(ListElement userData,) async {
    if (textController.text
        .trim()
        .isNotEmpty) {
      text = textController.text;
      ChatDetailsModel sendModel = ChatDetailsModel(
        sender: "bot",
        content: Content(kind: "text", data: DataModel(text: text,)),
        originalTimestamp: DateTime.now(),
      );
      chatList.add(sendModel);
      chatList.refresh();
      Map<String, dynamic> body = {
        "chat_thread_id": userData.id,
        "chat_id": userData.telegramUserId!.tgid,
        "text": text
      };
      textController.clear();
      isMassageEmpty.value = false;
      Response response =
      await ApiClient.postData(ApiConstant.sendMessage, json.encode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        chatList.value.remove(sendModel);
        ChatDetailsModel demoData =
        ChatDetailsModel.fromJson(response.body['data']['message']);

        print("===========>${demoData.content!.data!.text}");
        //   groupMessageByDate([demoData], false);

        // timeGroupChat.refresh();
        chatList.add(demoData);
        chatList.refresh();
        update();
        scrollToEnd(false);
        // getIndivisualChatbyId(false);
      }
    }
  }


  scrollToEnd(bool isPhoto) {
    if (isPhoto) {
      Timer(Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 100), curve: Curves.decelerate);
        }
      });
      // scrollController.jumpTo(
      //   scrollController.position.maxScrollExtent+150,
      // );
    } else {
      // scrollController.jumpTo(
      //   scrollController.position.maxScrollExtent+50,
      // );
      Timer(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 100), curve: Curves.decelerate);
        }
      });
    }
  }

  scrollTime() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }

  var uuid = Uuid();

  Future<void> pickImage(String threadId, String chatId) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = await xFileToFile(pickedFile);
      //  uploadPhoto(threadId, chatId, file);
      final fileStat = await file.stat();
      final fileSize = fileStat.size;

      if (fileSize > 10 * 1024 * 1024) {
        print("File Sized x : $fileSize");
        Get.snackbar("Error uploading image",
            "File size has exceeded the maximum size limit of 10 MB");
      } else {
        uploadImage(threadId, chatId, file);
      }
      //sendImageToApi(file.path);
      print("=======> Pick Image ${pickedFile.path}");
    } else {
      // User canceled the image picker.
    }
  }

  Future<File> xFileToFile(XFile xFile) async {
    // Get the path of the XFile.
    String filePath = xFile.path;
    // Create a File instance using the path.
    File file = File(filePath);

    return file;
  }


  uploadImage(String threadId, String chatId, File file) async {
    var localid = uuid.v4();
    var timeStamp = DateTime
        .now()
        .millisecondsSinceEpoch;


    ChatDetailsModel sendimageModel = ChatDetailsModel(
      sender: "Bot",
      content: Content(kind: "photo", data: DataModel(file: file.path)),
      originalTimestamp: DateTime.now(),
    );
    chatList.add(sendimageModel);
    chatList.refresh();


    var request = http.MultipartRequest('POST',
        Uri.parse('https://engine.fasterbot.net/api/public/photo/upload'));

    // request.fields.addAll({
    //   'pretext': '${threadId}_${localid}_$timeStamp'
    // });
    var mimeType = lookupMimeType(file.path);
    print(mimeType);
    request.fields['pretext'] = '${threadId}_${localid}_$timeStamp';
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        file.path,
      ),
    );
    http.StreamedResponse response = await request.send();
    var content = await response.stream.bytesToString();

    Response defaultData = Response(
        statusCode: response.statusCode, statusText: "", body: content);

    if (defaultData.statusCode == 200) {
      var demoData = json.decode(defaultData.body);
      print(demoData);
      // print(result['data']['photo']);
      var photoName = demoData['data']['photo_name'];
      var photo = demoData['data']['photo'];
      await imageSendMessage(
        threadId, chatId, photo, photoName, sendimageModel,);
    } else {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    }
  }

  Future<void> sendImageToApi(String imagePath) async {
    try {
      // Open the image file and read its bytes
      final imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();

      // Create a multipart request
      var request = http.MultipartRequest('POST',
          Uri.parse('https://engine.fasterbot.net/api/public/photo/upload'));
      request.fields['pretext'] = 'KoyiFariyad';
      // Add the image file as a part of the request
      request.files.add(
        http.MultipartFile.fromBytes(
          'photo', // Field name for the image in your API
          bytes,
          filename: 'image1.jpg', // Specify the filename
          //    contentType: MediaType('image', 'jpeg'), // Adjust the content type accordingly
        ),
      );
      // Send the request and await for the response
      final response = await request.send();

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print(await response.stream.bytesToString());
        print('Image upload failed with status code: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  imageSendMessage(String threadId, chatId, photo, photoName,
      sendimageModel) async {
    print(photo);
    Map<String, dynamic> body = {
      "chat_thread_id": threadId,
      "chat_id": chatId,
      "photo": "https://engine.fasterbot.net/images$photo",
      "new_photo": "https://engine.fasterbot.net/images$photo",
      "photo_name": photoName,
      //  "text": "Nice Post"
    };

    Response response = await ApiClient.postData(
        ApiConstant.chatPhotoSend, json.encode(body));
    if (response.statusCode == 200) {
      chatList.remove(sendimageModel);
      ChatDetailsModel demoData =
      ChatDetailsModel.fromJson(response.body['data']['message']);
      print("===========>${demoData.content!.data!.text}");

      chatList.add(demoData);
      chatList.refresh();
      //groupMessageByDate([demoData], false);
      textController.clear();

      //  timeGroupChat.refresh();
      update();
      scrollToEnd(true);
    }
  }

  receivedListen(String threadId) async {
    SocketApi.socket.on('APP::CHAT::NEW::$threadId', (data) {
      print("listen message send $data");
      var demo = data;
      ChatDetailsModel demoData = ChatDetailsModel.fromJson(
          demo['data']['chat']);

      print("===========>${demoData.content!.data!.text}");
      chatList.add(demoData);
      chatList.refresh();
      //  groupMessageByDate([demoData], false);
      textController.clear();
      //   timeGroupChat.refresh();
      update();
      scrollToEnd(true);
    });
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();
        isVoiceRecording.value = true;
        startTimer();


      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Timer to update recording time
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {

        recordingTime.value = timer.tick;

    });
  }

  void stopTimer() {
    timer?.cancel();
      recordingTime.value=0;
  }


  Future<void> deleteRecording() async {
    try {
      await audioRecorder.dispose();
      isVoiceRecording.value = false;
      stopTimer();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();
      audioPath.value = path!;
      stopTimer();
      isVoiceRecording.value = false;

      ChatDetailsModel sendVoiceModel = ChatDetailsModel(
        sender: "Bot",
        content: Content(kind: "voice", data: DataModel(file: path)),
        originalTimestamp: DateTime.now(),
      );
      chatList.add(sendVoiceModel);
      chatList.refresh();

    } catch (e) {
      print(e.toString());
    }
  }


    Future<void> playRecording() async {
      try {
        Source urlSource = UrlSource(audioPath.value);
        await audioPlayer.play(urlSource);
      } catch (e) {
        print(e.toString());
      }

  }





}