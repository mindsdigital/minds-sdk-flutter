class Endpoint {
  const Endpoint._();
  static String get authentication => "/authentication";
  static String get enrollment => "/enrollment";
  static String get enrollmentVerify => "/enrollment/verify";
  static String get enrollmentCertify => "/enrollment/certify";
  static String get voiceBlocklist => "/blocklist/voices";
  static String get phoneBlocklist => "/blocklist/phone-numbers";
  static String get randomSentence => "/liveness/random-sentence";
  static String get initValidator => "/biometrics/validate-sdk-init";
}
