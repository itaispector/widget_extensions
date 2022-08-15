library widget_extensions;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

extension WidgetExtensions on Widget {
  Widget withPadding(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget withOpacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }

  Widget addBorder(BoxBorder border) {
    return Container(child: this, decoration: BoxDecoration(border: border));
  }

  Widget disabled(bool disable) {
    return IgnorePointer(
      child: this.withOpacity(disable ? 0.3 : 1.0),
      ignoring: disable,
    );
  }

  Widget center() {
    return Center(child: this);
  }

  Widget transform(Matrix4 transform) {
    return Transform(child: this, transform: transform);
  }

  Widget loading(BuildContext context, bool loading) {
    return loading
        ? Stack(children: [
            this.disabled(true),
            Positioned.fill(
              child: SizedBox(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3.0,
                ),
                height: 25.0,
                width: 25.0,
              ).center(),
            )
          ])
        : this;
  }

  Widget loadingIndicator(bool loading) {
    return loading
        ? SizedBox(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3.0,
            ),
            height: 25.0,
            width: 25.0,
          ).withPadding(EdgeInsets.all(12.0))
        : this;
  }

  Widget sizedBox({Key? key, double? height, double? width}) {
    return SizedBox(height: height, width: width, child: this);
  }

  Widget addTapGesture(Function() onTap) {
    return GestureDetector(
      child: this,
      onTap: onTap,
    );
  }

  Widget addInkWell(Function() onTap) {
    return InkWell(
      child: this,
      onTap: onTap,
    );
  }

  Widget addBelow(Widget? widget) {
    if (widget == null) {
      return this;
    }
    return Column(children: [this, widget]);
  }

  Widget addAbove(Widget widget) {
    return Column(children: [widget, this]);
  }

  Widget addPositioned(Widget positioned) {
    return Stack(
      children: [positioned, this],
    );
  }

  Widget addRefreshIndicator(
      Future<void> Function() onRefresh, BuildContext context) {
    return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        child: this,
        onRefresh: onRefresh);
  }

  Widget expand() {
    return Expanded(child: this);
  }

  Widget animateSize({Key? key, duration = 150, vsync}) {
    return AnimatedSize(
        curve: Curves.easeOut,
        alignment: Alignment.topCenter,
        child: this,
        duration: Duration(milliseconds: duration),
        vsync: vsync);
  }

  Widget background(Color color) {
    return Container(
      child: this,
      color: color,
    );
  }

  Widget hidden(bool hidden) {
    return hidden ? Opacity(opacity: 0, child: this).disabled(true) : this;
  }

  Widget addShadow() {
    return Container(
        child: this,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ));
  }

  Widget addSlideables(List<SlidableAction> actions, {extentRatio = 0.25}) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: extentRatio,
        children: actions,
      ),
      child: this,
    );
  }

  Widget conditionedSize({double? height, double? width}) {
    if (height != null || width != null) {
      return SizedBox(
        height: height,
        width: width,
        child: this,
      );
    }
    return this;
  }
}
