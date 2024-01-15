part of 'review_imports.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final ReviewController controller = ReviewController();
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(tr("addReview", context)),
        ),
        body: BlocBuilder<MoreCubit, MoreState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: controller.fromKey,
                child: Column(
                  children: [
                    Center(
                      child: RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glow: false,
                        unratedColor: chatGptColor,
                        itemSize: Dimens.dp24,
                        glowColor: chatGptColor,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context, index) => const Icon(
                            Icons.star_border,
                            color: Colors.white,
                            size: 25),
                        onRatingUpdate: (rating) {
                          rate = rating;
                        },
                      ),
                    ),
                    Gaps.vGap32,
                    GenericTextField(
                      max: 10,
                      controller: controller.descController,
                      fieldTypes: FieldTypes.rich,
                      focusBorderColor: Colors.transparent,
                      type: TextInputType.text,
                      fillColor: cardColor,
                      action: TextInputAction.next,
                      textColor: Colors.white,
                      validate: (value) => value!.validateEmpty(),
                      label: tr("tellUsMoreAboutUrTrip", context),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (controller.fromKey.currentState!.validate()) {
                          getIt<LoadingHelper>().showLoadingDialog();
                          await MoreCubit.get(context).addReview(
                            ReviewModel(
                              comment: controller.descController.text,
                              rate: rate,
                              email: FirebaseAuth.instance.currentUser!.email
                            ),
                          );
                          getIt<LoadingHelper>().dismissDialog();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: cardColor,
                        ),
                        child: Text(
                          tr("send", context).toUpperCase(),
                          style:
                              const AppTextStyle.s16_w700(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
