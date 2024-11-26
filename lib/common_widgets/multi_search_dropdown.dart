import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/common_widgets/text_feild.dart';
import 'package:letstrip/generated/I10n.dart';
import 'package:letstrip/generated/assets.dart';

import 'package:letstrip/repositories/search_location_controller.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/navigation.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

class MultiSearchableDropdown extends StatefulWidget {
  final Function(List<String>) onSelect;
  final String? leadingIcon;
  final List<String>? initialItems;
  final bool showDeleteOption;
  final bool isMultiSearch;
  final String? hintText;
  final bool? prefixIcon;
  final bool? customizable;

  const MultiSearchableDropdown(
    this.onSelect, {
    super.key,
    this.prefixIcon = true,
    this.customizable = false,
    this.leadingIcon,
    this.initialItems,
    this.showDeleteOption = false,
    this.isMultiSearch = true,
    this.hintText,
    required Null Function(dynamic location) onValueUpdate,
  });

  @override
  MultiSearchableDropdownState createState() => MultiSearchableDropdownState();
}

class MultiSearchableDropdownState extends State<MultiSearchableDropdown> {
  final controller = Get.find<SearchLocationController>();

  final _textController = TextEditingController();
  List<String> selectedResults = [];
  bool isListVisible = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // If initialItems is not null, use it to populate selectedResults initially
    selectedResults = widget.initialItems ?? [];

    _textController.addListener(() {
      if (_textController.text.length >= 2) {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 200), () {
          controller.searchPlaces(_textController.text);
        });
      } else {
        _debounceTimer?.cancel();
        setState(() {
          controller.places.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField with selected items displayed as textCard
        textField(
            controller: _textController,
            context: context,
            isFixedSize: true,
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                boxW16(),
                // Show the vector icon only if `prefixIcon` is true
                if (widget.prefixIcon ?? false)
                  vector(widget.leadingIcon ?? Assets.assetsLocation),
                boxW4(),
                // Display initialItems as textCard if selectedResults is empty
                if (selectedResults.isEmpty)
                  ...widget.initialItems?.map((value) => textCard(value)) ?? [],
                // Display selectedResults as textCard
                ...selectedResults.map((value) => textCard(value)),
              ],
            ),
            onChanged: (t) {
              setState(() {
                isListVisible = true;
              });
            },
            outlineLabelStyle: AppTextTheme.bodyStyle,
            outlineLabel: selectedResults.isEmpty
                ? (widget.hintText ?? S.of(context).selectDestinations)
                : ""),
        boxH8(),
        // Displaying the search result list
        if (isListVisible)
          Obx(() =>
              controller.loadingState.value && _textController.text.length > 2
                  ? Padding(
                      padding: padAll(),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.places.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              isListVisible = false;
                              if (!widget.isMultiSearch) {
                                selectedResults.clear();
                                backToPrevious();
                              }
                              selectedResults
                                  .add(controller.places[index].split(',')[0]);
                              _textController.clear();
                              widget.onSelect(selectedResults);
                            });
                          },
                          title: Text(controller.places[index],
                              style: AppTextTheme.bodyStyle),
                        );
                      },
                    ))
      ],
    );
  }

  Widget textCard(String value) {
    return Container(
      padding: padSym(horizontal: 12.w, vertical: 6.h),
      margin: padAll(value: 2),
      decoration: BoxDecoration(
          color: widget.customizable!
              ? Color.fromRGBO(57, 185, 111, 1)
              : Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().radius(64)),
          border: widget.customizable!
              ? null
              : Border.all(color: Colors.grey.withOpacity(0.7))),
      child: Row(
        children: [
          Text(value,
              style: AppTextTheme.labelBold13SpStyle.copyWith(
                  color: widget.customizable!
                      ? Colors.white
                      : Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(0.5))),
          if (widget.showDeleteOption) ...[
            boxW4(),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedResults.remove(value);
                  });
                },
                child: Icon(
                  color: widget.customizable! ? Colors.white : Colors.grey,
                  Icons.clear_rounded,
                  size: 16.sp,
                ))
          ]
        ],
      ),
    );
  }
}
