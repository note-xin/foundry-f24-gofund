#!/bin/bash
# loading.sh

i=0
cat_face1=" =( °w° )="
cat_face2=" =( ^w^ )="

echo -e "   /\\_/\\"
printf "\033[s$cat_face2"
echo -e "\n"
# Start an infinite loop to display the loading animation
while kill -0 $1 2>/dev/null
do
    printf "\r"
    if [ $((i%2)) -eq 0 ]
    then
        printf "\033[u\033[K$cat_face1"
    else
        printf "\033[u\033[K$cat_face2"
    fi

    i=$((i+1))
    sleep 0.5
done
printf "\033[K\n"
