import 'package:client_dev_ja_vu/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 123,
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      decoration: CustomTheme.getCardDecoration(),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Row(
            children: [
              Expanded(
                flex: 12,
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(
                        'img/1.jpeg',
                        fit: BoxFit.contain,
                      ),
                  )),
              Expanded(
                flex: 20,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Title",
                          style: TextStyle(
                          fontFamily: 'Beau Rivage',
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Qty: 1",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "\$ price",
                          style: TextStyle(
                          fontFamily: 'Alegreya',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}