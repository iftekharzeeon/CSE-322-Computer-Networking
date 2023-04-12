#!/bin/bash

imagelocation=Images_15

rm params.txt

touch params.txt

# Varying nodes

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params.txt

    # ns 1805038.tcl $number_of_nodes 20 500

    tracefile=Nodes/trace_"$number_of_nodes"n.tr
    # tracefile=trace.tr
    # python3 1805038.py $tracefile
    awk -f parse.awk $tracefile
done

python3 graph.py n $imagelocation

rm params.txt

touch params.txt


# Varying flows

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params.txt

    # ns 1805038.tcl 40 $number_of_flows 500

    tracefile=Flows/trace_"$number_of_flows"f.tr
    # tracefile=trace.tr
    # python3 1805038.py $tracefile
    awk -f parse.awk $tracefile
done

python3 graph.py f $imagelocation

rm params.txt

touch params.txt

# Varying areas

for((i=0; i<5; i++)); do
    area=`expr 250 + $i \* 250`
    echo $area >> params.txt

    # ns 1805038.tcl 40 20 $area

    tracefile=Area/trace_"$area"a.tr
    # tracefile=trace.tr
    # python3 1805038.py $tracefile
    awk -f parse.awk $tracefile
done

python3 graph.py a $imagelocation

rm params.txt