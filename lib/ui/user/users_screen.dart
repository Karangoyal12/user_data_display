import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_data_display/ui/user/widgets/user_details_screen.dart';
import 'package:user_data_display/utils/constants/sizes.dart';

import '../../controller/user_controller.dart';


class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final controller = Get.put(UserController());

  final searchController = TextEditingController();

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadUserData();
    });
  }


  /// Fetching user data
  Future<void> loadUserData() async {
    try {
      controller.isLoading.value = true; // Show loading initially
      if (controller.users != null) {
        controller.users!.clear();
      }
      controller.actualUsers?.value = (await controller.getUsers(context))!;
      if (controller.actualUsers != null && controller.actualUsers!.value.isNotEmpty) {
        controller.users?.value.addAll(controller.actualUsers!.value);
      }

      controller.isErrorOccur.value = false;
    } catch (e) {
      controller.isErrorOccur.value = true;
      // Optionally, log the error or show a message to the user
    } finally {
      controller.isLoading.value = false; // Hide loading after operation
      controller.users!.refresh();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// App bar
      appBar: AppBar(title: const Text("All Users"), centerTitle: false,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace),

            /// Search Functionality
            child: TextFormField(
              onChanged: (text) {
                if (controller.users != null && controller.actualUsers != null) {
                  controller.users!.value.clear();
                  if(text.isNotEmpty) {
                    for(int i = 0; i < controller.actualUsers!.value.length; i++) {
                      if (controller.actualUsers!.value[i].name!.toString().toLowerCase().contains(text.toLowerCase()) ) {
                        controller.users?.value.add(controller.actualUsers!.value[i]);
                      }
                    }
                  } else {
                    controller.users?.value.addAll(controller.actualUsers!.value);
                  }
                }
                controller.users!.refresh();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search),
                border:const OutlineInputBorder().copyWith(
                  borderRadius:BorderRadius.circular(14),
                  borderSide:const BorderSide(width: 1,color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(width: 1,color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(width: 1,color: Colors.black12),
                ),
              ),
            ),
          ),
          Expanded(child: Obx(()=> UserDataWidget(context))),
        ],
      ),
    );
  }



  Widget UserDataWidget(BuildContext context){

   /// Error handling
   if(controller.isErrorOccur.value == true){
     return SizedBox(
       width: double.infinity,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           if(controller.isLoading.value == false) ... [
           GestureDetector(
             onTap: () async {
               controller.isLoading.value = true;
               await loadUserData();
               controller.isLoading.value = false;
             },
             child: const Icon(
               Icons.refresh,
               color: Colors.grey,
               size: 48,
             ),
           ),] else ... [
             const CircularProgressIndicator()
           ],
           const SizedBox(height: 16),
           const Text(
             "Try again",
             textAlign: TextAlign.center,
             style: TextStyle(color: Colors.red, fontSize: 16),
           ),

         ],
       ),
     );
   }

   /// Loading
   else if(controller.users!.value.isEmpty){
     return const Center(child: CircularProgressIndicator());
   }

   /// Data on screen
   else{
     return RefreshIndicator(
       onRefresh: () async {
         await loadUserData();

       },
       child: ListView.builder(
         itemCount: controller.users?.value.length ?? 0,
         itemBuilder: (context, index) {
           return ListTile(
             onTap: () => Get.to(() => UserDetailsScreen(index: index)),
               leading: const Icon(Icons.person),
               title: Text(controller.users?.value[index].name ?? "Unknown User"),
               subtitle: Text(controller.users?.value[index].email ?? "Unknown Email"),
             trailing: const Icon(Icons.chevron_right),
             );
         },
       ),
     );
   }
  }
}
