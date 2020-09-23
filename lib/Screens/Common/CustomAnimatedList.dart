import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

typedef Widget FirestoreAnimatedListItemBuilder(
  BuildContext context,
  DocumentSnapshot snapshot,
  Animation<double> animation,
  int index,
);

class CustomAnimatedList extends StatefulWidget {
  CustomAnimatedList({
    Key key,
    @required this.query,
    @required this.itemBuilder,
    this.defaultChild,
    this.errorChild,
    this.emptyChild,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Query query;
  final Widget defaultChild;
  final Widget errorChild;
  final Widget emptyChild;
  final FirestoreAnimatedListItemBuilder itemBuilder;
  final Axis scrollDirection;
  final ScrollController controller;
  final Duration duration;

  @override
  CustomAnimatedListState createState() => CustomAnimatedListState();
}

class CustomAnimatedListState extends State<CustomAnimatedList> {
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  FirestoreList _model;
  String _error;
  bool _loaded = false;

  _updateModel() {
    _model?.clear();
    _model = FirestoreList(
      query: widget.query,
      onDocumentAdded: _onDocumentAdded,
      onDocumentRemoved: _onDocumentRemoved,
      onDocumentChanged: _onDocumentChanged,
      onError: _onError,
    );
  }

  @override
  void initState() {
    _updateModel();
    super.initState();
  }

  @override
  void didUpdateWidget(CustomAnimatedList oldWidget) {
    if (!DeepCollectionEquality.unordered().equals(
        oldWidget.query.parameters, widget.query.parameters)) _updateModel();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _model.clear();
    super.dispose();
  }

  void _onError(Error error) {
    if (mounted) {
      setState(() {
        error = error;
      });
    }
  }

  void _onDocumentAdded(int index, DocumentSnapshot snapshot) {
    try {
      if (mounted) {
        setState(() {
          _animatedListKey.currentState
              ?.insertItem(index, duration: widget.duration);
        });
      }
    } catch (error) {
      _model.log("Failed to run onDocumentAdded");
    }
  }

  void _onDocumentRemoved(int index, DocumentSnapshot snapshot) {
    // The child should have already been removed from the model by now
    assert(!_model.contains(snapshot));
    if (mounted) {
      try {
        setState(() {
          _animatedListKey.currentState?.removeItem(
            index,
            (BuildContext context, Animation<double> animation) {
              return widget.itemBuilder(context, snapshot, animation, index);
            },
            duration: widget.duration,
          );
        });
      } catch (error) {
        _model.log("Failed to remove Widget on index $index");
      }
    }
  }

  // No animation, just update contents
  void _onDocumentChanged(int index, DocumentSnapshot snapshot) {
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return widget.itemBuilder(context, _model[index], animation, index);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_loaded && _model.isEmpty) {
      return widget.emptyChild ?? Container();
    }

    if (_error != null && _error.isNotEmpty) {
      return widget.errorChild ?? const Center(child: Icon(Icons.error));
    }

    return AnimatedList(
      key: _animatedListKey,
      itemBuilder: _buildItem,
      initialItemCount: _model.length,
      scrollDirection: widget.scrollDirection,
      controller: widget.controller,
    );
  }
}
