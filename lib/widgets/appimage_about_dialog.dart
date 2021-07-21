import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';
import '../utils/utils.dart';

Dialog appimageAboutDialog(BuildContext context) {
  return roundedDialog(context, children: [
    Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
                imageUrl:
                    'https://avatars.githubusercontent.com/u/16617932?s=80&v=4'),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
              child: Text(
                "AppImages",
                style: context.textTheme.headline5!.copyWith(letterSpacing: 1),
              ),
            ),
            Text("EASY TRUSTED FAST",
                style: context.textTheme.bodyText2!.copyWith(letterSpacing: 2)),
            const SizedBox(height: 10),
            Text(
              "Linux apps that run anywhere",
              style: context.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Tooltip(
              message: projectUrl,
              child: MaterialButton(
                child: Text(
                  "Know More",
                  style: context.textTheme.bodyText2!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                color: Colors.blue[600],
                onPressed: () {
                  appimageWebsite.launchIt();
                },
              ),
            )
          ],
        ),
      ),
    ),
  ]);
}
