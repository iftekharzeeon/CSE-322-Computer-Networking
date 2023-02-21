import matplotlib.pyplot as plt
import sys


graph_type = sys.argv[1]

image_location = sys.argv[2]

network_type = sys.argv[3]

if (network_type == "wd"):
    network_type = " (Wired) "
elif (network_type == "ws"):
    network_type = " (Wireless) "

if (graph_type == "n"):
    graph_type = "Number of Nodes"
elif(graph_type == "f"):
    graph_type = "Number of Flows"
elif(graph_type == "a"):
    graph_type = "Area in Squared M."
elif(graph_type == "p"):
    graph_type = "Packet Per Second"

graph_type = graph_type + network_type

x_axis_values = []
y_axis_throughput_red = []
y_axis_avgdelay_red = []
y_axis_deliveryratio_red = []
y_axis_dropratio_red = []

y_axis_throughput_nared = []
y_axis_avgdelay_nared = []
y_axis_deliveryratio_nared = []
y_axis_dropratio_nared = []

file1 = open('params_RED.txt', 'r')
file2 = open('params_NARED.txt', 'r')

# Reading RED files

Lines = file1.readlines()

for line in Lines:
    separated_line = line.strip().split()

    if (len(separated_line) > 1):
        y_axis_throughput_red.append(float (separated_line[0]))
        y_axis_avgdelay_red.append(float (separated_line[1]))
        y_axis_deliveryratio_red.append(float (separated_line[2]))
        y_axis_dropratio_red.append(float (separated_line[3]))
    else:
        x_axis_values.append(int (separated_line[0]))

# Reading NARED files

Lines = file2.readlines()

for line in Lines:
    separated_line = line.strip().split()

    if (len(separated_line) > 1):
        y_axis_throughput_nared.append(float (separated_line[0]))
        y_axis_avgdelay_nared.append(float (separated_line[1]))
        y_axis_deliveryratio_nared.append(float (separated_line[2]))
        y_axis_dropratio_nared.append(float (separated_line[3]))



# Graph 1
plt.plot(x_axis_values, y_axis_throughput_red, marker=".", color="red", label="RED")
plt.plot(x_axis_values, y_axis_throughput_nared, marker=".", color="blue", label="NARED")  
plt.legend()

plt.xlabel(graph_type) 
plt.ylabel("Throughput (bits/sec)") 

plt.title(graph_type + " vs Throughtput") 
plt.savefig(image_location + "/" + graph_type + " vs Throughtput"+".jpg")

plt.close()


# Graph 2
plt.plot(x_axis_values, y_axis_avgdelay_red, marker=".", color="red", label="RED")
plt.plot(x_axis_values, y_axis_avgdelay_nared, marker=".", color="blue", label="NARED") 
plt.legend()

plt.xlabel(graph_type) 
plt.ylabel("Average Delay") 

plt.title(graph_type + " vs Average Delay") 
plt.savefig(image_location + "/" + graph_type + " vs Average Delay"+".jpg")

plt.close()


# Graph 3
plt.plot(x_axis_values, y_axis_deliveryratio_red, marker=".", color="red", label="RED") 
plt.plot(x_axis_values, y_axis_deliveryratio_nared, marker=".", color="blue", label="NARED") 
plt.legend()

plt.xlabel(graph_type) 
plt.ylabel("Packet Delivery Ratio") 

plt.title(graph_type + " vs Packet Delivery Ratio") 
plt.savefig(image_location + "/" + graph_type + " vs Packet Delivery Ratio"+".jpg")

plt.close()


# Graph 4
plt.plot(x_axis_values, y_axis_dropratio_red, marker=".", color="red", label="RED")
plt.plot(x_axis_values, y_axis_dropratio_nared, marker=".", color="blue", label="NARED") 
plt.legend()

plt.xlabel(graph_type) 
plt.ylabel("Packet Drop Ratio") 

plt.title(graph_type + " vs Packet Drop Ratio") 
plt.savefig(image_location + "/" + graph_type + " vs Packet Drop Ratio"+".jpg", )

plt.close()