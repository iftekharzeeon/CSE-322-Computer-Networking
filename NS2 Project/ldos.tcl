Queue/RED set thresh_queue_ 5
Queue/RED set maxthresh_queue_ 20
Queue/RED set q_weight_ 0.003
Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ false
Queue/RED set gentle_ false
Queue/RED set mean_pktsize_ 100
# Queue/RED set RRED_ 1
Queue/RED set buffer_size 20
Queue/RED set cur_max_p_ 0.1
Queue/RED set modified_red_ 0
# RRED_1 ta amr project er jnno define kora
# Create a new simulation object
set ns [new Simulator]

# Define simulation time
set sim_time 10s

# Create nodes
for {set i 1} {$i <= 30} {incr i} {
    set user($i) [$ns node]
}
for {set i 1} {$i <= 20} {incr i} {
    set attacker($i) [$ns node]
}

# Create links
for {set i 1} {$i <= 30} {incr i} {
    $ns duplex-link $user($i) $attacker(1) 100Mbps 2ms RED
    $ns queue-limit $user($i) $attacker(1) 50
}
for {set i 1} {$i <= 20} {incr i} {
    $ns duplex-link $attacker($i) $user(1) 100Mbps 2ms DropTail
}

# Define TCP flows from users to a server
set server [$ns node]
for {set i 1} {$i <= 30} {incr i} {
    set ftp($i) [new Application/FTP]
    $ns attach-agent $user($i) $ftp($i)
    set sink($i) [new Agent/Null]
    $ns attach-agent $server $sink($i)
    $ns connect $ftp($i) $sink($i)
    $ftp($i) set packetSize_ 1000
    $ftp($i) set rate_ 10Mbps

    $ns at 0.0 "$ftp($i) start"
    $ns at $sim_time "$ftp($i) stop"
}

# Define LDoS traffic from attackers to users
for {set i 1} {$i <= 20} {incr i} {
    set udp($i) [new Agent/UDP]
    $ns attach-agent $attacker($i) $udp($i)
    set null($i) [new Agent/Null]
    $ns attach-agent $user($i) $null($i)
    $ns connect $udp($i) $null($i)
    $udp($i) set packetSize_ 50
    $udp($i) set rate_ 0.25Mbps
    $udp($i) set delay_ 200ms
    $udp($i) set random_ 1
    $ns at 0.0 "$udp($i) start"
    $ns at $sim_time "$udp($i) stop"
}

# Define RED parameters
# set q_weight 0.0025
# set max_th 50
# set min_th 5
set q_limit 50

# Enable RED on bottleneck link
# set red [new RED]
#$ns queue-limit $attacker(1) $server $q_limit
#$red set q_weight_ $q_weight
#$red set maxthresh_ $max_th
#$red set minthresh_ $min_th
#$red set queue-limit_ $q_limit
#$red attach $attacker(1) $server
$ns duplex-link $server $attacker(1) 100Mbps 2ms RED
$ns queue-limit $server $attacker(1) 50

# Define trace files
set ftcptcp [open tcp_tcp.tr w]
$ns trace-all $ftcptcp
set ftcpdos [open tcp_dos.tr w]
$ns trace-queue $user(1) $attacker(1)
set nam_file [open animation_wired.nam w]
# set trace_file [open trace_wired.tr w]
$ns namtrace-all $nam_file



#Define a 'finish' procedure
proc finish {} {
    global ns nam_file ftcptcp ftcpdos
    $ns flush-trace 
    #Close the NAM trace file
    close $nam_file
    close $ftcptcp 
    close $ftcpdos
    #Execute NAM on the trace file
    # exec nam out.nam &
    exit 0
}


#Detach tcp and sink agents (not really necessary)
# $ns at 4.9 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at $sim_time "finish"

#Run the simulation
$ns run