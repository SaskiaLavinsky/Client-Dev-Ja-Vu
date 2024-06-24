import 'package:client_dev_ja_vu/controller/home_controller.dart';
import 'package:client_dev_ja_vu/pages/product_description_page.dart';
import 'package:client_dev_ja_vu/widgets/drop_down_btn.dart';
import 'package:client_dev_ja_vu/widgets/multi_select_drop_down.dart';
import 'package:client_dev_ja_vu/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 148, 45, 38),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ctrl.productCategories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error')),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: DropDownBtn(
                    items: ['Low to High', 'High to Low'],
                    selectedItemText: 'Sort',
                    onSelected: (selected) {
                      ctrl.sortByPrice(ascending: selected == 'Low to High');
                    },
                  ),
                ),
                Flexible(
                  child: MultiSelectDropDown(
                    items: ['Jawa', 'Sumatra', 'Kalimantan', 'Sulawesi', 'Papua', 'General'],
                    onSelectedChanged: (selectedItems) {
                      ctrl.filterByFrom(selectedItems);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1, // Adjust aspect ratio as needed
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: ctrl.productShowInUi.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.productShowInUi[index].name ?? 'No Name',
                      price: ctrl.productShowInUi[index].price ?? 0,
                      imageUrl: ctrl.productShowInUi[index].image ?? 'url',
                      onTap: () {
                        Get.to(() => ProductDescriptionPage(), arguments: {'data': ctrl.productShowInUi[index]});
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
