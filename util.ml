let split s =
  List.map String.trim (Str.split (Str.regexp ",") s)
