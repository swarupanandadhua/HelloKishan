String numE2B(String n) {
  String s = "";
  for (int i = 0; i < n.length; i++) {
    switch (n[i]) {
      case '0':
        s += '০';
        break;
      case '1':
        s += '১';
        break;
      case '2':
        s += '২';
        break;
      case '3':
        s += '৩';
        break;
      case '4':
        s += '৪';
        break;
      case '5':
        s += '৫';
        break;
      case '6':
        s += '৬';
        break;
      case '7':
        s += '৭';
        break;
      case '8':
        s += '৮';
        break;
      case '9':
        s += '৯';
        break;
      default:
        s += n[i];
    }
  }
  return s;
}
