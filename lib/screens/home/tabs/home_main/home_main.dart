part of 'home_main_imports.dart';

class HomeMain extends StatefulWidget {
  final String deviceId ;
  const HomeMain({super.key, required this.deviceId});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  late HomeMainController controller;

  @override
  void initState() {
    controller = HomeMainController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Q & A",
            style: AppTextStyle.s16_w700(color: Colors.black)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: ListView(
          children: [
             Text(tr("tools", context),
                style: const AppTextStyle.s16_w700(color: Colors.white)),
            Gaps.vGap15,
            BlocBuilder<GenericBloc<List<dynamic>>,
                GenericState<List<dynamic>>>(
              bloc: controller.bannersBloc,
              builder: (context, state) {
              if(state is GenericUpdateState){
                  return SizedBox(
                    height: 120.h,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 120.h,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                alignment: AlignmentDirectional.topStart,
                                height: 60,
                                width: 60,
                                margin: const EdgeInsetsDirectional.only(
                                    start: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  image: DecorationImage(
                                    image: (state.data[index] is String
                                        ? NetworkImage(
                                      state.data[index],
                                    )
                                        : FileImage(
                                      state.data[index],
                                    )) as ImageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                            itemCount: state.data.length,
                          ),
                        );
                      },
                      itemCount: state.data.length,
                    ),
                  );
                }else {
                  return  Container();
                }
              },
            ),
            Gaps.vGap15,
             Text(
              tr("myHistory", context),
              style: const AppTextStyle.s16_w700(color: Colors.white),
            ),
            Gaps.vGap15,
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("history")
                  .doc(widget.deviceId)
                  .collection("history")
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return  Padding(
                    padding:  EdgeInsets.only(top: 100.h),
                    child: Center(
                      child: CircularProgressIndicator(color: primaryColor,),
                    ),
                  );
                }
                List history =
                    snapshot.data.docs.map((e) => e.data()["msg"]).toList();
                return Visibility(
                  visible: history.isNotEmpty,
                  replacement: Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Center(
                      child: Text(
                        tr("noHistory", context),
                        style: AppTextStyle.s14_w600(color: primaryColor),
                      ),
                    ),
                  ),
                  child: Column(
                    children: List.generate(history.length, (index) => Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: Dimens.dp6, horizontal: Dimens.dp10),
                      padding: const EdgeInsets.all(Dimens.dp10),
                      decoration: CustomDecoration(),
                      child: Text(
                        history[index],
                        textAlign: TextAlign.start,
                        style:
                         AppTextStyle.s14_w600(color: Colors.black),
                      ),
                    )),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
