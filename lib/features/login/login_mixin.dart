import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orcazap/features/login/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin LoginMixin on State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> nativeGoogleSignIn() async {
    const webClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');
    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: webClientId);
    final googleUser = await googleSignIn.attemptLightweightAuthentication();
    if (googleUser == null) {
      throw AuthException('Failed to sign in with Google.');
    }

    /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
    /// while also granting permission to access user information.
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }
    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
  }
}
