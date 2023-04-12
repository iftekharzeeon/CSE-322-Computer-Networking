#!/bin/bash

touch params.txt

# Varying nodes

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params.txt

    tracefile=Nodes/trace_"$number_of_nodes"n.tr
    python3 1805038.py $tracefile
done

python3 graph.py n

rm params.txt

touch params.txt


# Varying flows

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params.txt

    tracefile=Flows/trace_"$number_of_flows"f.tr
    python3 1805038.py $tracefile
done

python3 graph.py f

rm params.txt

touch params.txt

# Varying areas

for((i=0; i<5; i++)); do
    area=`expr 250 + $i \* 250`
    echo $area >> params.txt

    tracefile=Area/trace_"$area"a.tr
    python3 1805038.py $tracefile
done

python3 graph.py a

rm params.txt

touch params.txt