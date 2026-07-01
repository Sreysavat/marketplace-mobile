import 'package:get/get.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';
import 'package:marketplace_app/app/sevices/storage_service.dart';

class DependencyInject {
  static void init(){
    Get.put(ApiProvider(), permanent: true);
    Get.put(StorageService(), permanent: true);
  }
}