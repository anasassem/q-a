part of 'dash_board_imports.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late DashBoardController controller;

  @override
  void initState() {
    controller = DashBoardController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          tr("dashBoard", context),
          style: const AppTextStyle.s16_w700(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          controller.updateDashBoard();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15).r,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15).r,
              ),
              child: Text(
                tr("update", context).toUpperCase(),
                textAlign: TextAlign.center,
                style:  AppTextStyle.s14_w600(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<GenericBloc<DashBoardModel?>,
          GenericState<DashBoardModel?>>(
        bloc: controller.dashBoardData,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.dp20,
              vertical: Dimens.dp20,
            ),
            children: [
              Container(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                      child: Text(
                        tr("bannerImages", context),
                        style: AppTextStyle.s16_w700(color: primaryColor),
                      ),
                    ),
                    Gaps.vGap10,
                    BlocBuilder<GenericBloc<List<dynamic>>,
                        GenericState<List<dynamic>>>(
                      bloc: controller.imagesBloc,
                      builder: (context, state) {
                        if (state is GenericUpdateState) {
                          return Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              ...List.generate(
                                state.data.length,
                                (index) => Container(
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
                                  child: InkWell(
                                    onTap: () => controller.removeImage(index),
                                    child: const Icon(Icons.clear,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    controller.showGallaryOrCamera(context),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: CustomDecoration().copyWith(
                                      border: Border.all(color: primaryColor)),
                                  child: Icon(
                                    Icons.add,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return InkWell(
                            onTap: () =>
                                controller.showGallaryOrCamera(context),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: CustomDecoration().copyWith(
                                  border: Border.all(color: primaryColor)),
                              child: Icon(
                                Icons.add,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Gaps.vGap15,
              GenericTextField(
                controller: controller.appLink,
                fieldTypes: FieldTypes.normal,
                focusBorderColor: primaryColor,
                enableBorderColor: Colors.transparent,
                type: TextInputType.text,
                fillColor: cardColor,
                action: TextInputAction.next,
                textColor: Colors.black,
                validate: (value) => value!.validateEmpty(),
                label: "App link",
                margin: const EdgeInsets.only(bottom: 15),
              ),
              Gaps.vGap15,
              GenericTextField(
                controller: controller.apiKey,
                fieldTypes: FieldTypes.normal,
                focusBorderColor: primaryColor,
                enableBorderColor: Colors.transparent,
                type: TextInputType.text,
                fillColor: cardColor,
                action: TextInputAction.none,
                textColor: Colors.black,
                validate: (value) => value!.validateEmpty(),
                label: "API key",
                margin: const EdgeInsets.only(bottom: 15),
              ),
              Gaps.vGap15,
              GenericTextField(
                max: 10,
                controller: controller.termsAnnConditions,
                fieldTypes: FieldTypes.rich,
                focusBorderColor: primaryColor,
                enableBorderColor: Colors.transparent,
                type: TextInputType.multiline,
                fillColor: cardColor,
                action: TextInputAction.newline,
                textColor: Colors.black,
                validate: (value) => value!.validateEmpty(),
                label: tr("termsAndConditions", context),
                margin: const EdgeInsets.only(bottom: 15),
              ),
              Gaps.vGap15,
              GenericTextField(
                max: 10,
                controller: controller.privacyPolicy,
                fieldTypes: FieldTypes.rich,
                focusBorderColor: primaryColor,
                enableBorderColor: Colors.transparent,
                type: TextInputType.text,
                fillColor: cardColor,
                action: TextInputAction.next,
                textColor: Colors.black,
                validate: (value) => value!.validateEmpty(),
                label: tr("privacyPolicy", context),
                margin: const EdgeInsets.only(bottom: 15),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                child: Text(
                  tr("reviews", context),
                  style: AppTextStyle.s16_w700(color: primaryColor),
                ),
              ),
              BlocBuilder<MoreCubit, MoreState>(
                builder: (context, state) {
                  if (state is GetReviewsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetReviewsFailure) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    var cubit = MoreCubit.get(context);
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.reviews.length,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ).r,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(15).r),
                        padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10)
                            .r,
                        child: Column(
                          children: [
                            Text(
                              cubit.reviews[index].comment!,
                              style: const AppTextStyle.s16_w700(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              cubit.reviews[index].email!,
                              style: const AppTextStyle.s16_w700(
                                color: Colors.black,
                              ),
                            ),
                            Gaps.vGap10,
                            RatingBar.builder(
                              initialRating: cubit.reviews[index].rate!,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              glow: true,
                              tapOnlyMode: true,
                              ignoreGestures: true,
                              unratedColor: Colors.grey,
                              itemSize: Dimens.dp20,
                              glowColor: primaryColor,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_border,
                                color: primaryColor,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                child: Text(
                  tr("users", context),
                  style: AppTextStyle.s16_w700(color: primaryColor),
                ),
              ),
              BlocBuilder<GenericBloc<List<UserModel>>,
                  GenericState<List<UserModel>>>(
                bloc: controller.users,
                builder: (context, state) {
                  return Column(
                    children: List.generate(
                      state.data.length,
                      (index) => Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(15).r,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ).r,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.data[index].email!,
                                  style:  AppTextStyle.s14_w600(
                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.showSendNotifyDialog(
                                    context,
                                    state.data[index].deviceId!,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: primaryColor,
                                        ),
                                        child: Text(tr('sendNotify', context),
                                            style:  AppTextStyle.s14_w600(
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Gaps.vGap10,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Gaps.vGap64,
            ],
          );
        },
      ),
    );
  }
}
