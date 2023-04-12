# NS2 Project Guideleins

**<span style="text-decoration:underline;">Tasks to be Performed in .tcl File</span>**



1. Set values  of the parameters 
    1. Network size
    2. Number and positioning of nodes
    3. Number and other attributes of flows
    4. Energy parameters
    5. Protocols and models for different layers
    6. etc. …
2. Initialize ns
3. Open required files such as trace file
4. Set node configuration
5. Create nodes with positioning
6. Create flows and associate them with nodes
7. Set timings of different events
8. Write tasks to do after finishing the simulation in a procedure named finish
9. Run the simulation
10. ….



**<span style="text-decoration:underline;">Tasks to be Performed in .awk File</span>**



1. Set initial values of variables (if needed) pertinent to different metrics such as # of sent packets, total energy consumption, etc.
2. Extract values in each row in different variables following indexing of the values
3. Perform logical and arithmetic operations on the extracted values to update the variables pertinent to different metrics
4. Print values of the metrics

[NOTE: Values may differ based on several things such as protocols. For example, TCP and UDP provide different values at the same index.]

**<span style="text-decoration:underline;">Tasks to be Performed in .sh File</span>**



1. Navigate to appropriate folder
2. Set initial values of the variables maintaining statistics of different metrics such as average # of sent packets, average total energy consumption, etc.
3. Conduct iterations; in each iteration, vary the intended parameter and –
    1. Run the .tcl file
    2. Run .awk file on the generated .tr file
    3. Make summary of values of all metrics generated by the current run
4. Print outcomes of all iterations

**<span style="text-decoration:underline;">Tasks to be Performed in .cpp File</span>**



1. This is the trickiest part of your project. You can do different modifications in the .cpp files such as –
    1. Modify the mechanism of RTT calculation
    2. Modify the congestion control mechanism in TCP
2. After you change a .cpp file, you need to perform a “make” operation to ensure that your changes take effect in the next simulation run.

[

NOTE: 



1. In some cases, you may need to perform “make clean” operation before “make” operation.
2. To visualize whether your modification is taking effect or not, you can put a printf along with your modification.
3. Sometimes, even after doing everything, things may not work for unknown reasons. In such a case, try with a new installation conforming a match between the versions of Linux and ns-2.

]



**<span style="text-decoration:underline;">Term Assignment</span>**



1. Simulate the following networks as per assignment:

<table>
  <tr>
   <td>
<strong>Std_id % 8</strong>
   </td>
   <td><strong>Wired</strong>
   </td>
   <td><strong>Wireless 802.11 (static)</strong>
   </td>
   <td><strong>Wireless 802.11 (mobile)</strong>
   </td>
   <td><strong>Wireless 802.15.4 (static)</strong>
   </td>
   <td><strong>Wireless 802.15.4 (mobile)</strong>
   </td>
  </tr>
  <tr>
   <td>0
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>1
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>2
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>√
   </td>
  </tr>
  <tr>
   <td>3
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>√
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>4
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>√
   </td>
  </tr>
  <tr>
   <td>5
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>√
   </td>
  </tr>
  <tr>
   <td>6
   </td>
   <td>√
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>7
   </td>
   <td>√
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>√
   </td>
   <td>
   </td>
  </tr>
</table>




2. In your simulation –
    1. The number of nodes need to be varied as 20, 40, 60, 80, and 100
    2. Besides, you need to vary the following parameters –
        1. Number of flows (10, 20, 30, 40, and 50)
        2. Number of packets per second (100, 200, 300, 400, and 500)
        3. Speed of nodes (5 m/s, 10 m/s, 15 m/s, 20 m/s, and 25 m/s) [Only in case of having mobility]
        4. Coverage area (square coverage are varying one side as Tx_range, 2 x Tx_range, 3 x Tx_range, 4 x Tx_range, and 5 x Tx_range) [Only in case of having static nodes only]
3. In all cases, you need to measure the following metrics and plot graphs –
    3. Network throughput
    4. End-to-end delay
    5. Packet delivery ratio (total # of packets delivered to end destination / total # of packets sent)
    6. Packet drop ratio (total # of packets dropped / total # of packets sent)
    7. Energy consumption [for wireless nodes]
4. ** **While doing the above simulations, you MUST simulate at least the following** –
    8. A modified mechanism done by yourself, which can be one or a combination of the following –
        5. Modified mechanism for RTT calculation
        6. Modified mechanism for congestion control in TCP
        7. Modified mechanism of routing
        8. Modified MAC layer protocol
        9. Or any other similar modification
    9. Corresponding existing mechanisms in ns-2
5. The modification you want to make can be anything from any existing paper or from your own thinking. However, the codes that would be made available to you will NOT be counted as your modification.
6. You need to submit a report mentioning the following-
    10. Network topologies under simulation
    11. Parameters under variation
    12. Modifications made in the simulator
    13. Results with graphs
    14. Summary findings
7. Bonus: There are several places where you can get bonuses. Examples include – 
    15. Cross transmission of packets, i.e., transmission of packets from one type of node to that of another type (example: simulating a flow n1->n2->…->nx, where the first few nodes are wired and the rest nodes are wireless)
    16. Simulating any network not mentioned above (for example, 5G, LTE, WiMax, Satellite network, nanonetworks, cognitive radio networks, etc.)
    17. Measuring any metric not mentioned above (for example, per-node throughput, variation in queue size over time, etc.)
    18. Any brand new idea with a good performance improvement and not existing in the literature could be worth double bonus!

    [NOTE: It is NOT needed that you will come up with improvement in performance with your modified mechanism. Rather it is needed to make sure what changes you would have done and with what intuition.]





    **<span style="text-decoration:underline;">Grading Scale</span>**


<table>
  <tr>
   <td>00
   </td>
   <td>01
   </td>
   <td>02
   </td>
   <td>03
   </td>
   <td>04
   </td>
   <td>05
   </td>
   <td>06
   </td>
   <td>07
   </td>
   <td>08
   </td>
   <td>09
   </td>
   <td>10
   </td>
   <td>11
   </td>
   <td>12
   </td>
   <td>13
   </td>
   <td>14
   </td>
   <td>15
   </td>
   <td>16
   </td>
   <td>17
   </td>
   <td>18
   </td>
  </tr>
  <tr>
   <td rowspan="2" >student ID
   </td>
   <td colspan="5" >Variation in
   </td>
   <td colspan="5" >Metric
   </td>
   <td colspan="2" >Multiplying factor 1
   </td>
   <td colspan="2" >Multiplying  factor 2
   </td>
   <td rowspan="2" >report 
<p>
(50)
   </td>
   <td rowspan="2" >bonus
<p>
(100)
   </td>
   <td rowspan="2" >total
<p>
(250)
   </td>
   <td rowspan="2" >remarks
   </td>
  </tr>
  <tr>
   <td># of nodes 
<p>
(25)
   </td>
   <td># of flows 
<p>
(25)
   </td>
   <td># of packets 
<p>
(25)
   </td>
   <td>Speed [only for mobility] 
<p>
(25)
   </td>
   <td>Coverage [Only for static] 
<p>
(25)
   </td>
   <td>Network through-put 
<p>
(20)
   </td>
   <td>E2E delay 
<p>
(20)
   </td>
   <td>Delivery ratio 
<p>
(20)
   </td>
   <td>Drop ratio 
<p>
(20)
   </td>
   <td>Energy consump-tion 
<p>
(20)
   </td>
   <td>type 1 node 
<p>
(0.5)
   </td>
   <td>type 2 node 
<p>
(0.5)
   </td>
   <td>modifi-cation
<p>
(0.7)
   </td>
   <td>existing
<p>
(0.3)
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>



    _Total = {(Sum of four columns out of first five columns) + (Sum of 6<sup>th</sup> to 10<sup>th</sup> column) + Report} * (Sum of Multiplying_factor_1) * (Sum of Multiplying_factor_2) + Bonus_