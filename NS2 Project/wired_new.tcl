#Create a simulator object

set ns [new Simulator]

# Number of nodes
set val(nn) [lindex $argv 0]

# Number of flows
set val(nf) [lindex $argv 1] 

# Packet Rate
set val(pr) [lindex $argv 2] 

set val(qlimit) 100
set val(start_time) 1.0
set val(end_time) 150

set val(seed) 23

# =======================================================================
Queue/RED set thresh_queue_ 10
Queue/RED set maxthresh_queue_ 40
Queue/RED set q_weight_ 0.003
Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ false
Queue/RED set gentle_ false
Queue/RED set mean_pktsize_ 100
Queue/RED set modified_red_ [lindex $argv 3] 
Queue/RED set buffer_size 80
Queue/RED set cur_max_p_ 0.1
# =======================================================================

#
# Create a simple six node topology:
#
#        s1                 d1
#         \                 /
#          \               / 
#     s2 _ _ r1 --------- r2 _ _ d2 
#          /               \ 
#         /                 \
#        s3                 d3 
#


#Open the NAM file and trace file
set nam_file [open animation_wired.nam w]
set trace_file [open trace_wired.tr w]
$ns namtrace-all $nam_file
$ns trace-all $trace_file

# Create 2 routers
set node_(r1) [$ns node]
set node_(r2) [$ns node]

# Update node numbers
set val(nn) [expr {$val(nn) - 2}]

puts "Number of nodes without routers $val(nn)"

# Create links between the routers
$ns duplex-link $node_(r1) $node_(r2) 1Mb 30ms RED 

# Set queue limit for the routers
$ns queue-limit $node_(r1) $node_(r2) $val(qlimit)
$ns queue-limit $node_(r2) $node_(r1) $val(qlimit)
$ns duplex-link-op $node_(r1) $node_(r2) orient right
$ns duplex-link-op $node_(r1) $node_(r2) queuePos 0
$ns duplex-link-op $node_(r2) $node_(r1) queuePos 0

# create nodes
for {set i 0} {$i < [expr {$val(nn) / 2}]} {incr i} {

    # Source Nodes
    set node_(s$i) [$ns node]
    # Create link between the source nodes & r1
    $ns duplex-link $node_(s$i) $node_(r1) 15Mb 10ms RED 

    # Destination Nodes
    set node_(d$i) [$ns node] 
    # Create link between the dest nodes & r2
    $ns duplex-link $node_(d$i) $node_(r2) 15Mb 10ms RED
}

set val(max) [expr {$val(nn) / 2}]
set val(min) 0

expr srand($val(seed))

#Setup flows

for {set i 0} {$i < $val(nf)} {incr i} {

    set src [expr int(rand() * ($val(max)-$val(min)))]
    set dest [expr int(rand() * ($val(max)-$val(min)))]
    

    set tcp [new Agent/TCP]
    $ns attach-agent $node_(s$src) $tcp
    set sink [new Agent/TCPSink]
    $ns attach-agent $node_(d$dest) $sink
    $ns connect $tcp $sink
    $tcp set fid_ $i

    $tcp set packetSize_ 1000
    $tcp set window_ [expr 10 *($val(pr) / 100)]

    set ftp [new Application/FTP]
    $ftp attach-agent $tcp
    $ftp set type_ FTP

    $ns at $val(start_time) "$ftp start"
    $ns at $val(end_time) "$ftp stop"
    
}

#Define a 'finish' procedure
proc finish {} {
    global ns nam_file trace_file
    $ns flush-trace 
    #Close the NAM trace file
    close $nam_file
    close $trace_file
    #Execute NAM on the trace file
    # exec nam out.nam &
    exit 0
}


#Detach tcp and sink agents (not really necessary)
# $ns at 4.9 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at $val(end_time) "finish"

#Run the simulation
$ns run
