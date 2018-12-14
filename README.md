# DE4_T4_OPT - Optimisation of a Chairlift System
Repository of code used in DE4 optimisation coursework.

## Prerequisites
* Matlab is required to run the scripts, which are all saved as .m files
* The 'Global Optimisation Toolbox' for Matlab is required to run the global search algorithm used in 'Subsystem_2/C_S2_Optimisation.m'
  - The toolbox can be installed via this link: https://uk.mathworks.com/products/global-optimization.html
  
## Executing the Code
**Subsystem 1**
The main script is 'subsystem_1.m'. All other scripts are functions.

**Subsystem 2**
There are 3 executable scripts that must be run in order:
    1.  'A_S2_Modelling.m'
    2.  'B_S2_Exploration.m'
    3.  'C_S2_Optimisation.m'

All function scripts are contained within the subdirectory './S2_Functions'. The code relies on data in an .xlsx file named 'OPT_SiemensCatalogue.xlsx', that must be located in the 'Subsystem_2' directory.

**System**
The main script is 'System.m'. All other scripts are functions.
The Subsystem 2 scripts **must** be executed before the System script in order to set global variables that are used across scripts.


 ### Execution Time
 When run on a system of specification; i7 CPU @1.80GHz, 16.0GB RAM, the execution time for each of the main scripts were:
 
 * 'subsystem_1.m' : 5.2 sec
 * 'A_S2_Modelling.m' : 6.7 sec
 * 'B_S2_Exploration.m' : 1.4 sec
 * 'C_S2_Optimisation.m': 32.3 sec
 * 'System.m': 2.2 sec
 