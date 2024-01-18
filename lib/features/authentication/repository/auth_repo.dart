import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p_fit/core/constants/firebase_messages.dart';
import 'package:p_fit/core/utilities/error.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepo(),
);

class AuthRepo {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStream => _firebaseAuth.authStateChanges();

  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);

      return right(credential);
    } on FirebaseAuthException catch (e) {
      return left(
        Failure(
          message: FirebaseErrorMessages.extractFromErrorCode(
            e.message!,
          ),
        ),
      );
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, UserCredential>> signInWithNewEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(name);
      return right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(
          Failure(
            message: FirebaseErrorMessages.weakPassword,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return left(
          Failure(
            message: FirebaseErrorMessages.emailAlreadyInUse,
          ),
        );
      } else {
        return left(
          Failure(
            //TO-DO fix the extraxt Error
            message: FirebaseErrorMessages.extractFromErrorCode(e.code),
          ),
        );
      }
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return left(
          Failure(
            message: FirebaseErrorMessages.wrongPassword,
          ),
        );
      } else if (e.code == 'user-not-found') {
        return left(
          Failure(
            message: FirebaseErrorMessages.noUserFound,
          ),
        );
      } else {
        return left(
          Failure(
            message: FirebaseErrorMessages.extractFromErrorCode(e.code),
          ),
        );
      }
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, void>> signUserOut() async {
    try {
      try {
        await GoogleSignIn().disconnect();
      } catch (e) {
        // Ignore
      }
      await _firebaseAuth.signOut();
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, void>> sendPasswordRecoveryEmail(
      {required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(
          Failure(
            message: FirebaseErrorMessages.noUserFound,
          ),
        );
      } else if (e.code == 'invalid-email') {
        return left(
          Failure(
            message: FirebaseErrorMessages.invalidEmailFormat,
          ),
        );
      } else {
        return left(
          Failure(
            message: FirebaseErrorMessages.extractFromErrorCode(e.code),
          ),
        );
      }
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }
}
