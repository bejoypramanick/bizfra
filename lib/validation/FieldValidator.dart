class FieldValidator {
  static String? validateName(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    if (value.length > 50) {
      return 'First name is too long';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'First name can only contain letters and spaces';
    }
    if (value.trim() != value) {
      return 'Leading or trailing spaces are not allowed';
    }
    // Add more validations as needed
    return null;
  }

  static String? validateDob(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }

    DateTime currentDate = DateTime.now();
    DateTime inputDate;
    try {
      inputDate = DateTime.parse(value);
    } catch (e) {
      return 'Invalid date format';
    }

    // Validate if the input is a valid date
    if (inputDate.isAfter(currentDate)) {
      return 'Date of birth cannot be in the future';
    }

    // Validate age restrictions (e.g., minimum age)
    int age = currentDate.year - inputDate.year;
    if (age < 18) {
      return 'You must be at least 18 years old';
    }

    return null;
  }

  static String? validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Use a regular expression to validate the email format
    bool isValidEmail =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);

    if (!isValidEmail) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validateMobile(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }

    // Remove spaces and special characters
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');

    // Validate the number of digits and starting digits
    if (cleanedValue.length != 10 ||
        !cleanedValue.startsWith('7') &&
            !cleanedValue.startsWith('8') &&
            !cleanedValue.startsWith('9')) {
      return 'Please enter a valid Indian mobile number';
    }

    return null;
  }

  static String? validateOrgNm(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the organization name';
    }

    // Validate length
    if (value.length < 2) {
      return 'Organization name is too short';
    }

    // Validate against certain words or phrases (optional)
    List<String> disallowedWords = ['invalid', 'disallowed', 'word'];
    for (String word in disallowedWords) {
      if (value.toLowerCase().contains(word)) {
        return 'Organization name contains disallowed words';
      }
    }

    // Add more specific validation rules as needed

    return null;
  }

  static String? validateAddress(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }

    // Validate length
    if (value.length < 10) {
      return 'Address is too short';
    }

    // Add more specific validation rules as needed

    return null;
  }

  static String? validateWebsite(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the website URL';
    }

    // Validate URL format
    Uri? uri;
    try {
      uri = Uri.parse(value);
    } catch (e) {
      return 'Invalid URL format';
    }

    // Validate that the scheme is http or https
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return 'Please enter a valid http or https URL';
    }
  }

  static String? validateBranches(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of branches';
    }

    // Parse the input as an integer
    int numberOfBranches;
    try {
      numberOfBranches = int.parse(value);
    } catch (e) {
      return 'Please enter a valid number';
    }

    // Validate against a specific range
    if (numberOfBranches < 1 || numberOfBranches > 100) {
      return 'Number of branches must be between 1 and 100';
    }

    return null;
  }

  static String? validateAadharNumber(String aadharNumber) {
    // Aadhar number format: 12 digits
    final RegExp regex = RegExp(r'^\d{12}$');
    if (regex.hasMatch(aadharNumber)) {
      return null;
    } else {
      return "Aahaar Number is not valid";
    }
  }

  static String? validatePanNumber(String panNumber) {
    // PAN number format: 5 uppercase letters, 4 digits, 1 uppercase letter
    final RegExp regex = RegExp(r'^[A-Z]{5}\d{4}[A-Z]{1}$');
    if (regex.hasMatch(panNumber)) {
      return null;
    } else {
      return "PAN is not valid";
    }
  }

  static String? validateGstNumber(String gstNumber) {
    // GST number format: 2 uppercase letters, 10 digits, 1 uppercase letter, 1 digit, 1 uppercase letter
    final RegExp regex = RegExp(r'^[A-Z]{2}\d{10}[A-Z]{1}\d{1}[A-Z]{1}$');
    if (regex.hasMatch(gstNumber)) {
      return null;
    } else {
      return "GST is not valid";
    }
  }
}
