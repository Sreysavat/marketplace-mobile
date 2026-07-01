import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.addresses.isEmpty) {
          return const Center(
            child: Text("No address found"),
          );
        }

        return RefreshIndicator(
          onRefresh: ()async{
            controller.fetchAddress();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(address.label ?? "Home"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address.city ?? ""),
                      Text(
                        "${address.addressLine1 ?? ""}, "
                            "${address.fullName ?? ""}, "
                            "${address.province ?? ""}",
                      ),
                      Text(
                        "${address.postalCode ?? ""}, ${address.country ?? ""}",
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      // Edit Address
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.ADD_ADDRESS);
        },
        child: Icon(Icons.add),),
    );
  }
}