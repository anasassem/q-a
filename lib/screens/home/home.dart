part of 'home_imports.dart';

class Home extends StatefulWidget {
  final String deviceId ;
  const Home({super.key, required this.deviceId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController controller = HomeController();

  @override
  void initState() {
    setState(() {});
    controller.pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          children:  <Widget>[
            HomeMain(deviceId:widget.deviceId ,),
            const ChatScreen(),
            const More(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: RollingBottomBar(
          controller: controller.pageController,
          color: primaryColor,
          flat: true,
          useActiveColorByDefault: false,
          items:   [    RollingBottomBarItem(
            Icons.home,
            label: tr("home", context),
            activeColor: Colors.white,
          ),

            const RollingBottomBarItem(
              Icons.chat_bubble_outline,
              label: 'Q & A',
              activeColor: Colors.white,
            ),

            RollingBottomBarItem(
              Icons.menu,
              label: tr("menu", context),
              activeColor: Colors.white,
            ),
          ],
          enableIconRotation: true,
          onTap: (index) {
            controller.pageController.animateToPage(
              index,
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
    );
  }
}
