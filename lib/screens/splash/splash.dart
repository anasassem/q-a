// ignore_for_file: library_private_types_in_public_api

part of 'splash_imports.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashController controller = SplashController();

  @override
  void initState() {
    controller.manipulateSaveData(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(Res.logo), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextAnimator(
          'Q & A',
          initialDelay: const   Duration(milliseconds: 1000),
          style: const TextStyle(color: Colors.black, fontWeight:FontWeight.w700, fontSize: 25),
          incomingEffect: WidgetTransitionEffects.incomingScaleDown(
            duration: const Duration(milliseconds: 600),
          ),
        ),
      ),
    );
  }
}
