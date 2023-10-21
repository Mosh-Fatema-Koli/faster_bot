
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';

class RecipientPage extends StatelessWidget {
  const RecipientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: BrandColors.colorButton,
        title: KText(text: "Broadcasting",color: BrandColors.backgroundColor,),
        actions: [

          PopupMenuButton<String>(
              onSelected: (value) {
                if(value == 'delete'){

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: BrandColors.colorButton,
                      content: Text('Group has deteted'),
                      duration: Duration(seconds: 3), // How long the snackbar is visible
                    ),
                  );

                }

              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text("Delete"),
                    value: 'delete',
                  ),
                ];
              }),
        ],
      ),
      body: Column(
        children: [
          Expanded(child:Container()),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: TextField(
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
                      icon: FaIcon(
                                FontAwesomeIcons.bullhorn,
                                size: 25.0, // Adjust the size as needed
                                color: BrandColors.greyColor, // Change the color if necessary
                                ),
                      onPressed: () {},
                    ),
                    suffixIcon: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.link),
                          onPressed: () async {
                            String _filePath = 'No file selected';

                            Future<void> _pickFile() async {
                              final result = await FilePicker.platform.pickFiles();

                              // if (result != null) {
                              //   setState(() {
                              //     _filePath = result.files.single.path!;
                              //   });
                              // }
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: ()  async{

                            final ImagePicker picker = ImagePicker();
                            // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            final List<XFile> medias = await picker.pickMultipleMedia();

                            int timestamp = new DateTime.now().millisecondsSinceEpoch;

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.send,color: BrandColors.colorButton,),
                          onPressed: () {},
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),

    );
  }
}
