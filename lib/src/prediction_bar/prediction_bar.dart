import 'dart:async';

import 'package:flutter/material.dart';

class PredictionBar<T extends Object> extends StatelessWidget {
  PredictionBar({
    Key? key,
    this.decorationBar = const BoxDecoration(color: Colors.white),
    this.decorationTextInput,
    required this.fetchSuggestions,
    FocusNode? focusNode,
    required this.itemBuilder,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.onSuggestionSelected,
    this.paddingBar = const EdgeInsets.all(20.0),
    this.paddingListResults = const EdgeInsets.all(10.0),
    this.width = 500,
  }) : super(key: key) {
    this.focusNode = focusNode ?? FocusNode();
  }

  final EdgeInsets paddingBar;
  final EdgeInsets paddingListResults;
  final MainAxisAlignment mainAxisAlignment;
  final double width;
  final Widget Function(Object _) itemBuilder;
  final BoxDecoration decorationBar;
  final InputDecoration? decorationTextInput;

  final TextEditingController _textEditingController = TextEditingController();
  TextEditingValue get _controllerValue => _textEditingController.value;

  late final FocusNode focusNode;

  final FutureOr<List<T>> Function(String _) fetchSuggestions;
  final Function(T _) onSuggestionSelected;

  String _displayStringForOption(T _) => _.toString();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingBar,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          _buildAutoComplete(),
          ElevatedButton(
            child: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () async {
              T selected = (await _optionsBuilder(_controllerValue)).elementAt(0);
              _textEditingController.text = _displayStringForOption(selected);
              onSuggestionSelected(selected);
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xFF9DD14B), shape: const CircleBorder(), padding: const EdgeInsets.all(20)),
          )
        ],
      ),
    );
  }

  Widget _buildAutoComplete() {
    return Container(
      width: width,
      decoration: decorationBar,
      child: RawAutocomplete<T>(
        displayStringForOption: _displayStringForOption,
        fieldViewBuilder: _fieldViewBuilder,
        focusNode: focusNode,
        optionsBuilder: _optionsBuilder,
        onSelected: onSuggestionSelected,
        optionsViewBuilder: _optionsViewBuilder,
        textEditingController: _textEditingController,
      ),
    );
  }

  Widget _fieldViewBuilder(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, Function() onFieldSubmitted) {
    return TextFormField(
      controller: textEditingController,
      decoration: decorationTextInput,
      focusNode: focusNode,
      onFieldSubmitted: (_) => onFieldSubmitted(),
    );
  }

  Future<List<T>> _optionsBuilder(TextEditingValue value) async {
    if (value.text == '') return List<T>.empty();

    List<T> _currentList = (await fetchSuggestions(value.text)).where((T _) {
      return _displayStringForOption(_).toLowerCase().contains(value.text.toLowerCase());
    }).toList();

    return _currentList;
  }

  Widget _optionsViewBuilder(BuildContext context, AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          child: ListView.builder(
            padding: paddingListResults,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return itemBuilder(options.elementAt(index));
            },
          ),
        ),
      ),
    );
  }
}
