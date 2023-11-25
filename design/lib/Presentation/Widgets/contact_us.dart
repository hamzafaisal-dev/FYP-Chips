import 'package:design/Common/responsiveness.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = Responsiveness.sw(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // punga
        Padding(
          padding: EdgeInsets.only(
            top: sw * 0.036,
            bottom: sw * 0.036,
          ),
          child: Container(
            width: sw * 0.09,
            height: sw * 0.0108,
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.all(Radius.circular(sw * 0.09)),
            ),
          ),
        ),

        // "contact us" title/heading
        Padding(
          padding: EdgeInsets.only(
            left: sw * 0.036,
            right: sw * 0.036,
            bottom: sw * 0.018,
          ),
          child: Row(
            children: [
              Text(
                'Contact Us',
                style: TextStyle(fontSize: sw * 0.05070993914807303),
              ),
            ],
          ),
        ),

        // textbox where user types in message with hint text "Send us a message..."
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.036,
          ),
          child: const TextField(
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Send us a message...",
            ),
          ),
        ),

        // space
        SizedBox(height: sw * 0.018),

        // send button
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw * 0.036,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send_outlined),
              ),
            ],
          ),
        ),

        // spacing
        SizedBox(height: sw * 0.036),
      ],
    );
  }
}
