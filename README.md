## Automatic tests for Rust using nextest

Generate a junit.xml file for each student to test

Use on single student with directory as tarball located at `/student` with
`./entry.sh`. Useful if you want to run with Epita's MaaS

or with a list of students with
`./entry.sh NN list_of_students.txt`. (If you want to run locally)

In this case, `NN` is a two digit practical number and the format of `list_of_students.txt` is a single login per line. Students repository will get cloned from EPITA's repository automatically (crash if not possible)
Example: `./entry.sh 07 list_of_students.txt`


A basic viewer is launched automatically with `firefox viewer/index.html`. You should provide it with the content of `./output` in order to see results. 

This project should be easily modifiable in order to run on Assistants intranet (as of 2022)
A Dockerfile is provided and uses `cargo vendor` in order to get the dependencies using the `./deps/addition` directory

Example test directories are provided as well as the results of the tests running in `./output`. You can add the tests in the `./entry.sh` script and a directory with tests in the current directory to go with it.

## TODO:
- put all scripts in a directory and adapt path
- timeout for tests (in ./deps directory)
- better viewer
- functionnal testing