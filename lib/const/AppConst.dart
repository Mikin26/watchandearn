String? isRequired(String value) {
  if (value.isEmpty && value == '') {
    return 'This field must be Required';
  }
}
