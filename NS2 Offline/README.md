**Submission Deadline: January 30, 2023, Monday, 11:59 PM**

**Personalised Parameters: **

See [this Google Sheet](https://docs.google.com/spreadsheets/d/1W7ttHCuQ8RWvopPqVLOiZcBU8eGqEW7H3JVR6px6ogY/) to know your parameters. 

**Wireless MAC Type:**



* Wireless 802.15.4 
* Wireless 802.11

**Routing Protocol:**



* DSDV
* AODV
* DSR

**Agent + Application:**



* UDP + Exponential Traffic
* UDP + CBR Traffic
* TCP Reno + FTP 
* TCP Tahoe + Telnet, 

**Node Positioning:**



* Random (Randomly place nodes anywhere with area)
* Grid (Place nodes in a grid. You can choose the number of rows and columns yourself)

**Flow:**



* Random Source Destination (For each flow, choose a random source and a destination. Careful not to choose same node as source and destination)
* 1 Source, Random Sink (except source itself) (Choose a random source X, then for each flow choose X as source, and any other node as destination)
* 1 Sink, Random Source (Choose a random sink X, then for each flow choose X as destination, and any other node as source)



**Parameters:**

<span style="text-decoration:underline;">Queue</span>: Droptail, max size 50 _(Using Queue/DropTail/PriQueue with DSR may cause segmentation fault. In that case you can use CMUPriQueue instead.)_

<span style="text-decoration:underline;">Antenna</span>: Omni Directional

<span style="text-decoration:underline;">Speed of nodes</span>: Uniform random between 1m/s and 5m/s for each node.

<span style="text-decoration:underline;">Propagation Model</span>: Two Ray Ground Propagation Model

With your personalised parameters and global parameters fixed, vary the parameters below.

**Baseline Parameters: **(while varying one parameter, keep other parameters fixed like below)



* <span style="text-decoration:underline;">Area Size</span>: 500m x 500m 
* <span style="text-decoration:underline;">Number of Nodes</span>: 40
* <span style="text-decoration:underline;">Number of flows</span>: 20

**Vary parameters:**



* <span style="text-decoration:underline;">Area Size</span>: 250m x 250m, 500m x 500m, 750m x 750m, 1000m x 1000m, 1250m x 1250m
* <span style="text-decoration:underline;">Number of Nodes</span>: 20, 40, 60, 80, 100
* <span style="text-decoration:underline;">Number of flows</span>: 10, 20, 30, 40, 50

**Metrics:**

For each of the varying parameters, plot 4 graph showing,



* Network throughput
* End-to-end delay
* Packet delivery ratio (total # of packets delivered to end destination / total # of packets sent)
* Packet drop ratio (total # of packets dropped / total # of packets sent)



**For example: **

Say, for varying area sizes, keep other params fixed as mentioned in baseline. Find 4 metrics for each of the values of area size. Plot each metric in a separate graph. You will get 4 graphs for varying area size. One of them is the Delivery ratio. It may look like this. **Clearly mention the x-axis, y-axis, x-ticks and y-ticks.**

The total number of graphs will be 3 x 4 = 12.

**Report:**



* Write short descriptions of your MAC type, Routing protocol, Agent Type, Application.
* Include all the 12 graphs.
* Write short observations on the results you got.

**Submission:**



* Code (exclude the trace files, nam files). Include only the source files (.tcl, .sh, .awk, .py, .ipynb or others)
* Report as pdf.
* Put all of these in a zip file
* Name it as your student id (1805xxx.zip)
* Submit 



**Marks Distribution:**


<table>
  <tr>
   <td>Basic Simulation and configs
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>Vary area size + graph
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>Vary number of nodes + graph 
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>Vary number of flows + graph
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>Report
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td><strong>Total</strong>
   </td>
   <td><strong>20</strong>
   </td>
  </tr>
</table>




**Appendix A: List of graphs**


<table>
  <tr>
   <td rowspan="2" ><strong>Graph No.</strong>
   </td>
   <td rowspan="2" ><strong>x-axis</strong>
   </td>
   <td rowspan="2" ><strong>y-axis</strong>
   </td>
   <td colspan="3" ><strong>Fixed Param Values</strong>
   </td>
  </tr>
  <tr>
   <td><strong>Area-size</strong>
   </td>
   <td><strong>Number of nodes</strong>
   </td>
   <td><strong>Number of flows</strong>
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td rowspan="4" >Area Size 
<ul>

<li>250m x 250m

<li>500m x 500m

<li>750m x 750m

<li>1000m x 1000m

<li>1250m x 1250m
</li>
</ul>
   </td>
   <td>Network throughput
   </td>
   <td>-
   </td>
   <td>40
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>End-to-end Delay
   </td>
   <td>-
   </td>
   <td>40
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>Packet delivery ratio
   </td>
   <td>-
   </td>
   <td>40
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>Packet drop ratio
   </td>
   <td>-
   </td>
   <td>40
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td rowspan="4" >Number of nodes
<ul>

<li>20

<li>40

<li>60

<li>80

<li>100
</li>
</ul>
   </td>
   <td>Network throughput
   </td>
   <td>500m x 500m
   </td>
   <td>-
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>End-to-end Delay
   </td>
   <td>500m x 500m
   </td>
   <td>-
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>Packet delivery ratio
   </td>
   <td>500m x 500m
   </td>
   <td>-
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>8
   </td>
   <td>Packet drop ratio
   </td>
   <td>500m x 500m
   </td>
   <td>-
   </td>
   <td>20
   </td>
  </tr>
  <tr>
   <td>9
   </td>
   <td rowspan="4" >Number of flows
<ul>

<li>10

<li>20

<li>30

<li>40

<li>50
</li>
</ul>
   </td>
   <td>Network throughput
   </td>
   <td>500m x 500m
   </td>
   <td>40
   </td>
   <td>-
   </td>
  </tr>
  <tr>
   <td>10
   </td>
   <td>End-to-end Delay
   </td>
   <td>500m x 500m
   </td>
   <td>40
   </td>
   <td>-
   </td>
  </tr>
  <tr>
   <td>11
   </td>
   <td>Packet delivery ratio
   </td>
   <td>500m x 500m
   </td>
   <td>40
   </td>
   <td>-
   </td>
  </tr>
  <tr>
   <td>12
   </td>
   <td>Packet drop ratio
   </td>
   <td>500m x 500m
   </td>
   <td>40
   </td>
   <td>-
   </td>
  </tr>
</table>

