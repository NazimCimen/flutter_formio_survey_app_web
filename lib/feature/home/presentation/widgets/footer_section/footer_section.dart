import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';
import 'package:flutter_survey_app_web/product/decorations/box_decorations/custom_box_decoration.dart';
import 'package:flutter_survey_app_web/responsive/responsive.dart';
import 'package:flutter_survey_app_web/core/utils/image_enum.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      height: ConstantSizes.largePageHeight.value,
      width: Responsive.getWidth(context),
      child: Column(
        children: [
          const Expanded(
            flex: 75,
            child: _GetAppFromStoreColumn(),
          ),
          Expanded(
            flex: 25,
            child: _BottomPage(isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}

class _BottomPage extends StatelessWidget {
  const _BottomPage({
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ConstantSizes.xLarge.value,
        right: ConstantSizes.xLarge.value,
        top: ConstantSizes.xLarge.value,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FooterTextButton(
                  text: 'Policy&Privacy',
                  onPressed: () {},
                ),
                _FooterTextButton(
                  text: 'Help Center',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Made by Nazım Çimen\nwith Flutter 3.22.0',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: ConstantSizes.xxLarge.value,
                  child: Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    thickness: 1,
                    height: 1,
                  ),
                ),
                ConstantSizes.large.heightSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.linkedin,
                      size: ConstantSizes.large.value,
                    ),
                    ConstantSizes.medium.widthSizedBox,
                    Icon(
                      FontAwesomeIcons.github,
                      size: ConstantSizes.large.value,
                    ),
                    ConstantSizes.medium.widthSizedBox,
                    Icon(
                      FontAwesomeIcons.instagram,
                      size: ConstantSizes.large.value,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isMobile) const Spacer(),
        ],
      ),
    );
  }
}

class _FooterTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _FooterTextButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onTertiary,
            ),
      ),
    );
  }
}

class _GetAppFromStoreColumn extends StatelessWidget {
  const _GetAppFromStoreColumn();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SizedBox(
          child: Image.asset(
            ImageEnums.webtest9.toPathPng,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mobil uygulamamızı indirin ve anketlerinizi\nher zaman, her yerde oluşturun ve yönetin!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ConstantSizes.xLarge.heightSizedBox,
              Wrap(
                children: [
                  _NavigateToStoreContainer(
                    storeImage: ImageEnums.playStore.toPathPng,
                    text: 'Yakında Google Play Storeda',
                  ),
                  _NavigateToStoreContainer(
                    storeImage: ImageEnums.appStore.toPathPng,
                    text: 'Yakında App Storeda',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavigateToStoreContainer extends StatelessWidget {
  final String storeImage;
  final String text;

  const _NavigateToStoreContainer({
    required this.storeImage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.cPaddingSmall,
      child: Container(
        height: 80,
        width: 230,
        decoration: CustomBoxDecoration.storeCardDecoration(context),
        padding: context.cPaddingMedium,
        child: Row(
          children: [
            Flexible(
              child: Image.asset(
                storeImage,
                fit: BoxFit.contain,
              ),
            ),
            ConstantSizes.medium.widthSizedBox,
            Flexible(
              flex: 3,
              child: Text(
                maxLines: 2,
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.scrim,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
