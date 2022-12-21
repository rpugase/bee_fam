import 'package:birthday_gift/core/ui/resources/app_translations.dart';
import 'package:birthday_gift/core/ui/widget/bee_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsPrivacyText extends StatelessWidget {
  const TermsPrivacyText({Key? key}) : super(key: key);

  final privacy = "https://docs.google.com/document/d/1NqB_l9uixHtMkqc4ymHqv7AgQsDeF5p5f5uaJ6YBbB8/edit?usp=sharing";
  final terms = "https://docs.google.com/document/d/1ky1B8sHB-OiQqaqe14FnqlSVlbX0TeslAl9FUjwUT_A/edit?usp=sharing";

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(color: Colors.grey);
    const linkStyle = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);
    final separate = context.strings.terms_and_privacy.split(RegExp("\\|"));
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: separate[0],
        style: defaultStyle,
      ),
      TextSpan(
        text: separate[1],
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            _showTerms(context);
          },
      ),
      TextSpan(
        text: separate[2],
        style: defaultStyle,
      ),
      TextSpan(
        text: separate[3],
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            _showPrivacy(context);
          },
      ),
    ]));
  }

  _showTerms(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return _showLink(context, terms);
        });
  }

  _showPrivacy(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return _showLink(context, privacy);
        });
  }

  Widget _showLink(BuildContext context, String link) {
    return Scaffold(
      appBar: BeeAppBar(context.strings.back),
      body: WebViewWidget(
        controller: WebViewController()
          ..setNavigationDelegate(NavigationDelegate())
          ..loadRequest(Uri.parse(link)),
      ),
    );
  }
}
