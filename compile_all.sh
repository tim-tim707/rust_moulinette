if [ "$#" -ne 2 ]; then
    echo "provide practical number and student list"
    exit 1
fi

mkdir TP"$1"
for login in `cat $2`
do
    echo $login
    make -B -C TP"$1"/tp"$1"-"$login"/web_server
    make -B -C TP"$1"/tp"$1"-"$login"/ttt_server
done
