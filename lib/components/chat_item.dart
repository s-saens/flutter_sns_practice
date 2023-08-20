import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  final String email;
  final String message;
  final DateTime timestamp;
  final bool isMine;

  const ChatItem({
    Key? key,
    required this.email,
    required this.message,
    required this.timestamp,
    required this.isMine,
  }) : super(key: key);

  dateFormat() {
    return DateFormat("HH:mm:ss").format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Radius borderRadius = const Radius.circular(20);
    Radius zeroRadius = const Radius.circular(0);

    return Padding(
      padding: EdgeInsets.only(
        left: isMine ? 70 : 20,
        right: isMine ? 20 : 70,
        top: 10,
        bottom: 10,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withAlpha(isMine ? 100 : 0),
            border: Border.all(
              color: colorScheme.primary,
              width: 0.5,
            ),
            borderRadius: BorderRadius.only(
              topLeft: isMine ? borderRadius : zeroRadius,
              topRight: isMine ? zeroRadius : borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    isMine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dateFormat(), style: textTheme.labelMedium),
                              Text(
                                "me",
                                style: textTheme.labelMedium,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(email, style: textTheme.labelMedium),
                              Text(dateFormat(), style: textTheme.labelMedium),
                            ],
                          ),
                    const SizedBox(height: 10),
                    Text(
                      message,
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
