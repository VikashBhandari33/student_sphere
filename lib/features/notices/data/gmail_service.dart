import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:student_sphere/core/errors/exceptions.dart';

class GmailService {
  final GoogleSignIn _googleSignIn;

  GmailService(this._googleSignIn);

  Future<List<Message>> fetchImportantEmails() async {
    try {
      var httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        await _googleSignIn.signInSilently();
        httpClient = await _googleSignIn.authenticatedClient();
      }

      if (httpClient == null) {
        throw ServerException('User not authenticated');
      }

      final gmailApi = GmailApi(httpClient);
      final response = await gmailApi.users.messages.list(
        'me',
        q: 'is:important',
        maxResults: 10,
      );

      final messages = <Message>[];
      if (response.messages != null) {
        for (final message in response.messages!) {
          final fullMessage =
              await gmailApi.users.messages.get('me', message.id!);
          messages.add(fullMessage);
        }
      }
      return messages;
    } catch (e) {
      throw ServerException('Failed to fetch emails: $e');
    }
  }
}
