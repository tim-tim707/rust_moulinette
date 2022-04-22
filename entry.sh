#!/bin/sh

set -x

test_exercise() {
    static_check="$3"
    [ -d "$1" ] && mkdir -p "$1/.cargo" && cp /deps/addition "$1/.cargo/config.toml"
    rm -f "$1/Cargo.lock" || true
    python3 compilation_check.py "$2"_output.xml "$1"
    if [ "$?" -ne 0 ]; then
        python3 merge_xml.py output.xml "$2"_output.xml
        rm "$2"_output.xml
        return 1
    fi

    if [ ! -z "$static_check" ]; then
        python3 "$3" "$2"_output.xml "$1"/
        if [ "$?" -ne 0 ]; then
            python3 merge_xml.py output.xml "$2"_output.xml
            rm "$2"_output.xml
            return 1
        fi
    fi

    # Setup files 
    cp run_test.sh "$1"/run_test.sh
    cp nextest.toml "$1"/nextest.toml
    rm -rf "$1"/tests
    cp -r "$2" "$1"/tests

    # run tests
    ./"$1"/run_test.sh
    mv "$1"/output.xml "$2"_output.xml

    python3 merge_xml.py output.xml "$2"_output.xml
    rm "$2"_output.xml
}

# add tests here

if [ ! -z "$1" -a ! -z "$2" ]; then
    echo "Practical nb is ""$1"
    echo "student file list is ""$2"
    ./clone_all.sh "$1" "$2"
    for student in `cat $2`
    do
        echo "$student"
        dir_to_test="TP""$1"/tp"$1"-"$student"

        rm output.xml
        # Add tests here
        # test_exercise directory_to_test_containing_src_dir directory_containing_tests optional_additional_checks

        # Good and bad tests
        test_exercise "$dir_to_test"/"hello_word" "test_hello_word"

        # Create a check_forbidden error, but you can use your own check scripts that return 0 if OK and !0 on error
        test_exercise "$dir_to_test"/"add_one" "test_add_one" "check_forbidden.py"

        # Create an architecture failure
        test_exercise "$dir_to_test"/"does_not_exist" "test_does_not_exist"

        mv output.xml output/"$student"_output.xml
    done

    firefox viewer/index.html
else
    # Assistant intranet case. Tarball is a tar.gz at /student.
    # Code is in student_dir
    # Result must be /output.
    # Runned in a docker using our Dockerfile
    tar -xf /student -C /student_dir

    # Good and bad tests
    test_exercise "student_dir/student/hello_word" "test_hello_word"

    # Create a check_forbidden error, but you can use your own check scripts that return 0 if OK and !0 on error
    test_exercise "student_dir/student/add_one" "test_add_one" "check_forbidden.py"

    # Create an architecture failure
    test_exercise "student_dir/student/does_not_exist" "test_does_not_exist"

    mv output.xml /output
fi

exit 0
