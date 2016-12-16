<h1>ECE287 Final Project (Digital Circuit Design)</h1>
Member: Qi Yu, Yusuke Oritate<br/>
Instructor: Dr. Peter Jamieson<br/>
Date: December 13, 2016<br/>
Type: In-class project. <br/>
Description: Quiz application implemented by using VHDL and DE2-115 board.<br/>
**_Note: All the screenshots for the .bsf files (schematic) can be found at here:_** https://github.com/oritaty/In-Class-Projects/tree/master/pics<br/>
<h2>Required Environment</h2>
* **_Hardware_**: PGA monitor and DE2/DE2-115 board connected to the computer through PGA cable and USB blaster respectively.
* **_Software_**: Windows or Linux operating system preffered, with Quartus II IDE (14.0 or later) as well as suitable Verilog compiler (Ex. iVerilog) downloaded.<br/>

<h2>Instruction</h2>
1) Downloads the whole project folder from https://github.com/oritaty/In-Class-Projects(Downloads .zip file from 'Clone or download' button located on top left corner).<br/>
2) Unzip the folder.<br/>
3) Open the project by choosing **_'top.qpf' file_**.<br/>
4) On the Project Navigator located on left side of Quartus II IDE, double click the entry called **_'top'_**.<br/>
5) The top entry schematic page will be displayed.<br/>
6) Save files and compile.<br/>
7) After compilation (never change PIN assignment), open the Programmer window from the Tool tub.<br/>
8) Incorporate the output file into the window from the ADD FILE... button. <br/>
9) Click the 'Hardware Setup...' button on the top left corner of the window and select the hardware (choose USB-Blaster [USB-0]' this time).<br/>
10) Click the FPGA icon appeared on the lower half of the window, then click 'Start'.<br/>
11) Turn on the PGA monitor.<br/>
12) You will now see a set of 10 arithmatic equations (four basic operations) on the left side of the monitor, as well as a set of 10 x 4 cancidate answers on the right.<br/>
13) There are four possible operations for users to play this quiz application:<br/>
* KEY3 -- Resume a new game (can be envoked at any process of the application also allows to abandon a game currently played).<br/>
* KEY2 -- <br/>
* KEY1 -- <br/>
* KEY0 -- <br/>

**_Note: For more details, refer to the video link below._**<br/>
<h2>Video (Demo)</h2>
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/UgrsRJFS7Uc/0.jpg)](https://www.youtube.com/watch?v=UgrsRJFS7Uc)<br/>
URL: https://www.youtube.com/watch?v=UgrsRJFS7Uc&feature=youtu.be<br/>
