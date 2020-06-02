library flutter_datetime_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// ignore: implementation_imports
import 'package:flutter_datetime_picker/src/datetime_picker_theme.dart';
// ignore: implementation_imports
import 'package:flutter_datetime_picker/src/i18n_model.dart';
import 'package:member_apps/ui/widgets/library/date_picker/date_model.dart';

export 'package:flutter_datetime_picker/src/datetime_picker_theme.dart';
export 'package:flutter_datetime_picker/src/i18n_model.dart';

typedef DateChangedCallback(DateTime time);
typedef String StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime> showDatePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateTime minTime,
    DateTime maxTime,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) async {
    return await Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DatePickerModel(
                currentTime: currentTime,
                maxTime: maxTime,
                minTime: minTime,
                locale: locale)));
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime> showTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    bool showSecondsColumn: true,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) async {
    return await Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: TimePickerModel(
                currentTime: currentTime,
                locale: locale,
                showSecondsColumn: showSecondsColumn)));
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime> showDateTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateTime minTime,
    DateTime maxTime,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) async {
    return await Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DateTimePickerModel(
                currentTime: currentTime,
                minTime: minTime,
                maxTime: maxTime,
                locale: locale)));
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static Future<DateTime> showPicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    BasePickerModel pickerModel,
    DatePickerTheme theme,
  }) async {
    return await Navigator.push(
        context,
        new _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: pickerModel));
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    theme,
    this.barrierLabel,
    this.locale,
    RouteSettings settings,
    pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool showTitleActions;
  final DateChangedCallback onChanged;
  final DateChangedCallback onConfirm;
  final DatePickerTheme theme;
  final LocaleType locale;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        onChanged: onChanged,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent(
      {Key key,
      @required this.route,
      this.onChanged,
      this.locale,
      this.pickerModel});

  final DateChangedCallback onChanged;

  final _DatePickerRoute route;

  final LocaleType locale;

  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  int get middleIndex {
    if (widget.pickerModel.currentLeftIndex() == 0) {
      this.widget.pickerModel.setMiddleIndex(
          (widget.pickerModel.currentMiddleIndex() < DateTime.now().hour)
              ? DateTime.now().hour
              : widget.pickerModel.currentMiddleIndex());
      return (widget.pickerModel.currentMiddleIndex() < DateTime.now().hour)
          ? DateTime.now().hour
          : widget.pickerModel.currentMiddleIndex();
    }
    this
        .widget
        .pickerModel
        .setMiddleIndex(widget.pickerModel.currentMiddleIndex());
    return widget.pickerModel.currentMiddleIndex();
  }

  int get rightIndex {
    if (widget.pickerModel.currentLeftIndex() == 0) {
      if (widget.pickerModel.currentMiddleIndex() ==
          widget.pickerModel.storeMin().hour) {
        this.widget.pickerModel.setRightIndex((widget.pickerModel.currentRightIndex() <
            widget.pickerModel.storeMin().minute)
            ? widget.pickerModel.storeMin().minute
            : widget.pickerModel.currentRightIndex());
        return (widget.pickerModel.currentRightIndex() <
                widget.pickerModel.storeMin().minute)
            ? widget.pickerModel.storeMin().minute
            : widget.pickerModel.currentRightIndex();
      } else if (widget.pickerModel.currentMiddleIndex() ==
          DateTime.now().hour) {
        this.widget.pickerModel.setRightIndex((widget.pickerModel.currentRightIndex() < DateTime.now().minute)
            ? DateTime.now().minute
            : widget.pickerModel.currentRightIndex());
        return (widget.pickerModel.currentRightIndex() < DateTime.now().minute)
            ? DateTime.now().minute
            : widget.pickerModel.currentRightIndex();
      }
    } else {
      if (widget.pickerModel.currentMiddleIndex() ==
          widget.pickerModel.storeMin().hour) {
        this.widget.pickerModel.setRightIndex((widget.pickerModel.currentRightIndex() <
            widget.pickerModel.storeMin().minute)
            ? widget.pickerModel.storeMin().minute
            : widget.pickerModel.currentRightIndex());
        return (widget.pickerModel.currentRightIndex() <
                widget.pickerModel.storeMin().minute)
            ? widget.pickerModel.storeMin().minute
            : widget.pickerModel.currentRightIndex();
      }
    }
    this.widget.pickerModel.setRightIndex(widget.pickerModel.currentRightIndex());
    return widget.pickerModel.currentRightIndex();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl =
        new FixedExtentScrollController(initialItem: middleIndex);
    rightScrollCtrl = new FixedExtentScrollController(initialItem: rightIndex);
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(widget.route.animation.value, theme,
                  showTitleActions: widget.route.showTitleActions,
                  bottomPadding: bottomPadding),
              child: GestureDetector(
                child: Material(
                  color: theme.backgroundColor ?? Colors.white,
                  child: _renderPickerView(theme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(widget.pickerModel.finalTime());
    }
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme),
          itemView,
        ],
      );
    }
    return itemView;
  }

  Widget _renderColumnView(
      ValueKey key,
      DatePickerTheme theme,
      StringAtIndexCallBack stringAtIndexCB,
      ScrollController scrollController,
      int layoutProportion,
      ValueChanged<int> selectedChangedWhenScrolling,
      ValueChanged<int> selectedChangedWhenScrollEnd) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: theme.containerHeight,
        decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                selectedChangedWhenScrollEnd != null &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics = notification.metrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor ?? Colors.white,
            scrollController: scrollController,
            itemExtent: theme.itemHeight,
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: false,
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              if (content == null) {
                return null;
              }
              return Container(
                height: theme.itemHeight,
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: theme.itemStyle,
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _renderItemView(DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: widget.pickerModel.layoutProportions()[0] > 0
                ? _renderColumnView(
                    ValueKey(widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.leftStringAtIndex,
                    leftScrollCtrl,
                    widget.pickerModel.layoutProportions()[0], (index) {
                    widget.pickerModel.setLeftIndex(index);
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  })
                : null,
          ),
          Text(
            widget.pickerModel.leftDivider(),
            style: theme.itemStyle,
          ),
          Container(
            child: widget.pickerModel.layoutProportions()[1] > 0
                ? _renderColumnView(
                    ValueKey(widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.middleStringAtIndex,
                    middleScrollCtrl,
                    widget.pickerModel.layoutProportions()[1], (index) {
                    widget.pickerModel.setMiddleIndex(index);
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  })
                : null,
          ),
          Text(
            widget.pickerModel.rightDivider(),
            style: theme.itemStyle,
          ),
          Container(
            child: widget.pickerModel.layoutProportions()[2] > 0
                ? _renderColumnView(
                    ValueKey(widget.pickerModel.currentMiddleIndex() * 100 +
                        widget.pickerModel.currentLeftIndex()),
                    theme,
                    widget.pickerModel.rightStringAtIndex,
                    rightScrollCtrl,
                    widget.pickerModel.layoutProportions()[2], (index) {
                    widget.pickerModel.setRightIndex(index);
                    _notifyDateChanged();
                  }, (index) {
                    setState(() {
                      refreshScrollOffset();
                      _notifyDateChanged();
                    });
                  })
                : null,
          ),
        ],
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    String done = _localeDone();
    String cancel = _localeCancel();

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(
        color: theme.headerColor ?? theme.backgroundColor ?? Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(left: 16, top: 0),
              child: Text(
                '$cancel',
                style: theme.cancelStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(right: 16, top: 0),
              child: Text(
                '$done',
                style: theme.doneStyle,
              ),
              onPressed: () {
                Navigator.pop(context, widget.pickerModel.finalTime());
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm(widget.pickerModel.finalTime());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'];
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'];
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme,
      {this.itemCount, this.showTitleActions, this.bottomPadding = 0});

  final double progress;
  final int itemCount;
  final bool showTitleActions;
  final DatePickerTheme theme;
  final double bottomPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions) {
      maxHeight += theme.titleHeight;
    }

    return new BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: maxHeight + bottomPadding);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}