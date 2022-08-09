import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';

class TextNavigation extends StatelessWidget {
  const TextNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Text('Test Navigation'),
          ],
        )),
      ),
    );
  }
}
