import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/utils/size.dart';

const double mainAppBarPadding = 28;

class MainSliverAppBar extends SliverAppBar {
  static const TextStyle _textStyle = TextStyle(
    // color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: kToolbarHeight / 3,
    height: 1,
  );

  MainSliverAppBar(
      {super.key,
      GlobalKey? appBarKey,
      String title = '',
      double height = kToolbarHeight + mainAppBarPadding * 2,
      double expandedFontSize = 30,
      void Function()? onLeadingPress = AppNavigator.pop,
      void Function()? onTrailingPress,
      required BuildContext context})
      : super(
          centerTitle: true,
          expandedHeight: height,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: mainAppBarPadding),
            onPressed: onLeadingPress,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
          actions: [
            IconButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: mainAppBarPadding),
              icon: Icon(Icons.favorite_border_outlined,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
              onPressed: onTrailingPress,
            ),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final safeAreaTop = MediaQuery.of(context).padding.top;
              final minHeight = safeAreaTop + kToolbarHeight;
              final maxHeight = height + safeAreaTop;

              final percent =
                  (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
              final fontSize = _textStyle.fontSize ?? 16;
              final currentTextStyle = _textStyle.copyWith(
                fontSize: fontSize + (expandedFontSize - fontSize) * percent,
              );

              final textWidth =
                  getTextSize(context, title, currentTextStyle).width;
              const startX = mainAppBarPadding;
              final endX = MediaQuery.of(context).size.width / 2 -
                  textWidth / 2 -
                  startX;
              final dx = startX + endX - endX * percent;

              return Container(
                color: Theme.of(context)
                    .colorScheme
                    .background
                    .withOpacity(0.8 - percent * 0.8),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight / 3),
                      child: Transform.translate(
                        offset:
                            Offset(dx, constraints.maxHeight - kToolbarHeight),
                        child: Text(
                          title,
                          style: currentTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? appBarTitleText;
  final List<Widget>? actions;
  final bool isBackButtonShowed;
  final bool isBackButtonEnabled;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final IconThemeData? iconTheme;

  MainAppBar({
    Key? key,
    this.appBarTitleText,
    this.actions,
    this.isBackButtonShowed = true,
    this.isBackButtonEnabled = true,
    this.bottom,
    this.backgroundColor = Colors.transparent,
    this.iconTheme,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      elevation: 0,
      leading: isBackButtonShowed
          ? const IconButton(
              padding: EdgeInsets.symmetric(horizontal: mainAppBarPadding),
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: AppNavigator.pop,
            )
          : null,
      automaticallyImplyLeading: isBackButtonEnabled,
      actions: actions,
      iconTheme:
          iconTheme ?? IconThemeData(color: Theme.of(context).iconTheme.color),
      title: appBarTitleText,
      bottom: bottom,
    );
  }
}
