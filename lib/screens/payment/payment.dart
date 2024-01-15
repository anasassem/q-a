part of 'payment_imports.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PaymentController controller = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => controller.onSkipPayment(context),
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, right: 15, left: 15).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.vGap50,
            Text(
              tr("unlockUnlimitedAccess", context),
              style: const AppTextStyle.s32_w700(color: Colors.black),
            ),
            Gaps.vGap32,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Res.chatGpt4,
                        scale: 8,
                      ),
                      Gaps.hGap10,
                      Text(
                        tr("chatGPT4", context),
                        style: const AppTextStyle.s16_w700(color: Colors.black),
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Row(
                    children: [
                      Image.asset(
                        Res.noLimits,
                        scale: 13,
                      ),
                      Gaps.hGap10,
                      Text(
                        tr("noLimits", context),
                        style: const AppTextStyle.s16_w700(color: Colors.black),
                      ),
                    ],
                  ),
                  Gaps.vGap32,
                  Row(
                    children: [
                      Image.asset(
                        Res.noAds,
                        scale: 3,
                      ),
                      Gaps.hGap10,
                      Text(
                        tr("noAds", context),
                        style: const AppTextStyle.s16_w700(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gaps.vGap50,
            BuildPayOptions(
              controller: controller,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => controller.onPayment(context),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  tr("startFreeTrialAndPay", context),
                  style: AppTextStyle.s14_w600(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
