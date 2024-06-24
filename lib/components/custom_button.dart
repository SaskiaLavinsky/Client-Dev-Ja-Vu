import 'package:client_dev_ja_vu/components/loader.dart';
import 'package:client_dev_ja_vu/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  final bool loading;
  const CustomButton({Key? key, required this.text, this.loading = false, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(255, 182, 133, 93),
        boxShadow: CustomTheme.buttonShadow,
      ),
      child: MaterialButton(
        onPressed: loading? null: onPress,
        child: loading
        ? const Loader()
        : Text(
          text, 
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Alegreya', 
            ),
        ),
      ),
    );
  }
}