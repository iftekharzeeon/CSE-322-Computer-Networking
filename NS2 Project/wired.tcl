#Create a simulator object

# =======================================================================
Queue/RED set thresh_queue_ 10
Queue/RED set maxthresh_queue_ 40
Queue/RED set q_weight_ 0.003
Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ false
Queue/RED set gentle_ false
Queue/RED set mean_pktsize_ 100
Queue/RED set modified_red_ 1
Queue/RED set buffer_size 80
Queue/RED set cur_max_p_ 0.1
# =======================================================================

set ns [new Simulator]

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


#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Yellow

#Open the NAM file and trace file
set nam_file [open animation_wired.nam w]
set trace_file [open trace_wired.tr w]
$ns namtrace-all $nam_file
$ns trace-all $trace_file

#Create six nodes
set node_s1 [$ns node]
set node_s2 [$ns node]
set node_s3 [$ns node]
set node_r1 [$ns node]
set node_r2 [$ns node]
set node_d1 [$ns node]
set node_d2 [$ns node]
set node_d3 [$ns node]

#Create links between the nodes
# ns <link-type> <node1> <node2> <bandwidht> <delay> <queue-type-of-node2>
$ns duplex-link $node_s1 $node_r1 15Mb 10ms RED 
$ns duplex-link $node_s2 $node_r1 15Mb 10ms RED 
$ns duplex-link $node_s3 $node_r1 15Mb 10ms RED 
$ns duplex-link $node_r1 $node_r2 1Mb 30ms RED 
$ns queue-limit $node_r1 $node_r2 100
$ns queue-limit $node_r2 $node_r1 100
$ns duplex-link $node_d1 $node_r2 15Mb 30ms RED 
$ns duplex-link $node_d2 $node_r2 15Mb 30ms RED 
$ns duplex-link $node_d3 $node_r2 15Mb 30ms RED 

#Give node position (for NAM)
$ns duplex-link-op $node_s1 $node_r1 orient right-down
$ns duplex-link-op $node_s2 $node_r1 orient right-down
$ns duplex-link-op $node_s3 $node_r1 orient right-down
$ns duplex-link-op $node_r1 $node_r2 orient right
$ns duplex-link-op $node_r1 $node_r2 queuePos 0
$ns duplex-link-op $node_r2 $node_r1 queuePos 0
$ns duplex-link-op $node_d1 $node_r2 orient left-up
$ns duplex-link-op $node_d2 $node_r2 orient left-up
$ns duplex-link-op $node_d3 $node_r2 orient left-up


#Setup a TCP connection 1
#Setup a flow
set tcp1 [new Agent/TCP]
$ns attach-agent $node_s1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $node_d1 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

#Setup a FTP Application over TCP connection 1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP


#Setup a TCP connection 2
#Setup a flow
set tcp2 [new Agent/TCP]
$ns attach-agent $node_s2 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $node_d2 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2

#Setup a FTP Application over TCP connection 2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP

#Setup a TCP connection 3
#Setup a flow
set tcp3 [new Agent/TCP]
$ns attach-agent $node_s3 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $node_d3 $sink3
$ns connect $tcp3 $sink3
$tcp3 set fid_ 3

#Setup a FTP Application over TCP connection 3
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP

#Schedule events for the CBR and FTP agents
$ns at 0.1 "$ftp1 start"
$ns at 0.5 "$ftp2 start"
$ns at 0.9 "$ftp3 start"
$ns at 4.0 "$ftp1 stop"
$ns at 4.5 "$ftp2 stop"
$ns at 4.9 "$ftp3 stop"


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
$ns at 5.0 "finish"

#Run the simulation
$ns run
