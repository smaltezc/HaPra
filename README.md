# HaPra

To run and simulate the VHDL files using `script.py`, follow these steps:

   ```shell
   python script.py example.vhdl example_tb.vhdl testbench.vcd
   ```
You can also execute specific components of a VHDL file using script.py by including the component's name before the VHDL file. Here's an example command:


   ```shell
   python script.py nandgate.vhdl example.vhdl example_tb.vhdl testbench.vcd
   ```
Run the above command in the Command Prompt to execute the nandgate component within the example.vhdl file.
