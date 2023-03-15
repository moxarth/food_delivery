import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final bool? isLoading;

  CustomButton({
    this.isLoading,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    bool loading = isLoading ?? false;

    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: TextButton(
        onPressed: onPressed,
        child: Stack(
          children: [
            Visibility(
              visible: loading ? false : true,
              child: Text(
                text ?? "Custom Button",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            Visibility(
              visible: loading,
              child: Container(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              18.0,
            ),
          ),
        ),
      ),
    );
  }
}
