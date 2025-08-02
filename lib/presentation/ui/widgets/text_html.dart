import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modals/snack_bar/snack_bar_factory.dart';

class TextHtml extends StatelessWidget {
  final String? text;
  final Map<String, Style>? style;
  const TextHtml({
    super.key,
    required this.text,
    this.style,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Html(
      style: style ?? {},
      data: text,
      onAnchorTap: (uri, attributes, element) async {
        if (uri != null) {
          final Uri url = Uri.parse(uri);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            if (context.mounted) {
              SnackbarFactory.showError("Can not launch URL");
            }
          }
        }
      },
      onLinkTap: (uri, map, e) async {
        if (uri != null) {
          final Uri url = Uri.parse(uri);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            if (context.mounted) {
              SnackbarFactory.showError("Can not launch URL");
            }
          }
        }
      },
    );
  }
}
