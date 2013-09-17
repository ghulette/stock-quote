open Http_client.Convenience
open Neturl
open Netencoding.Url

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

let get_quote symbol =
  let url = yahoo_finance_url symbol in
  let r = http_get (string_of_url url) in
  let rs = Util.split r in
  float_of_string (List.nth rs 1)
