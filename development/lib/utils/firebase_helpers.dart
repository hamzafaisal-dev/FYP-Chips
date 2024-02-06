import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionErrors {
  static String getFirebaseError(FirebaseAuthException error) {
    String errorStatement;

    switch (error.code) {
      case 'auth/claims-too-large':
        errorStatement =
            'The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.';
        break;

      case 'auth/email-already-exists':
        errorStatement =
            'The provided email is already in use by an existing user. Each user must have a unique email.';
        break;

      case 'auth/id-token-expired':
        errorStatement = 'The provided Firebase ID token is expired.';
        break;

      case 'auth/id-token-revoked':
        errorStatement = 'The Firebase ID token has been revoked.';
        break;

      case 'auth/insufficient-permission':
        errorStatement =
            'The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource. Refer to Set up a Firebase project for documentation on how to generate a credential with appropriate permissions and use it to authenticate the Admin SDKs.';
        break;

      case 'auth/internal-error':
        errorStatement =
            'The Authentication server encountered an unexpected error while trying to process the request. The error message should contain the response from the Authentication server containing additional information. If the error persists, please report the problem to our Bug Report support channel.';
        break;

      case 'auth/invalid-argument':
        errorStatement =
            'An invalid argument was provided to an Authentication method. The error message should contain additional information.';
        break;

      case 'auth/invalid-claims':
        errorStatement =
            'The custom claim attributes provided to setCustomUserClaims() are invalid.';
        break;

      case 'auth/invalid-continue-uri':
        errorStatement = 'The continue URL must be a valid URL string.';
        break;

      case 'auth/invalid-creation-time':
        errorStatement = 'The creation time must be a valid UTC date string.';
        break;

      case 'auth/invalid-credential':
        errorStatement =
            'The credential used to authenticate the Admin SDKs cannot be used to perform the desired action. Certain Authentication methods such as createCustomToken() and verifyIdToken() require the SDK to be initialized with a certificate credential as opposed to a refresh token or Application Default credential. See Initialize the SDK for documentation on how to authenticate the Admin SDKs with a certificate credential.';
        break;

      case 'auth/invalid-disabled-field':
        errorStatement =
            'The provided value for the disabled user property is invalid. It must be a boolean.';
        break;

      case 'auth/invalid-display-name':
        errorStatement =
            'The provided value for the displayName user property is invalid. It must be a non-empty string.';
        break;

      case 'auth/invalid-dynamic-link-domain':
        errorStatement =
            'The provided dynamic link domain is not configured or authorized for the current project.';
        break;

      case 'auth/invalid-email':
        errorStatement =
            'The provided value for the email user property is invalid. It must be a string email address.';
        break;

      case 'auth/invalid-email-verified':
        errorStatement =
            'The provided value for the emailVerified user property is invalid. It must be a boolean.';
        break;

      case 'auth/invalid-hash-algorithm':
        errorStatement =
            'The hash algorithm must match one of the strings in the list of supported algorithms.';
        break;

      case 'auth/invalid-hash-block-size':
        errorStatement = 'The hash block size must be a valid number.';
        break;

      case 'auth/invalid-hash-derived-key-length':
        errorStatement = 'The hash derived key length must be a valid number.';
        break;

      case 'auth/invalid-hash-key':
        errorStatement = 'The hash key must be a valid byte buffer.';
        break;

      case 'auth/invalid-hash-memory-cost':
        errorStatement = 'The hash memory cost must be a valid number.';
        break;

      case 'auth/invalid-hash-parallelization':
        errorStatement = 'The hash parallelization must be a valid number.';
        break;

      case 'auth/invalid-hash-rounds':
        errorStatement = 'The hash rounds must be a valid number.';
        break;

      case 'auth/invalid-hash-salt-separator':
        errorStatement =
            'The hashing algorithm salt separator field must be a valid byte buffer.';
        break;

      case 'auth/invalid-id-token':
        errorStatement =
            'The provided ID token is not a valid Firebase ID token.';
        break;

      case 'auth/invalid-last-sign-in-time':
        errorStatement =
            'The last sign-in time must be a valid UTC date string.';
        break;

      case 'auth/invalid-page-token':
        errorStatement =
            'The provided next page token in listUsers() is invalid. It must be a valid non-empty string.';
        break;

      case 'auth/invalid-password':
        errorStatement =
            'The provided value for the password user property is invalid. It must be a string with at least six characters.';
        break;

      case 'auth/invalid-password-hash':
        errorStatement = 'The password hash must be a valid byte buffer.';
        break;

      case 'auth/invalid-password-salt':
        errorStatement = 'The password salt must be a valid byte buffer.';
        break;

      case 'auth/invalid-phone-number':
        errorStatement =
            'The provided value for the phoneNumber is invalid. It must be a non-empty E.164 standard compliant identifier string.';
        break;

      case 'auth/invalid-photo-url':
        errorStatement =
            'The provided value for the photoURL user property is invalid. It must be a string URL.';
        break;

      case 'auth/invalid-provider-data':
        errorStatement =
            'The providerData must be a valid array of UserInfo objects.';
        break;

      case 'auth/invalid-provider-id':
        errorStatement =
            'The providerId must be a valid supported provider identifier string.';
        break;

      case 'auth/invalid-oauth-responsetype':
        errorStatement =
            'Only exactly one OAuth responseType should be set to true.';
        break;

      case 'auth/invalid-session-cookie-duration':
        errorStatement =
            'The session cookie duration must be a valid number in milliseconds between 5 minutes and 2 weeks.';
        break;

      case 'auth/invalid-uid':
        errorStatement =
            'The provided uid must be a non-empty string with at most 128 characters.';
        break;

      case 'auth/invalid-user-import':
        errorStatement = 'The user record to import is invalid.';
        break;

      case 'auth/maximum-user-count-exceeded':
        errorStatement =
            'The maximum allowed number of users to import has been exceeded.';
        break;

      case 'auth/missing-android-pkg-name':
        errorStatement =
            'An Android Package Name must be provided if the Android App is required to be installed.';
        break;

      case 'auth/missing-continue-uri':
        errorStatement =
            'A valid continue URL must be provided in the request.';
        break;

      case 'auth/missing-hash-algorithm':
        errorStatement =
            'Importing users with password hashes requires that the hashing algorithm and its parameters be provided.';
        break;

      case 'auth/missing-ios-bundle-id':
        errorStatement = 'The request is missing a Bundle ID.';
        break;

      case 'auth/missing-uid':
        errorStatement =
            'A uid identifier is required for the current operation.';
        break;

      case 'auth/missing-oauth-client-secret':
        errorStatement =
            'The OAuth configuration client secret is required to enable OIDC code flow.';
        break;

      case 'auth/operation-not-allowed':
        errorStatement =
            'The provided sign-in provider is disabled for your Firebase project. Enable it from the Sign-in Method section of the Firebase console.';
        break;

      case 'auth/phone-number-already-exists':
        errorStatement =
            'The provided phoneNumber is already in use by an existing user. Each user must have a unique phoneNumber.';
        break;

      case 'auth/project-not-found':
        errorStatement =
            'No Firebase project was found for the credential used to initialize the Admin SDKs. Refer to Set up a Firebase project for documentation on how to generate a credential for your project and use it to authenticate the Admin SDKs.';
        break;

      case 'auth/reserved-claims':
        errorStatement =
            'One or more custom user claims provided to setCustomUserClaims() are reserved. For example, OIDC specific claims such as (sub, iat, iss, exp, aud, auth_time, etc) should not be used as keys for custom claims.';
        break;

      case 'auth/session-cookie-expired':
        errorStatement = 'The provided Firebase session cookie is expired.';
        break;

      case 'auth/session-cookie-revoked':
        errorStatement = 'The Firebase session cookie has been revoked.';
        break;

      case 'auth/too-many-requests':
        errorStatement = 'The number of requests exceeds the maximum allowed.';
        break;

      case 'auth/uid-already-exists':
        errorStatement =
            'The provided uid is already in use by an existing user. Each user must have a unique uid.';
        break;

      case 'auth/unauthorized-continue-uri':
        errorStatement =
            'The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase Console.';
        break;

      case 'auth/user-not-found':
        errorStatement =
            'There is no existing user record corresponding to the provided identifier.';
        break;

      default:
        errorStatement = error.message.toString();
    }

    return errorStatement;
  }
}
