import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ozan/components/components.dart';
import 'package:ozan/theme/theme.dart';

class SnackBarUtils{

  static void showSnackbar(BuildContext context, IconData icon, String msg){

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          
          closeIconColor: Colors.red,

          duration: const Duration(seconds: 3),

          backgroundColor: Themes.text,

          showCloseIcon: true,

          content: Row(
          
            children: [
          
              Icon(icon, color: Themes.background.withOpacity(0.9)),
              
              const Gap(12),
          
              Text(msg, style: TextStyle(color:Themes.background, height: 2)),
            ],
          )
        )
    );
  }


  // Dictionary SnackBar
  static void showDictionarySnackbar(BuildContext context, IconData icon, String msg){

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          
          closeIconColor: Colors.red,

          duration: const Duration(minutes: 1),

          backgroundColor: Themes.text,

          showCloseIcon: true,

          content: Row(
          
            children: [
          
              Icon(icon, color: Themes.background.withOpacity(0.9)),
              
              const Gap(12),
          
              Text(msg, style: TextStyle(color:Themes.background, height: 2)),

              const Gap(12),

              IconButton(onPressed: ()=> copyToClipboard(context, msg), icon: Icon(Iconsax.copy, color: Themes.background.withOpacity(0.9))),
              
            ],
          )
        )
    );
  }
}