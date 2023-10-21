
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/block/controller/block_controller.dart';
import 'package:wow_chat_app/src/screen/tab/model/chat_model.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class BlockPage extends StatelessWidget {
  BlockPage({super.key});

  final BlockController _controller = Get.put(BlockController());

  @override
  Widget build(BuildContext context) {
    print(_controller.allBlockList.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.colorButton,
        title: KText(text: "Block ",color: BrandColors.backgroundColor,fontSize: 14.sp,),
      ),
      body: Obx(() =>  _controller.isLoading.value ? Center(child: CircularProgressIndicator(color: BrandColors.colorButton,)): _controller.allBlockList.isEmpty?Center(child: KText(text: "No Data Available",),) :ListView.builder(
          itemCount: _controller.allBlockList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) =>  Column(
            children: [

              ListTile(

                leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    backgroundImage:NetworkImage("https://engine.fasterbot.net/images/${_controller.allBlockList[index].telegramUserId!.photo}")
                ),
                title: KText(text: "${_controller.allBlockList[index].telegramUserId!.firstName} ${_controller.allBlockList[index].telegramUserId!.lastName}",fontWeight: FontWeight.bold,fontSize: 14.sp,),
                trailing: GestureDetector(
                  onTap: ()async{
                    var result= await _controller.addUnBlock(_controller.allBlockList[index].id.toString(), _controller.allBlockList[index].telegramUserId!.firstName.toString(), _controller.allBlockList[index].telegramUserId!.lastName.toString());
                      if(result.runtimeType != int){
                        _controller.allBlockList.removeAt(index);
                      }

                  },
                    child: KText(text: "Unblock",color: BrandColors.colorButton,fontWeight: FontWeight.bold,)),
              ),
            ],
          )),)

    );
  }
}
