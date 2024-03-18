import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SnackBarUtils{

  static void showSnackbar(BuildContext context, IconData icon, String msg){

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          
          closeIconColor: Colors.red,

          duration: const Duration(seconds: 3),

          backgroundColor: Theme.of(context).colorScheme.primary,

          showCloseIcon: true,

          content: Row(
          
            children: [
          
              Icon(icon, color: Theme.of(context).colorScheme.tertiary),
              
              const Gap(12),
          
              Text(msg, style: TextStyle(color:Theme.of(context).colorScheme.tertiary, height: 2, fontFamily: 'Inter', fontSize: 15)),
            ],
          )
        )
    );
  }
}