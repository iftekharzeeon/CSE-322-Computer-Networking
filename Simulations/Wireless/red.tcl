set ns [new Simulator]

# Define nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# Define links
$ns duplex-link $n0 $n1 1Mb 50ms DropTail
$ns duplex-link $n1 $n2 1Mb 50ms DropTail

# Set queue management algorithm for links
$ns queue-limit $n0 $n1 50
$ns queue-limit $n1 $n2 50
$ns red-add-queue $n0 $n1
$ns red-add-queue $n1 $n2

# Set TCP agent for n0
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

# Set FTP agent for n2
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Schedule events
$ns at 1.0 "$ftp start"
$ns at 10.0 "$ftp stop"

# Start the simulation
$ns run
