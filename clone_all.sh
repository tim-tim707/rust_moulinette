if [ "$#" -ne 2 ]; then
    echo "provide practical number and student list"
    exit 1
fi

mkdir TP"$1"
for login in `cat $2`
do
    echo $login
    git clone git@git.cri.epita.fr:p/2025-s4-tp/tp"$1"-"$login" TP"$1"/tp"$1"-"$login"/
done
