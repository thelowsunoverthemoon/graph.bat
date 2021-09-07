# graph.bat
graph.bat is a fast Batch utility script to generate bar graphs. Given a file, this script will generate a bar graph and put it into the variable ```final```. For example:

```Batch
CALL GRAPH "input.txt" /X 1 /Y 2 /C █ /A 3 /YS 5 /W 1 /D 2 /NS 3
```

Will take the data from "input.txt", make a graph at position 1;2 using █ characters, divide the data by 3 with a Y scale of 5, with bars of width 1 and distance 2, and a Y offset by 3. This script is only needs one pass through the data, since to generate the bars, it takes the maximum bar length and subtracts/adds to it, so it doesn't iterate again for each bar.

## Parameters
Each parameter has a default, so you don't have to specify each one. The first argument is always the file name; the rest can be put in any order.

| Parameter  | Usage | Default |
| ------------- | ------------- | ------------- | 
| ```X```  | X Coordinate  | 1 |
| ```Y```  | Y Coordinate  | 1 |
| ```D```  | Bar Distance (from 0) | 1 |
| ```C```  | Display Char  | # |
| ```A```  | Data Adjust, divide each point by ```A```  | 1 |
| ```W```  | Bar Length (from 0)  | 1 |
| ```XR```  | X Scale Start  | 1 |
| ```XS```  | X Scale Factor  | 1 |
| ```YR```  | Y Scale Start  | 1 |
| ```YS```  | Y Scale Factor  | 1 |
| ```NS```  | Display Offset for Y Scale  | 2 |

## Usage

**1.** Download graph.bat

**2.** Define ```%ESC%``` in your code as the escape character for VT100 sequences

**3.** Your input file should be a simple file of a number a line. For example:

```
5
12
8
77
23
```

**4.** ```CALL GRAPH``` with your parameters

## Example

```Batch
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE 140, 30
FOR /F %%A in ('ECHO PROMPT $E^| CMD') DO SET "ESC=%%A"

(CHCP 65001)>NUL

CALL GRAPH "input.txt" /X 1 /Y 2 /C █ /A 3 /YS 5 /W 1 /D 2 /NS 3

ECHO %ESC%[2J%ESC%[4mTemperature vs. Day%ESC%[24m%final%
PAUSE>NUL

EXIT /B
```
![image](https://imgur.com/0JCkfSj.png)
