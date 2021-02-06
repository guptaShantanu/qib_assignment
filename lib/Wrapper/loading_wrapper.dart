import 'package:flutter/material.dart';
import 'package:qib_assignment/Components/loading_bar.dart';

class LoadingWrapper extends StatefulWidget {
  final Widget child;
  final bool loading;
  LoadingWrapper({@required this.child,@required this.loading});
  @override
  _LoadingWrapperState createState() => _LoadingWrapperState();
}

class _LoadingWrapperState extends State<LoadingWrapper> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Container(
          height: MediaQuery.of(context).size.height,
          color: widget.loading?Colors.black.withOpacity(0.3):null,
        ),
        widget.loading?Positioned(
          bottom: 20.0,
          left: 20.0,
          child: CustomLoadingBar(),
        ):Container()
      ],
    );
  }
}