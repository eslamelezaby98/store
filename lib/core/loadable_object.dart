class LoadableObject<T> {
  bool isLoading;
  T data;
  String errorMessage;

  LoadableObject(
      {this.isLoading = false, required this.data, this.errorMessage = ""});
  void clear() {
    isLoading = false;
    errorMessage = "";
  }
}
