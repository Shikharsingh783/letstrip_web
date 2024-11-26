import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';

import 'package:letstrip/common_widgets/text_feild.dart';

import 'package:letstrip/generated/assets.dart';
import 'package:letstrip/repositories/search_location_controller.dart';
import 'package:letstrip/theme/text_style.dart';
import 'package:letstrip/utils/padding_helper.dart';
import 'package:letstrip/utils/size_config.dart';

class SearchableDropdown extends StatefulWidget {
  final String hint;
  final String? initialValue;
  final String? prefixIcon;
  final Function(String) onSelect;

  const SearchableDropdown(this.onSelect,
      {this.hint = "", this.prefixIcon, this.initialValue, super.key});

  @override
  SearchableDropdownState createState() => SearchableDropdownState();
}

class SearchableDropdownState extends State<SearchableDropdown> {
  final controller = Get.find<SearchLocationController>();
  late TextEditingController _textController;
  bool isListVisible = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialValue);

    _textController.addListener(() {
      if (_textController.text.length >= 3) {
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
        textField(
            controller: _textController,
            context: context,
            isFixedSize: true,
            prefixIcon: Transform.scale(
              scale: 0.4,
              child: vector(widget.prefixIcon ?? Assets.assetsLocation),
            ),
            onChanged: (t) {
              setState(() {
                isListVisible = true;
              });
            },
            outlineLabelStyle: AppTextTheme.bodyStyle,
            outlineLabel: widget.hint),
        boxH8(),
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
                            widget.onSelect(controller.places[index]);
                            setState(() {
                              isListVisible = false;
                              _textController.text = controller.places[index];
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
}
