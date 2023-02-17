#!/bin/bash

wirelessTclFileName=wireless_new
wiredTclFileName=wired_new

wiredTraceFileName=trace_wired
wirelessTraceFileName=trace_wireless

wiredParseFileRed=Parsers/parse_wired_RED
wiredParseFileNaRed=Parsers/parse_wired_NARED

wirelessParseFileRed=Parsers/parse_wireless_RED
wirelessParseFileNaRed=Parsers/parse_wireless_NARED

baseNode=40
baseFlow=20
basePacketRate=200
baseArea=500
redFlag=0
naredFlag=1

echo '----------------------------------------------------------------------------------------------------'
echo 'Wired starting'

# ----------------------------------
# Wired
# ----------------------------------

imagelocation=Images/Wired

rm params_RED.txt
rm params_NARED.txt

touch params_NARED.txt
touch params_RED.txt

# Varying nodes

echo '------------------------------------'
echo 'Varying nodes for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params_RED.txt

    ns $wiredTclFileName.tcl $number_of_nodes $baseFlow $basePacketRate $redFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying nodes for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params_NARED.txt

    ns $wiredTclFileName.tcl $number_of_nodes $baseFlow $basePacketRate $naredFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileNaRed.awk $tracefile
done

python3 summary.py n $imagelocation wd

rm params_RED.txt
rm params_NARED.txt

touch params_RED.txt
touch params_NARED.txt

# Varying flows

echo '------------------------------------'
echo 'Varying flows for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params_RED.txt

    ns $wiredTclFileName.tcl $baseNode $number_of_flows $basePacketRate $redFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying flows for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params_NARED.txt

    ns $wiredTclFileName.tcl $baseNode $number_of_flows $basePacketRate $naredFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileNaRed.awk $tracefile
done

python3 summary.py f $imagelocation wd

rm params_NARED.txt
rm params_RED.txt

touch params_RED.txt
touch params_NARED.txt

# Varying packet rate

echo '------------------------------------'
echo 'Varying packet rate for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    packet_rate=`expr 100 + $i \* 100`
    echo $packet_rate >> params_RED.txt

    ns $wiredTclFileName.tcl $baseNode $baseFlow $packet_rate $redFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying packet rate for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    packet_rate=`expr 100 + $i \* 100`
    echo $packet_rate >> params_NARED.txt

    ns $wiredTclFileName.tcl $baseNode $baseFlow $packet_rate $naredFlag

    tracefile=$wiredTraceFileName.tr
    awk -f $wiredParseFileNaRed.awk $tracefile
done

python3 summary.py p $imagelocation wd

rm params_RED.txt
rm params_NARED.txt


echo 'Wired end'
echo '----------------------------------------------------------------------------------------------------'
echo 'Wireless starting'


# ----------------------------------
# Wireless
# ----------------------------------

imagelocation=Images/Wireless

touch params_NARED.txt
touch params_RED.txt

# Varying nodes

echo '------------------------------------'
echo 'Varying nodes for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params_RED.txt

    ns $wirelessTclFileName.tcl $number_of_nodes $baseFlow $baseArea $basePacketRate $redFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying nodes for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_nodes=`expr 20 + $i \* 20`
    echo $number_of_nodes >> params_NARED.txt

    ns $wirelessTclFileName.tcl $number_of_nodes $baseFlow $baseArea $basePacketRate $naredFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileNaRed.awk $tracefile
done

python3 summary.py n $imagelocation ws

rm params_RED.txt
rm params_NARED.txt

touch params_RED.txt
touch params_NARED.txt

# Varying flows

echo '------------------------------------'
echo 'Varying flows for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params_RED.txt

    ns $wirelessTclFileName.tcl $baseNode $number_of_flows $baseArea $basePacketRate $redFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying flows for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    number_of_flows=`expr 10 + $i \* 10`
    echo $number_of_flows >> params_NARED.txt

    ns $wirelessTclFileName.tcl $baseNode $number_of_flows $baseArea $basePacketRate $naredFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileNaRed.awk $tracefile
done

python3 summary.py f $imagelocation ws

rm params_NARED.txt
rm params_RED.txt

touch params_RED.txt
touch params_NARED.txt

# Varying areas

echo '------------------------------------'
echo 'Varying areas for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    area=`expr 250 + $i \* 250`
    echo $area >> params_RED.txt

    ns $wirelessTclFileName.tcl $baseNode $baseFlow $area $basePacketRate $redFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying areas for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    area=`expr 250 + $i \* 250`
    echo $area >> params_NARED.txt

    ns $wirelessTclFileName.tcl $baseNode $baseFlow $area $basePacketRate $naredFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileNaRed.awk $tracefile
done

python3 summary.py a $imagelocation ws

rm params_NARED.txt
rm params_RED.txt

touch params_NARED.txt
touch params_RED.txt

# Varying packet rate

echo '------------------------------------'
echo 'Varying packet rate for RED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    packet_rate=`expr 100 + $i \* 100`
    echo $packet_rate >> params_RED.txt

    ns $wirelessTclFileName.tcl $baseNode $baseFlow $baseArea $packet_rate $redFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileRed.awk $tracefile
done

echo '------------------------------------'
echo 'Varying packet rate for NARED'
echo '------------------------------------'

for((i=0; i<5; i++)); do
    packet_rate=`expr 100 + $i \* 100`
    echo $packet_rate >> params_NARED.txt

    ns $wirelessTclFileName.tcl $baseNode $baseFlow $baseArea $packet_rate $naredFlag

    tracefile=$wirelessTraceFileName.tr
    awk -f $wirelessParseFileNaRed.awk $tracefile
done

python3 summary.py p $imagelocation ws

rm params_RED.txt
rm params_NARED.txt