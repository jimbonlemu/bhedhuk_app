import '../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

class PaginationWidget extends StatelessWidget {
  final int pageCount;
  final int selectedPage;
  final int? buttonToDisplayPaginate;
  final Function onChanged;
  const PaginationWidget(
      {super.key,
      required this.pageCount,
      required this.selectedPage,
      this.buttonToDisplayPaginate,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Pagination(
      numOfPages: pageCount,
      selectedPage: selectedPage,
      pagesVisible: buttonToDisplayPaginate ?? 3,
      onPageChanged: onChanged,
      nextIcon: selectedPage == pageCount
          ? const Icon(IconData(0, fontFamily: 'MaterialIcons'))
          : const Icon(
              Icons.chevron_right_rounded,
              color: onPrimaryColor,
              size: 20,
            ),
      previousIcon: selectedPage == 1
          ? const Icon(IconData(0, fontFamily: 'MaterialIcons'))
          : const Icon(
              Icons.chevron_left_rounded,
              color: onPrimaryColor,
              size: 20,
            ),
      activeTextStyle: const TextStyle(
        color: blackColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        shape: MaterialStateProperty.all(const CircleBorder(
          side: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        )),
      ),
      inactiveBtnStyle: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.white38),
        shape: MaterialStateProperty.all(const CircleBorder(
          side: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        )),
      ),
      inactiveTextStyle: const TextStyle(
        fontSize: 14,
        color: blackColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
