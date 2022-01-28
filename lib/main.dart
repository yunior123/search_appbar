import 'package:flutter/material.dart';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';

import 'package:flutter/services.dart';
import 'dart:math' show sqrt, max;
import 'dart:ui' show lerpDouble;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AwesomeSearchBar(
        leading: const Drawer(),
        title: const Text("Test App Bar"),
        onBackPressed: () {},
        onClearPressed: () {},
        onChanged: (v) {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

enum SearchState { title, searching }
double kdefaultDecorationHeightOffset = 12.0;

@immutable
class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Alignment? centerAlignment;
  final Offset? centerOffset;
  final double? minRadius;
  final double? maxRadius;

  const CircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    final Offset center = centerAlignment?.alongSize(size) ??
        centerOffset ??
        Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction)!,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}

class AwesomeSearchBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(
    kToolbarHeight,
  );
  final List<Widget>? trailingActionButtons;
  final List<Widget>? leadingActionButtons;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClearPressed;

  final Widget? leading;

  final bool? automaticallyImplyLeading;

  final Widget? title;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final bool? primary;

  final bool? centerTitle;

  final bool? excludeHeaderSemantics;

  final double? titleSpacing;

  final double? toolbarOpacity;

  final double? bottomOpacity;

  final double? toolbarHeight;

  // final double leadingWidth;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final InputDecoration? decoration;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final TextCapitalization textCapitalization;

  final TextStyle? style;

  final StrutStyle? strutStyle;

  final TextAlign textAlign;

  final TextAlignVertical? textAlignVertical;

  final TextDirection? textDirection;

  final bool autofocus;

  // final String obscuringCharacter;

  final bool obscureText;

  final bool autocorrect;

  final SmartDashesType? smartDashesType;

  final SmartQuotesType? smartQuotesType;

  final bool enableSuggestions;

  final int? maxLines;

  final int? minLines;

  final bool expands;

  final bool readOnly;

  final ToolbarOptions? toolbarOptions;

  final bool? showCursor;

  static const int? noMaxLength = -1;

  final int? maxLength;

  final bool? maxLengthEnforced;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool? enabled;

  final double cursorWidth;

  // final double cursorHeight;

  final Radius? cursorRadius;

  final Color? cursorColor;

  final ui.BoxHeightStyle selectionHeightStyle;

  final ui.BoxWidthStyle selectionWidthStyle;

  final Brightness? keyboardAppearance;

  final EdgeInsets scrollPadding;

  final bool enableInteractiveSelection;

  final DragStartBehavior dragStartBehavior;

  final GestureTapCallback? onTap;

  // final MouseCursor mouseCursor;

  final InputCounterWidgetBuilder? buildCounter;

  final ScrollPhysics? scrollPhysics;

  final ScrollController? scrollController;

  // final Iterable<String> autofillHints;

  // Text that shows as hintText for textField
  final String? defaultHintText;

  // The animation duration used for reveal
  final Duration? revealAnimationDuration;
  // The curve used for the reveal animation
  final Curve revealAnimationCurve;

  // The widget used for the search button
  // default is Icon(Icons.search)
  final Widget? searchButtonIcon;

  // The colour of the search bar container
  final Color? searchContainerColor;
  // The icon used for the cleartext icon button
  final Icon? clearBtnIcon;
  // The widget used for the back arrow button
  // Icon(Icons.arrow_back)
  final Icon? backBtnIcon;

  const AwesomeSearchBar({
    Key? key,
    this.trailingActionButtons,
    this.leadingActionButtons,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    // this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    // this.leadingWidth,
    this.controller,
    this.focusNode,
    this.decoration,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = true,
    // this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    // this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    // this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    // this.autofillHints,
    this.keyboardType,
    this.smartDashesType,
    this.smartQuotesType,
    this.toolbarOptions,
    this.defaultHintText = 'Search...',
    this.revealAnimationDuration = const Duration(milliseconds: 250),
    this.revealAnimationCurve = Curves.easeIn,
    this.searchButtonIcon = const Icon(Icons.search),
    this.searchContainerColor = Colors.lightBlueAccent,
    this.clearBtnIcon = const Icon(Icons.close),
    this.backBtnIcon = const Icon(Icons.arrow_back),
    this.onBackPressed,
    this.onClearPressed,
  }) : super(key: key);

  @override
  _AppBarTextFieldState createState() => _AppBarTextFieldState();
}

class _AppBarTextFieldState extends State<AwesomeSearchBar>
    with SingleTickerProviderStateMixin {
  SearchState _searchState = SearchState.title;

  late Animation<double> _revealAnimation;
  late AnimationController _revealAnimationController;
  final GlobalKey _appBarKey = GlobalKey();
  final GlobalKey _searchIconBtnKey = GlobalKey();
  late TextEditingController _textController;
  late bool _showClearButton = false;
  Offset? _searchBtnPosition;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _textController = TextEditingController();
    } else {
      _textController = widget.controller!;
    }

    _textController.addListener(_onTextController);

    _revealAnimationController = AnimationController(
      vsync: this,
      duration: widget.revealAnimationDuration,
    );

    _revealAnimation = CurvedAnimation(
      parent: _revealAnimationController,
      curve: widget.revealAnimationCurve,
    );

    _revealAnimationController.addListener(
      () {
        if (_revealAnimationController.isCompleted) {
          _textController.clear();
        }
      },
    );
  }

  void _onTextController() {
    if (_textController.text.isNotEmpty && _showClearButton == false) {
      setState(
        () {
          _showClearButton = true;
        },
      );
    } else if (_textController.text.isEmpty && _showClearButton == true) {
      setState(
        () {
          _showClearButton = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          key: _appBarKey,
          title: widget.title,
          leading: widget.leading,
          automaticallyImplyLeading: widget.automaticallyImplyLeading ?? true,
          flexibleSpace: widget.flexibleSpace,
          bottom: widget.bottom,
          elevation: widget.elevation,
          shape: widget.shape,
          backgroundColor: widget.backgroundColor,
          iconTheme: widget.iconTheme,
          actionsIconTheme: widget.actionsIconTheme,
          primary: widget.primary ?? true,
          centerTitle: widget.centerTitle,
          excludeHeaderSemantics: widget.excludeHeaderSemantics ?? false,
          titleSpacing: widget.titleSpacing,
          toolbarOpacity: widget.toolbarOpacity ?? 1.0,
          bottomOpacity: widget.bottomOpacity ?? 1.0,
          actions: <Widget>[
            ...widget.leadingActionButtons ?? [Container()],
            _searchButton(),
            ...widget.trailingActionButtons ?? [Container()],
          ],
        ),
        Positioned.fill(child: _buildSearchTitle())
      ],
    );
  }

  Widget _searchButton() {
    return IconButton(
      key: _searchIconBtnKey,
      icon: widget.searchButtonIcon ??
          const Icon(
            Icons.search,
          ),
      onPressed: () {
        _onSearchPressed();
      },
    );
  }

  void _onBackPressed() {
    final onBackPressed = widget.onBackPressed;
    if (onBackPressed != null) {
      onBackPressed();
    }
    _onSearchPressed();
  }

  void _onSearchPressed() {
    var renderBoxAppBar =
        _appBarKey.currentContext?.findRenderObject() as RenderBox;
    Size appBarSize = renderBoxAppBar.size;

    RenderBox renderBoxSearchBtn =
        _searchIconBtnKey.currentContext?.findRenderObject() as RenderBox;
    Size btnSize = renderBoxSearchBtn.size;

    var offset = renderBoxSearchBtn.localToGlobal(btnSize.center(Offset.zero));
    var offsetAppBar =
        renderBoxAppBar.localToGlobal(appBarSize.center(Offset.zero));
    _searchBtnPosition = Offset(offset.dx, offsetAppBar.dy);

    int oldIndex = _searchState.index;
    int newIndex = oldIndex = 1 - oldIndex;

    setState(
      () {
        _searchState = SearchState.values[newIndex];

        _searchState == SearchState.searching
            ? _revealAnimationController.forward()
            : _revealAnimationController.reverse();
      },
    );
  }

  Widget _buildSearchTitle() {
    return SafeArea(
      child: CircularRevealAnimation(
        center: const Offset(0, 0),
        child: Container(
          color: widget.searchContainerColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: widget.backBtnIcon ?? const BackButton(),
                onPressed: () {
                  _onBackPressed();
                },
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: widget.focusNode,
                  decoration: widget.decoration ??
                      InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: kdefaultDecorationHeightOffset,
                        ),
                        hintText: widget.defaultHintText,
                      ),
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  textCapitalization: widget.textCapitalization,
                  style: widget.style,
                  strutStyle: widget.strutStyle,
                  textAlign: widget.textAlign,
                  textAlignVertical: widget.textAlignVertical,
                  textDirection: widget.textDirection,
                  readOnly: widget.readOnly,
                  toolbarOptions: widget.toolbarOptions,
                  showCursor: widget.showCursor,
                  autofocus: widget.autofocus,
                  obscureText: widget.obscureText,
                  autocorrect: widget.autocorrect,
                  smartDashesType: widget.smartDashesType,
                  smartQuotesType: widget.smartQuotesType,
                  enableSuggestions: widget.enableSuggestions,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  expands: widget.expands,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  onSubmitted: widget.onSubmitted,
                  inputFormatters: widget.inputFormatters,
                  enabled: widget.enabled,
                  cursorWidth: widget.cursorWidth,
                  cursorRadius: widget.cursorRadius,
                  cursorColor: widget.cursorColor,
                  selectionHeightStyle: widget.selectionHeightStyle,
                  selectionWidthStyle: widget.selectionWidthStyle,
                  keyboardAppearance: widget.keyboardAppearance,
                  scrollPadding: widget.scrollPadding,
                  dragStartBehavior: widget.dragStartBehavior,
                  enableInteractiveSelection: widget.enableInteractiveSelection,
                  onTap: widget.onTap,
                  buildCounter: widget.buildCounter,
                  scrollController: widget.scrollController,
                  scrollPhysics: widget.scrollPhysics,
                ),
              ),
              _buildClearButton(),
            ],
          ),
        ),
        animation: _revealAnimation,
        centerOffset: _searchBtnPosition,
      ),
    );
  }

  Widget _buildClearButton() {
    if (!_showClearButton) {
      return Container();
    }

    return IconButton(
      icon: widget.clearBtnIcon ??
          const Icon(
            Icons.clear,
          ),
      onPressed: () {
        if (widget.onClearPressed != null) {
          widget.onClearPressed!.call();
        }

        if (widget.onChanged != null) {
          widget.onChanged!.call('');
        }

        _textController.clear();
        _showClearButton = false;
      },
    );
  }

  @override
  void dispose() {
    _revealAnimationController.dispose();
    super.dispose();
  }
}

class CircularRevealAnimation extends StatelessWidget {
  final Alignment? centerAlignment;
  late final Offset centerOffset;
  final double? minRadius;
  final double? maxRadius;
  final Widget child;
  final Animation<double> animation;

  CircularRevealAnimation({
    Key? key,
    required this.child,
    required this.animation,
    required Offset center,
    this.centerAlignment,
    Offset? centerOffset,
    this.minRadius,
    this.maxRadius,
  }) : super(key: key) {
    this.centerOffset = centerOffset ?? center;
    assert(centerAlignment == null || centerOffset == null);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? _) {
        return ClipPath(
          clipper: CircularRevealClipper(
            fraction: animation.value,
            centerAlignment: centerAlignment,
            centerOffset: centerOffset,
            minRadius: minRadius,
            maxRadius: maxRadius,
          ),
          child: child,
        );
      },
    );
  }
}
