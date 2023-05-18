import 'package:flutter/material.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';
import 'package:my_app/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageViewController = PageController(initialPage: 0);

  int _activePage = 0;
  String _buttonText = 'Continue';
  bool loading = true;
  void checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isFirstOpenApp = prefs.getString(firstOpenApp) ?? "";

    if (isFirstOpenApp.isEmpty) {
      await prefs.setString(firstOpenApp, "is not the first open app");
      setState(() {
        loading = false;
      });
    } else {
      AppNavigator.replaceWith(Routes.home);
    }
  }

  @override
  void initState() {
    checkData();
    super.initState();
  }

  final List<Widget> _pages = [
    const Image(
      image: AppImages.intro_page1,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
    const Image(
      image: AppImages.intro_page2,
      width: double.infinity,
    ),
    const Image(
      image: AppImages.intro_page3,
      width: double.infinity,
    ),
  ];

  String checkTitle() {
    switch (_activePage) {
      case 0:
        return 'Advanced OCR (Optical Character Recognition) technology';
      case 1:
        return 'Easily scan and extract text from any image captured by your phone\'s camera.';
      default:
        return 'Easily view and access all your past scans, organize them into folders';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? const SizedBox()
          : Column(
              children: [
                _buildPageView(),
                const VSpacer(8),
                _buildIndicator(),
                const VSpacer(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Scanner'),
                      const VSpacer(12),
                      Text(checkTitle())
                    ],
                  ),
                ),
                const VSpacer(32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(44),
                    ),
                  ),
                  child: Ripple(
                    onTap: () => _onPressButtonContinue(),
                    rippleRadius: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_buttonText,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const VSpacer(4),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _activePage < _pages.length - 1,
                  child: Ripple(
                    onTap: () {
                      AppNavigator.replaceWith(Routes.home);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text('Skip'),
                    ),
                  ),
                ),
                const VSpacer(32)
              ],
            ),
    );
  }

  Widget _buildPageView() => Expanded(
        child: PageView.builder(
            controller: _pageViewController,
            onPageChanged: (int index) {
              setState(() {
                _activePage = index;
                _buttonText =
                    index < (_pages.length - 1) ? 'Continue' : 'Finish';
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            }),
      );

  Widget _buildIndicator() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _pages.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Ripple(
              onTap: () {
                _pageViewController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              child: CircleAvatar(
                  radius: 4,
                  backgroundColor: _activePage == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
            ),
          ),
        ),
      );

  void _onPressButtonContinue() {
    _activePage++;
    if (_activePage == _pages.length) {
      AppNavigator.replaceWith(Routes.home);
    } else {
      _pageViewController.animateToPage(_activePage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
