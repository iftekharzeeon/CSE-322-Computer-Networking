# simulator
set ns [new Simulator]

# ======================================================================
# Define options

set val(chan)         Channel/WirelessChannel  ;# channel type
set val(prop)         Propagation/TwoRayGround ;# radio-propagation model
set val(ant)          Antenna/OmniAntenna      ;# Antenna type
set val(ll)           LL                       ;# Link layer type
set val(ifq)          Queue/RED  ;# Interface queue type
set val(ifqlen)       100                       ;# max packet in ifq
set val(netif)        Phy/WirelessPhy        ;# network interface type
set val(mac)          Mac/802_11            ;# MAC type
set val(rp)           DSDV                     ;# ad-hoc routing protocol 
# =======================================================================

# Number of nodes
set val(nn) [lindex $argv 0]

# Number of flows
set val(nf) [lindex $argv 1]

# Area size
set val(as) [lindex $argv 2]

# Packet Rate
set val(pr) [lindex $argv 3]

set ftp_interval [expr 1.0/$val(pr)]

set val(seed) 23

# =======================================================================
Queue/RED set thresh_queue_ 10
Queue/RED set maxthresh_queue_ 40
Queue/RED set q_weight_ 0.003
Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ false
Queue/RED set gentle_ false
Queue/RED set mean_pktsize_ 1000
Queue/RED set modified_red_ [lindex $argv 4]
Queue/RED set buffer_size 80
Queue/RED set cur_max_p_ 0.1
# =======================================================================

# trace file
set trace_file [open trace_wireless.tr w]
$ns trace-all $trace_file

# nam file
set nam_file [open animation_wireless.nam w]
$ns namtrace-all-wireless $nam_file $val(as) $val(as)

# topology: to keep track of node movements
set topo [new Topography]
$topo load_flatgrid $val(as) $val(as)


# general operation director for mobilenodes
create-god $val(nn)


# node configs
# ======================================================================

# $ns node-config -addressingType flat or hierarchical or expanded
#                  -adhocRouting   DSDV or DSR or TORA
#                  -llType	   LL
#                  -macType	   Mac/802_11
#                  -propType	   "Propagation/TwoRayGround"
#                  -ifqType	   "Queue/DropTail/PriQueue"
#                  -ifqLen	   50
#                  -phyType	   "Phy/WirelessPhy"
#                  -antType	   "Antenna/OmniAntenna"
#                  -channelType    "Channel/WirelessChannel"
#                  -topoInstance   $topo
#                  -energyModel    "EnergyModel"
#                  -initialEnergy  (in Joules)
#                  -rxPower        (in W)
#                  -txPower        (in W)
#                  -agentTrace     ON or OFF
#                  -routerTrace    ON or OFF
#                  -macTrace       ON or OFF
#                  -movementTrace  ON or OFF
#                 -energyModel    "EnergyModel" \

# ======================================================================

$ns node-config -adhocRouting $val(rp) \
                -llType $val(ll) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -ifqLen $val(ifqlen) \
                -antType $val(ant) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -topoInstance $topo \
                -channel [new $val(chan)] \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace OFF \
                -movementTrace OFF \
                -energyModel "EnergyModel" \
                -initialEnergy  90.0 \
                -rxPower        20 \
                -txPower        10 \
                -idlePower 10 \
                -sleepPower 5 \

set val(max) $val(as)
set val(min) 1

expr srand($val(seed))

# create nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    set node($i) [$ns node]
    $node($i) random-motion 0       ;# disable random motion

    # Randomly put x axes and y axes
    $node($i) set X_ [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    $node($i) set Y_ [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    $node($i) set Z_ 0

    $ns initial_node_pos $node($i) 20
    
} 

set val(max) $val(nn)
set val(min) 0

# Traffic
# Initialize one random source
set src [expr int(rand() * ($val(max)-$val(min))) + $val(min)]

puts $src

for {set i 0} {$i < $val(nf)} {incr i} {

    # picking random destination/sink node
    set dest [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    puts $dest
    while {$src == $dest} {
        set dest [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    }

    # puts "$src >> $dest" 
    # puts "-----------------------"

    # Traffic config
    # create agent
    set tcp [new Agent/TCP]
    set tcp_sink [new Agent/TCPSink]

    # /home/zeeon/ns-allinone-2.35/nam-1.15/nam animation_wired.nam

    # attach to nodes
    $ns attach-agent $node($src) $tcp
    $ns attach-agent $node($dest) $tcp_sink

    $tcp set packetSize_ 1000
    $tcp set window_ [expr 10 *($val(pr) / 100)]
    
    # connect agents
    $ns connect $tcp $tcp_sink
    $tcp set fid_ $i

    # $tcp set window_ 15
    # $tcp set packetRate_ $val(pr)

    # Traffic generator
    set ftp [new Application/FTP]
    # attach to agent

    # puts "Interval $ftp_interval"

    $ftp attach-agent $tcp

    # starting traffic/flow generation
    # $ns at [expr int(5 * rand()) + 1] "$ftp start"
    $ns at 1.0 "$ftp start"
}


# End Simulation
# stopping nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at 50.0 "$node($i) reset"
}

# defining terminating procedures
proc finish_simulation {} {
    global ns trace_file nam_file
    $ns flush-trace
    close $trace_file
    close $nam_file
}

proc halt_simulation {} {
    global ns
    puts "Simulation Ending"
    puts "____________________________"
    $ns halt
}

$ns at 50.0001 "finish_simulation"
$ns at 50.0002 "halt_simulation"

# Run simulation
puts "Simulation starting"
puts "^^^^^^^^^^^^^^^^^^^^^^^^^"
$ns run