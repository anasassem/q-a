part of 'my_reviews_imports.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit()..getReviews(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text(tr("reviews", context)),
        ),
        body: BlocBuilder<MoreCubit, MoreState>(
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
                itemCount: cubit.reviews.length,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10).r,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15).r),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                          .r,
                  child: Column(
                    children: [
                      Text(
                        cubit.reviews[index].comment!,
                        style: const AppTextStyle.s16_w700(
                          color: Colors.white,
                        ),
                      ),
                      Gaps.vGap10,
                      RatingBar.builder(
                        initialRating: cubit.reviews[index].rate!,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        glow: false,
                        tapOnlyMode: true,
                        ignoreGestures: true,
                        unratedColor: chatGptColor,
                        itemSize: Dimens.dp20,
                        glowColor: chatGptColor,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star_border,
                          color: Colors.white,
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
      ),
    );
  }
}
