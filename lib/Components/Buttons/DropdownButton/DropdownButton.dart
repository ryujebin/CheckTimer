import 'package:flutter/material.dart';
import '../../../Core/theme/colors.dart';

class Dropdown<T> extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final double? width;

  const Dropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.width,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  bool isOpen = false;

  void toggleDropdown() {
    if (isOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  void selectItem(T item) {
    widget.onChanged(item);
    _removeDropdown();
    setState(() {
      isOpen = false;
    });
  }

  void _showDropdown() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width ?? size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height - 92),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.map((item) {
                  return InkWell(
                    onTap: () => selectItem(item),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = (widget.width ?? screenWidth - 94).clamp(0, screenWidth);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          CompositedTransformTarget(
            link: _layerLink,
            child: Container(
              width: fieldWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.primary,
                  width: isOpen ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: InkWell(
                onTap: toggleDropdown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.value?.toString() ?? widget.hintText,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w300,
                          color: Color(0xFFA6A6A6),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
