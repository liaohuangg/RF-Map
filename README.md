# RF_Map
Artifact Evaluation Reproduction for "RF-CGRA: a routing-friendly CGRA with hierarchical register chains" 

## Table of contents
1. [Directory Structure](#directory-structure)
2. [Getting Started](#getting-started)
    1. [Hardware pre-requisities](#hardware-pre-requisities)
    2. [Software pre-requisites](#software-pre-requisites)
    3. [Installation](#installation)
    4. [Running example](#running-example)
    5. [Data formats](#data-formats)
# Directory Structure
```
RfCgraTrans
│───README.md
│───build.sh
│───run.sh
│───data
│     └───test.txt
│───log
│     └───test.log
│───CGRA.cpp
│───CGRA.h
│───config.h
│───DFG.cpp
│───DFG.h
│───GraphRegister.cpp
│───GraphRegister.h
│───main.cpp
│───Path.cpp
│───Path.h
│───Register.cpp
│───Register.h
│───tool.cpp
└───tool.h
```

# Getting start
## Hardware pre-requisities
* Ubuntu 20.04.5
* Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
## Software pre-requisities
* c++11
* gflags
* glog

## Installation
First, install the gflags
```
git clone https://github.com/gflags/gflags.git
mkdir build
cd build
cmake -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON -DINSTALL_HEADERS=ON -DINSTALL_SHARED_LIBS=ON -DINSTALL_STATIC_LIBS=ON ..
make
sudo make install
```
Then, install the glog
```
git clone https://github.com/google/glog.git
cd glog
mkdir build
cmake ..
make
sudo make install
```
Finally, compile this project and you can get ./rf_tcad file
```
./build
```
## Running Example
You can run the example and get the final results in log/test.log
```
./run.sh start
```
Please note that in ./run.sh, you need to modify the following parameters for the DFG that requires map:
* --II (The II of Dfg after scheduling.)
* --childNum (The maximum number of child nodes in DFG.)
* --pea_column (The number of columns of processing element array in RF-CGRA.)
* --pea_row (The number of rows of processing element array in RF-CGRA.)

## Data Formats

Format of DFG scheduling that try to map
```
|----------|------------|-------------|------------|------------|-------------|-------------|
|node index|  time step |node's type  |child node 1|child node 2|edge 1's dif |edge 2's dif |
|----------|------------|-------------|------------|------------|-------------|-------------|
```
An example
```
0,0,1,2,2,0,1
1,1,1,4,-1,0,-1
2,2,0,3,-1,0,-1
3,4,0,4,-1,0,-1
4,6,0,5,-1,0,-1
5,7,1,-1,-1,-1,-1
```
Format of DFG mapping
```
----------------------------------------[0]----------------------------------------
|   bank    |   PE    |   PE    |   PE    |   PE    |  
|   bank    |   PE    |   PE    |   PE    |   PE    |  
|   bank    |   PE    |   PE    |   PE    |   PE    |  
|   bank    |   PE    |   PE    |   PE    |   PE    |  
------------------------------------------------------------------------------------
Path[0]:(dependent edge)
pre: (Label of the precursor node) ------  pos: (Label of the successor node) -----  latency: (The latency of edge)
Label of registers
```
An example
```
----------------------------------------[0]----------------------------------------
|   5   |     |     |     |     |  
|   0   |   4   |     |     |     |  
|   1   |   2   |   3   |     |     |  
|     |     |     |     |     |  
-----------------------------------------------------------------------------------
Path[0]:
pre:0  ------  pos:4  -----  latency:4
25 28 29 30 26 27 
Path[1]:
pre:1  ------  pos:2  -----  latency:2
50 53 51 52 
Path[2]:
pre:1  ------  pos:2  -----  latency:3
50 53 54 51 52 
Path[3]:
pre:2  ------  pos:3  -----  latency:1
52 59 57 58 
Path[4]:
pre:3  ------  pos:4  -----  latency:1
58 34 31 26 27 
Path[5]:
pre:4  ------  pos:5  -----  latency:1
27 3 0 
--------------------------------------------
```

# Reference
```
@inproceedings{zhu2022rf,
  title={RF-CGRA: a routing-friendly CGRA with hierarchical register chains},
  author={Zhu, Rong and Wang, Bo and Liu, Dajiang},
  booktitle={2022 Design, Automation \& Test in Europe Conference \& Exhibition (DATE)},
  pages={262--267},
  year={2022},
  organization={IEEE}
}
```


