puts [lindex $argv 1]
puts "Test"
for {set i 0} {$i < 20 } {incr i} {

    set a [expr (int(9 * rand() + 1))]
    puts $a
} 