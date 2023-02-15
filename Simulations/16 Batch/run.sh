#!/bin/bash

# starting by creating file for recording statistics
echo -e "\n------------------ run.sh: starting -----------------\n"
touch stat.st

# defining baseline parameters
baseline_area_side=500
baseline_nodes=40
baseline_flows=20

# generating statistics and plotting graphs 
# by running simulation with varying area size and parsing generated trace files
echo -e "Area-Size-(m/side)\nNetwork-Throughtput-(kilobits/sec) End-to-End-Avg-Delay-(sec) Packet-Delivery-Ratio-(%) Packet-Drop-Ratio-(%)" > stat.st
echo -e "------------- run.sh: varying area size -------------\n"

for((i=0; i<5; i++)); do
    area_side=`expr 250 + $i \* 250`
    echo -e $area_side >> stat.st

    echo -e "ns.tcl: running with $area_side $baseline_nodes $baseline_flows\n"
    ns ns.tcl $area_side $baseline_nodes $baseline_flows
    echo -e "\nparser.py: running\n"
    python parser.py
done

echo -e "plotter.py: running\n"
python plotter.py

# generating statistics and plotting graphs 
# by running simulation with varying number of nodes and parsing generated trace files
echo -e "Number-of-Nodes\nNetwork-Throughtput-(kilobits/sec) End-to-End-Avg-Delay-(sec) Packet-Delivery-Ratio-(%) Packet-Drop-Ratio-(%)" > stat.st
echo -e "---------- run.sh: varying number of nodes ----------\n"

for((i=0; i<5; i++)); do
    nodes=`expr 20 + $i \* 20`
    echo -e $nodes >> stat.st

    echo -e "ns.tcl: running with $baseline_area_side $nodes $baseline_flows\n"
    ns ns.tcl $baseline_area_side $nodes $baseline_flows
    echo -e "\nparser.py: running\n"
    python parser.py
done

echo -e "plotter.py: running\n"