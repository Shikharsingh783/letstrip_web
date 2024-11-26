import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onToggle;

  const CustomSwitch(
      {super.key, this.initialValue = true, required this.onToggle});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  late final ValueNotifier<bool> _controller;
  late Color thumbColor = const Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<bool>(widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      initialValue: _controller.value,
      controller: _controller,
      activeColor: Color.fromRGBO(57, 185, 111, 1),
      inactiveColor: Color.fromRGBO(102, 102, 102, 0.5),
      width: ScreenUtil().setWidth(43),
      height: ScreenUtil().setHeight(20),
      thumb: Container(
          height: ScreenUtil().setSp(16),
          width: ScreenUtil().setSp(16),
          decoration: BoxDecoration(shape: BoxShape.circle, color: thumbColor)),
      onChanged: (value) {
        widget.onToggle(value);
        setState(() {
          if (value) {
            thumbColor = Theme.of(context).colorScheme.background;
          } else {
            thumbColor = Theme.of(context).colorScheme.surfaceVariant;
          }
        });
      },
    );
  }
}
