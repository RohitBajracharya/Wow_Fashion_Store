import 'package:admin_side/src/common%20widgets/appbar_widget.dart';
import 'package:admin_side/src/common%20widgets/drawer_widget.dart';
import 'package:admin_side/src/data/controller/theme_controller.dart';
import 'package:admin_side/src/data/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common widgets/setting_widget.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(pageName: "Customers"),
      drawer: const DrawerWidget(),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          tableHeader(),
          const SizedBox(height: 10),
          tableData(
            Customer(
              id: "123",
              profileImage: "assets/images/profile/pp1.jpg",
              fullName: "Rohit Bajracharya",
              address: "Dallu, Kathmamdu",
              phoneNumber: "9869682179",
              email: "rohitbajra@gmail.com",
            ),
          ),
        ],
      ),
    );
  }

  Widget tableHeader() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 75,
              child: Text(
                "Id",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Profile Image",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                "Full Name",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Address",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                "Phone Number",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                "Email Address",
                style: themeController.getTextTheme().bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Center(
                child: Text(
                  "Action",
                  style: themeController.getTextTheme().bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableData(Customer customer) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 75,
              child: Text(
                customer.id.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(
                  image: AssetImage(
                    customer.profileImage.toString(),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                customer.fullName.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                customer.address.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                customer.phoneNumber.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                customer.email.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            //setting icon
            const SizedBox(
              width: 100,
              child: SettingWidget(icon: Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
