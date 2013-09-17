SOURCES = util.mli util.ml \
          stock.mli stock.ml \
          main.ml
PACKS = netclient
RESULT = quote

all: native-code

include OCamlMakefile
