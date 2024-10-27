import 'package:archive/widgets/brand_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class EnterQuote extends StatefulWidget {
  final Function(String) onSubmit;

  const EnterQuote({
    required this.onSubmit,
    super.key,
  });

  @override
  State<EnterQuote> createState() => _EnterQuote();
}

class _EnterQuote extends State<EnterQuote> {
  final TextEditingController _quoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: CupertinoTextField(
            placeholder: "Enter Your Quote",
            controller: _quoteController,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          )),
          SizedBox(height: 10),
          BrandButton(
            type: BrandButtonType.accent,
            icon: HeroIcon(
              HeroIcons.viewfinderCircle,
              color: Colors.white,
              size: 18,
            ),
            label: "View Quote",
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onSubmit(_quoteController.text);
            },
          )
        ],
      ),
    );
  }
}
