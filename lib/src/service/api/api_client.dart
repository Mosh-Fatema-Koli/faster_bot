class ApiConstant{

  static String appBaseUrl= "https://engine.fasterbot.net/api/";
  static String deviceRegister= "auth/device/register";
  static String googleApi= "auth/google/login";
  static String logoutApi= "auth/logout";
  static String tenantApi= "/tenant/create";
  static String sendMessage="chat/text/send";
  static String unAnsweredChatThreadListApi="chat/thread/list/unanswered/";
  static String unreadChatThreadListApi="chat/thread/list/unread/";
  static String allChatThreadListApi="chat/thread/list/all/";
  static String chatListApi="chat/list/";
  static String uploadChatPhoto="public/photo/upload";
  static String chatPhotoSend="/chat/photo/send";


  static String profileApi= "user/details/";
  static String tanenDetialsApi= "tenant/details/";

 // static String deleteProfileApi="delete/user";

  static String updateDefaultMassage= "tenant/update/message/";               //post
  static String addBlocklistApi ="chat/thread/status/update/block/";          //post
  static String addUnBlocklistApi ="chat/thread/status/update/unblock/";      //post
  static String getBlocklistApi ="tenant/blocked/list/";                      //post
  static String labelAddApi ="chat/thread/label/update/";                     //post





}