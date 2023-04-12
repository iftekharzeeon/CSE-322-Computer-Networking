import matplotlib.pyplot as plt
import sys

event_type = ''
total_packet_bytes = 0
total_number_of_packets_sent = 0
total_number_of_packets_received = 0
total_number_of_packets_dropped = 0
total_delay_time = 0
header_bytes = 16

packet_timing_info = dict()

start_time = -2
end_time = 0

count = 0

file_name = sys.argv[1]

inputfile = open(file_name, 'r')
Lines = inputfile.readlines()

print()
print('Filename: ', file_name)

for line in Lines:
    count += 1
    separated_line = line.strip().split()
    event_type = separated_line[0]
    layer = separated_line[3]
    packet_id = separated_line[5]
    packet_type = separated_line[6]

    if (layer == "AGT" and packet_type == "tcp"):
        event_time = float(separated_line[1])
        packet_byte = int(separated_line[7])

        if (start_time < 0):
            start_time = event_time
        
        if (end_time < event_time):
            end_time = event_time
        
        if (event_type == 's'):
            # Sent
            total_number_of_packets_sent += 1
            packet_timing_info[packet_id] = event_time
        elif (event_type == 'r'):
            # Received
            delay_time = float(event_time) - float(packet_timing_info[packet_id])
            total_delay_time += delay_time
            total_number_of_packets_received += 1

            pbytes = packet_byte - header_bytes
            total_packet_bytes += pbytes
    if (packet_type == "tcp"):
        if (event_type == "D"):
            # Dropped
            total_number_of_packets_dropped += 1

total_time = end_time - start_time
network_throughput = (total_packet_bytes * 8) / total_time
average_delay = total_delay_time / total_number_of_packets_received
packet_delivery_ratio = total_number_of_packets_received / total_number_of_packets_sent
packet_drop_ratio = total_number_of_packets_dropped / total_number_of_packets_sent

print('Number of lines: ', count)
print('Sent Packets: ', total_number_of_packets_sent)
print('Dropped Packets: ', total_number_of_packets_dropped)
print('Received Packets: ', total_number_of_packets_received)
print('Simulation Time: ', total_time)
print('Received Bytes: ', total_packet_bytes)

print('---------------------------------------')

print('Throughput: ', network_throughput)
print('Average Delay: ', average_delay)
print('Delivery Ratio: ', packet_delivery_ratio)
print('Drop Ratio: ', packet_drop_ratio)

print('---------------------------------------\n')

outputfile = open('params.txt', 'a')
outputfile.write(str(network_throughput) + ' ' + str(average_delay) + ' ' + str(packet_delivery_ratio) + ' ' + str(packet_drop_ratio) + '\n')
outputfile.close()