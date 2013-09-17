let help_message () =
  print_endline "Usage: quote SYM";
  print_endline "SYM can be any stock ticker symbol such as AAPL or GOOG"

let parse_symbol s =
  let s1 = List.nth (Util.split s) 0 in
  String.uppercase s1

let _ =
  if Array.length (Sys.argv) <> 2 then help_message () else
  let symbol = parse_symbol Sys.argv.(1) in
  let quote = Stock.get_quote symbol in
  print_float quote;
  print_newline ()
