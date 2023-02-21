imagelocation=Images/Wireless

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

rm $wiredTraceFileName.tr 
rm $wirelessTraceFileName.tr

rm animation_wired.nam 
rm animation_wireless.nam