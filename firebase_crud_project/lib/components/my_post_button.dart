
import 'package:flutter/material.dart';

class MyPostButton extends StatelessWidget {
  final  void Function()? onTap;
  MyPostButton({super.key, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondary
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 10),
        child: Center(child: Icon(Icons.done,color: Theme.of(context).colorScheme.primary,)),
      ),
    );
  }
}
