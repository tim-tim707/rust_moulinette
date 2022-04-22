if [ "$#" -ne 2 ]; then
    echo "provide practical number and student list"
    exit 1
fi

login="$2"
echo $login "print_request"
timeout 10 ./TP"$1"/tp"$1"-"$login"/web_server/print_request
echo $login "print_resource"
timeout 10 ./TP"$1"/tp"$1"-"$login"/web_server/print_resource
echo $login "single_threaded"
timeout 10 ./TP"$1"/tp"$1"-"$login"/web_server/single_threaded
echo $login "multithreaded"
timeout 10 ./TP"$1"/tp"$1"-"$login"/web_server/multithreaded
echo $login "ttt_server"
./TP"$1"/tp"$1"-"$login"/ttt_server/ttt_server
