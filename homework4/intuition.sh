#!/bin/bash

declare -a numbers
hits=0
misses=0
step=1

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

while true; do
    my_number=$((RANDOM % 10))
    numbers+=("$my_number")

    echo "Step: $step"
    read -p "Please enter number from 0 to 9 (q - quit): " user_input

    if [[ "$user_input" == "q" ]]; then
        break
    fi

    if ! [[ "$user_input" =~ ^[0-9]$ ]]; then
        echo "Input error!"
        continue
    fi

    if [[ "$user_input" -eq "$my_number" ]]; then
        echo -e "Hit! My number: ${GREEN}$my_number${RESET}"
        hits=$((hits + 1))
    else
        echo -e "Miss! My number: ${RED}$my_number${RESET}"
        misses=$((misses + 1))
    fi

    total=$((hits + misses))
    if [[ $total -gt 0 ]]; then
        hit_percentage=$((hits * 100 / total))
        miss_percentage=$((misses * 100 / total))
    else
        hit_percentage=0
        miss_percentage=0
    fi

    echo "Hit: $hit_percentage% Miss: $miss_percentage%"
    
    echo -n "Numbers: "
    for i in "${!numbers[@]}"; do
        if [[ "${numbers[$i]}" -eq "$my_number" && "$user_input" -eq "$my_number" ]]; then
            echo -e -n "${GREEN}${numbers[$i]}${RESET} "
        else
            echo -e -n "${RED}${numbers[$i]}${RESET} "
        fi
    done
    echo ""

    step=$((step + 1))

    if [[ ${#numbers[@]} -gt 10 ]]; then
        numbers=("${numbers[@]:1}")
    fi
done
