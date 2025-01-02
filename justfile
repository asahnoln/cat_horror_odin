alias t := test
alias b := build
alias r := run

collection := '-collection:src=src'
cmd := 'src/cmd'

test:
  odin test tests/ -all-packages {{collection}}

build: test
	odin build {{cmd}} {{collection}}

run: test
	odin run {{cmd}} {{collection}}
