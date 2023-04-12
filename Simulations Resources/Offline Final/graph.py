import matplotlib.pyplot as plt
import sys


graph_type = sys.argv[1]

image_location = sys.argv[2]

if (graph_type == "n"):
    graph_type = "Number of Nodes"
elif(graph_type == "f"):
    graph_type = "Number of Flows"
elif(graph_type == "a"):
    graph_type = "Area in Squared M."

x_axis_values = []
y_axis_throughput = []
y_axis_avgdelay = []
y_axis_deliveryratio = []
y_axis_dropratio = []

file1 = open('params.txt', 'r')
Lines = file1.readlines()

for line in Lines:
    separated_line = line.strip().split()

    if (len(separated_line) > 1):
        y_axis_throughput.append(float (separated_line[0]))
        y_axis_avgdelay.append(float (separated_line[1]))
        y_axis_deliveryratio.append(float (separated_line[2]))
        y_axis_dropratio.append(float (separated_line[3]))
    else:
        x_axis_values.append(int (separated_line[0]))

print(x_axis_values)
print(y_axis_throughput)

# Graph 1
plt.plot(x_axis_values, y_axis_throughput, marker=".") 

plt.xlabel(graph_type) 
plt.ylabel("Throughput (bits/sec)") 

plt.title(graph_type + " vs Throughtput") 
plt.savefig(image_location + "/" + graph_type + " vs Throughtput"+".jpg")

plt.close()


# Graph 2
plt.plot(x_axis_values, y_axis_avgdelay, marker=".") 

plt.xlabel(graph_type) 
plt.ylabel("Average Delay") 

plt.title(graph_type + " vs Average Delay") 
plt.savefig(image_location + "/" + graph_type + " vs Average Delay"+".jpg")

plt.close()


# Graph 3
plt.plot(x_axis_values, y_axis_deliveryratio, marker=".") 

plt.xlabel(graph_type) 
plt.ylabel("Packet Delivery Ratio") 

plt.title(graph_type + " vs Packet Delivery Ratio") 
plt.savefig(image_location + "/" + graph_type + " vs Packet Delivery Ratio"+".jpg")

plt.close()


# Graph 4
plt.plot(x_axis_values, y_axis_dropratio, marker=".") 

plt.xlabel(graph_type) 
plt.ylabel("Packet Drop Ratio") 

plt.title(graph_type + " vs Packet Drop Ratio") 
plt.savefig(image_location + "/" + graph_type + " vs Packet Drop Ratio"+".jpg")

plt.close()