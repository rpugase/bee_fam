import 'package:birthday_gift/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class FirebaseAuthRemoteSource {

  final _googleSignIn = GoogleSignIn(
    scopes: [CalendarApi.calendarScope],
  );

  Future<bool> startAuth() async {
    final currentUser = _googleSignIn.currentUser;

    if (currentUser == null) {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      print("Successful google auth");
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final OAuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(googleCredential);

        print("Successful firebase auth");
      }
      return googleUser != null;
    } else {
      print("Current user=${currentUser.displayName}");
    }

    return currentUser != null;
  }

  Future<GoogleSignInAccount?> getAuthorizedUser() async {
    final user = await _googleSignIn.signInSilently();
    Log.i("Authorized user email=${user?.email}");
    return user;
  }

  Stream<User> listenAuth() {
    return FirebaseAuth.instance.userChanges()
    .asyncMap((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!; ${user.email} ${user.displayName} ${user.refreshToken}');
      }
      return Future.value(user);
    });
  }
}
