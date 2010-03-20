for i in test*
do
    framework/run_test.sh "$i" > /dev/null 2>&1
    if [ -s "$i/results/output.diff" -o -s "$i/results/visual.diff" ]
    then
        echo "Test $i FAILED (content)"
    elif [ -e "$i/results/output.diff" -a -e "$i/results/visual.diff" ]
    then
        echo "Test $i OK"
    else
        echo "Test $i FAILED (frame)"
    fi
done
