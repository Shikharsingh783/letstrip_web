import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';
import 'package:letstrip/utils/utilities.dart';

class MultiOptionDropdown extends StatefulWidget {
  final List<DropdownType> items;
  final List<String>? selectedOption;
  final String hint;
  final String leadingIcon;
  final Function(List<String>) onItemSelected;
  final bool isNotEditable;

  const MultiOptionDropdown({
    super.key,
    required this.hint,
    required this.leadingIcon,
    required this.items,
    this.selectedOption,
    required this.onItemSelected,
    this.isNotEditable = false,
  });

  @override
  MultiOptionDropdownState createState() => MultiOptionDropdownState();
}

class MultiOptionDropdownState extends State<MultiOptionDropdown> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.selectedOption ?? [];
  }

  void updateSelectedOptions(String value) {
    setState(() {
      if (selectedOptions.contains(value)) {
        selectedOptions.remove(value);
      } else {
        selectedOptions.add(value);
      }
      widget.onItemSelected(selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    return AbsorbPointer(
      absorbing: widget.isNotEditable,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(40)),
            padding: padSym(
              horizontal: ScreenUtil().setWidth(4.0),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                border: Border.all(color: const Color(0xFFE4E4E4))),
            child: Center(
              child: Row(
                children: [
                  Padding(
                      padding: padOnly(left: 8, right: 12.w),
                      child: SizedBox(
                          height: 50.h, child: vector(widget.leadingIcon))),
                  Flexible(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (selectedOptions.isEmpty)
                          Text(widget.hint,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(102, 102, 102, 1))),
                        SizedBox(
                            width: screenWidth(percentage: 80),
                            child: Wrap(
                              runAlignment: WrapAlignment.center,
                              children: [
                                ...selectedOptions.map((value) => Container(
                                      padding: padSym(
                                          horizontal: 12.w, vertical: 6.h),
                                      margin: padAll(value: 2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(64)),
                                          border: Border.all(
                                              color: Colors.grey
                                                  .withOpacity(0.7))),
                                      child: Text(value,
                                          style: AppTextTheme.labelBold13SpStyle
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSecondary
                                                      .withOpacity(0.5))),
                                    ))
                              ].separateHorizontally(4),
                            )),
                        DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              updateSelectedOptions(newValue.toString());
                            });
                          },
                          items: widget.items.map<DropdownMenuItem<String>>(
                              (DropdownType item) {
                            return DropdownMenuItem<String>(
                              value: item.value,
                              child: ListTile(
                                trailing: vector(
                                    selectedOptions.contains(item.value)
                                        ? Assets.assetsDoneGreen
                                        : Assets.assetsDoneGrey),
                                title: Row(
                                  children: [
                                    item.isPng
                                        ? Transform.translate(
                                            offset: const Offset(-2, 0),
                                            child: Image.asset(item.iconPath))
                                        : vector(item.iconPath),
                                    boxW16(),
                                    Transform.translate(
                                        offset: Offset(item.isPng ? -6 : 0, 0),
                                        child: Text(item.value,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppTextTheme.bodyBoldStyle))
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          underline: Container(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
