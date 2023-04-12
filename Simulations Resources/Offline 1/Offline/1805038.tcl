# simulator
set ns [new Simulator]

# ======================================================================
# Define options

set val(chan)         Channel/WirelessChannel  ;# channel type
set val(prop)         Propagation/TwoRayGround ;# radio-propagation model
set val(ant)          Antenna/OmniAntenna      ;# Antenna type
set val(ll)           LL                       ;# Link layer type
set val(ifq)          Queue/DropTail/PriQueue  ;# Interface queue type
set val(ifqlen)       50                       ;# max packet in ifq
set val(netif)        Phy/WirelessPhy        ;# network interface type
set val(mac)          Mac/802_11            ;# MAC type
set val(rp)           AODV                     ;# ad-hoc routing protocol 
# =======================================================================

# Number of nodes
set val(nn) [lindex $argv 0]

# Number of flows
set val(nf) [lindex $argv 1]

# Area size
set val(as) [lindex $argv 2]

# trace file
set trace_file [open trace.tr w]
$ns trace-all $trace_file

# nam file
set nam_file [open animation.nam w]
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
                -initialEnergy  3.0 \
                -rxPower        0.9 \
                -txPower        0.5 \
                -idlePower 0.45 \
                -sleepPower 0.05 \

set val(max) $val(as)
set val(min) 1

# create nodes
for {set i 0} {$i < $val(nn)} {incr i} {
    set node($i) [$ns node]
    $node($i) random-motion 0       ;# disable random motion

    # Randomly put x axes and y axes
    $node($i) set X_ [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    $node($i) set Y_ [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    $node($i) set Z_ 0
    # $node($i) set X_ [expr int(10000 * rand()) % $val(as) + 0.5]
    # $node($i) set Y_ [expr int(10000 * rand()) % $val(as) + 0.5]
    # $node($i) set Z_ 0

    $ns initial_node_pos $node($i) 20
    
} 


# producing node movements with uniform random speed
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns at [expr int(20 * rand()) + 10] "$node($i) setdest [expr int(10000 * rand()) % $val(as) + 0.5] [expr int(10000 * rand()) % $val(as) + 0.5] [expr int(100 * rand()) % 5 + 1]"
}

set val(max) $val(nn)
set val(min) 0

# Traffic
# Initialize one random source
set src [expr int(rand() * ($val(max)-$val(min))) + $val(min)]

for {set i 0} {$i < $val(nf)} {incr i} {

    # picking random destination/sink node
    set dest [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    while {$src == $dest} {
        set dest [expr int(rand() * ($val(max)-$val(min))) + $val(min)]
    }

    puts "$src >> $dest" 
    puts "-----------------------"

    # Traffic config
    # create agent
    set tcp [new Agent/TCP/Reno]
    set tcp_sink [new Agent/TCPSink]

    # attach to nodes
    $ns attach-agent $node($src) $tcp
    $ns attach-agent $node($dest) $tcp_sink
    
    # connect agents
    $ns connect $tcp $tcp_sink
    $tcp set fid_ $i

    # Traffic generator
    set ftp [new Application/FTP]
    # attach to agent
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
    $ns halt
}

$ns at 50.0001 "finish_simulation"
$ns at 50.0002 "halt_simulation"

# Run simulation
puts "Simulation starting"
$ns run