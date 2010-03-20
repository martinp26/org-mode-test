FM_PATH=../../framework/

rm -rf "$1"/results
mkdir -p "$1"/results

cd "$1"/input

# run the test

# fixme: there seems to be a difference in the results if emacs is run
#        with --batch, don't do it for now

emacs -q -l "$FM_PATH"/framework.el

cd ../results

# filter output for generalized diffing (generalize timestamps etc.)
"$FM_PATH"/generalize_output.sh < output.org                    > output.org.f
"$FM_PATH"/generalize_output.sh < ../input/expected_output.org  > expected_output.org.f
"$FM_PATH"/generalize_output.sh < visual.txt                    > visual.txt.f
"$FM_PATH"/generalize_output.sh < ../input/expected_visual.txt  > expected_visual.txt.f

# compute actual diff
diff -u output.org.f expected_output.org.f > output.diff
diff -u visual.txt.f expected_visual.txt.f > visual.diff
