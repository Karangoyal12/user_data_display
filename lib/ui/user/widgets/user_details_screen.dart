import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_data_display/common/widgets/a_section_heading.dart';
import 'package:user_data_display/ui/user/widgets/user_menu.dart';
import 'package:user_data_display/utils/constants/sizes.dart';

import '../../../controller/user_controller.dart';

class UserDetailsScreen extends StatelessWidget {
  final index;
  UserDetailsScreen({super.key, required this.index});
  final controller = Get.put(UserController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.users?.value[index].name ?? ""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Heading profile info
                const ASectionHeading(title: "Profile Information"),
                const SizedBox(height: ASizes.spaceBtwItems),
                
                UserMenu(title: 'Name ' , value: controller.users?.value[index].name),
                UserMenu(title: 'Username ', value: controller.users?.value[index].name),

                const SizedBox(height: ASizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: ASizes.spaceBtwItems),

                /// Heading Personal info
                const ASectionHeading(title: 'Personal Details'),
                const SizedBox(height: ASizes.spaceBtwItems),

                UserMenu(title: "E-mail ",value: controller.users?.value[index].email),
                UserMenu(title: 'Phone ', value: controller.users?.value[index].phone),
                UserMenu(title: 'Website ', value: controller.users?.value[index].website),

                const SizedBox(height: ASizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: ASizes.spaceBtwItems),

                /// Address
                const ASectionHeading(title: 'Address'),
                const SizedBox(height: ASizes.spaceBtwItems),

                UserMenu(title: 'Street ', value: controller.users?.value[index].address?.street,),
                UserMenu(title: 'Suit ', value: controller.users?.value[index].address?.suite,),
                UserMenu(title: 'City ', value: controller.users?.value[index].address?.city,),
                UserMenu(title: 'Zipcode ', value: controller.users?.value[index].address?.zipcode,),
                UserMenu(title: 'Latitude ', value: controller.users?.value[index].address?.geo?.lat),
                UserMenu(title: 'Longitude ', value: controller.users?.value[index].address?.geo?.lng,),

                const SizedBox(height: ASizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: ASizes.spaceBtwItems),

                /// Company details
                const ASectionHeading(title: 'Company Details'),
                const SizedBox(height: ASizes.spaceBtwItems),

                UserMenu(title: 'Name ',value: controller.users?.value[index].company?.name),
                UserMenu(title: 'CatchPhrase ',value: controller.users?.value[index].company?.catchPhrase),
                UserMenu(title: 'BS', value: controller.users?.value[index].company?.bs),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
