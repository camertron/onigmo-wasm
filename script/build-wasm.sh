clang \
	--target=wasm32-wasi \
	--sysroot=/wasi-sdk-29.0-x86_64-linux/share/wasi-sysroot \
	-Oz \
	-flto \
	-c \
	-I wasm -I . -I enc/unicode -I /wasi-sdk-29.0-x86_64-linux/share/wasi-sysroot/include/ \
	regparse.c regcomp.c regexec.c regext.c regerror.c \
	regenc.c regtrav.c regversion.c st.c \
	enc/unicode.c enc/utf_16le.c enc/ascii.c

wasm-ld \
	--export OnigEncodingUTF_16LE \
	--export OnigEncodingASCII \
	--export OnigSyntaxRuby \
	--export OnigDefaultCaseFoldFlag \
	--export onig_new_deluxe \
	--export onig_search \
	--export onig_free \
	--export onig_region_new \
	--export onig_region_free \
	--export onig_error_code_to_str \
	--export malloc \
	--export free \
	--no-entry \
	--allow-undefined \
	--error-limit=0 \
	-o onigmo.wasm \
	-L /wasi-sdk-29.0-x86_64-linux/share/wasi-sysroot/lib/wasm32-wasi/ \
	-l c \
	*.o

wasm-opt -Oz --strip-debug --strip-producers -o onigmo.wasm onigmo.wasm
wasm-strip onigmo.wasm

brotli -f -q 11 -o onigmo.wasm.br onigmo.wasm
gzip -9 -c onigmo.wasm > onigmo.wasm.gz
