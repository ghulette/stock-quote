open Http_client.Convenience
open Neturl
open Netencoding.Url
open Printf

let guard p f =
  if p then f () else ()

let split s =
  List.map String.trim (Str.split (Str.regexp ",") s)

let yahoo_finance_url symbol =
  let http_syntax = Hashtbl.find common_url_syntax "http" in
  let host = "quote.yahoo.com" in
  let path = split_path "/d" in
  let query = mk_url_encoded_parameters [("f","nl1");("s",symbol)] in
  make_url ~encoded:true 
           ~scheme:"http" 
           ~host:host 
           ~path:path 
           ~query:query 
           http_syntax

let fetch_quote symbol =
  let url = yahoo_finance_url symbol in
  let r = http_get (string_of_url url) in
  let rs = split r in
  float_of_string (List.nth rs 1)

let help_message () =
  print_endline "Usage: quote SYM";
  print_endline "SYM can be any stock ticker symbol such as AAPL or GOOG"

let parse_symbol s =
  let s1 = List.nth (split s) 0 in
  String.uppercase s1

let _ =
  guard (Array.length (Sys.argv) <> 2) help_message;
  let symbol = parse_symbol Sys.argv.(1) in
  let quote = fetch_quote symbol in
  printf "Quote for %s: %f\n" symbol quote;
