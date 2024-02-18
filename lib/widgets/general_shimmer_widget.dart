import 'package:flutter/cupertino.dart';
import 'custom_shimmer_widget.dart';
import '../utils/styles.dart';

class GeneralShimmerWidget extends StatelessWidget {
  const GeneralShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomWidgetShimmer(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (_, __) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: whiteColor,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
