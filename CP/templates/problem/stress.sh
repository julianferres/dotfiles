for((i = 1; ; ++i)); do
    echo $i
    ./gen $i > int
    # ./bad < int > out1
    # ./brute < int > out2
    # diff -w out1 out2 || break
    diff -w <(./bad < int) <(./brute < int) || break
done
