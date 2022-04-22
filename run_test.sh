#!/bin/sh

cd $(dirname $0)

if [ ! -f src/lib.rs ]; then
	cp src/main.rs src/lib.rs

	# ugly but it is what it is
	# use complete text block instead of multiple sed to pub structures and fields
	sed -i 's/fn/pub fn/g' src/lib.rs
fi

cargo nextest run --test tests --config-file nextest.toml
mv target/default/junit.xml output.xml