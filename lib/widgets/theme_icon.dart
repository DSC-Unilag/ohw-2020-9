import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:meme_generator/bloc/theme_bloc/theme_bloc.dart';
// import 'package:meme_generator/widgets/progress.dart';

// class ThemeIcon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ThemeBloc, ThemeState>(listener: (context, state) {
//       if (state is ChangeThemeLoaded) {
//         BlocProvider.of<ThemeBloc>(context).add(GetThemeEvent());
//       }
//     }, child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
//       if (state is GetThemeLoading) {
//         return circularProgress();
//       } else if (state is GetThemeLoaded) {
//         return IconButton(
//           icon: FaIcon(
//             state.themeMode == 'dark'
//                 ? FontAwesomeIcons.lightbulb
//                 : FontAwesomeIcons.solidMoon,
//           ),
//           onPressed: () {
//             BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
//           },
//         );
//       }
//       return SizedBox.shrink();
//     }));
//   }
// }

class ThemeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
