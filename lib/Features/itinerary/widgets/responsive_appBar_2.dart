import 'package:flutter/material.dart';
import 'package:letstrip/Features/itinerary/widgets/custom_app_bar.dart';
import 'package:letstrip/Features/itinerary/widgets/mobile_appBar.dart';
import 'package:letstrip/Features/itinerary/widgets/result_screen_appbar.dart';
import 'package:letstrip/common_widgets/helper_widget.dart';
import 'package:letstrip/generated/I10n.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: ResultScreenAppBar(), desktop: CustomAppBar());
  }
}
