class Translations {
  static Map<String, Map<String, String>> _translations = {
    'en': {
      'welcome': 'Welcome to SignChat',
      'subtitle': 'Connect through sign language',
      'signIn': 'Sign In',
      'signUp': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'fullName': 'Full Name',
      'createAccount': 'Create Account',
      'welcomeBack': 'Welcome Back!',
      'passwordsNotMatch': 'Passwords do not match',
      'pleaseEnterEmail': 'Please enter your email',
      'pleaseEnterPassword': 'Please enter your password',
      'pleaseEnterName': 'Please enter your name',
      'pleaseConfirmPassword': 'Please confirm your password',
    },
    'ar': {
      'welcome': 'مرحباً بك في SignChat',
      'subtitle': 'تواصل من خلال لغة الإشارة',
      'signIn': 'تسجيل الدخول',
      'signUp': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirmPassword': 'تأكيد كلمة المرور',
      'fullName': 'الاسم الكامل',
      'createAccount': 'إنشاء حساب جديد',
      'welcomeBack': 'مرحباً بعودتك!',
      'passwordsNotMatch': 'كلمات المرور غير متطابقة',
      'pleaseEnterEmail': 'الرجاء إدخال البريد الإلكتروني',
      'pleaseEnterPassword': 'الرجاء إدخال كلمة المرور',
      'pleaseEnterName': 'الرجاء إدخال اسمك',
      'pleaseConfirmPassword': 'الرجاء تأكيد كلمة المرور',
    },
  };

  static String get(String key, bool isEnglish) {
    return _translations[isEnglish ? 'en' : 'ar']?[key] ?? key;
  }
}