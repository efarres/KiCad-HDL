# KiCad-HDL
Tools to convert KiCad intermediate netlist to HDL block diagram netlist.


[KiCad allow create customized Netlists and BOM files](http://docs.kicad-pcb.org/en/eeschema.html#creating-customized-netlists-and-bom-files) from the Itermediate netlist, by applying a post-processing filter to the Intermediate netlist file.

KiCad-HDL tools follow the XSLT approach and call xsltproc program to read the Intermediate XML netlist input file, apply a style-sheet to transform the input, and save the results in an output file. 

netlist_form_VHDL.xls can generate VHDL netlist files with a XSLT post-processing filter. 

netlist_form_Verolog.xls can generate Verilog netlist files with a XSLT post-processing filter. 

XSLT itself is an XML language very suitable for XML transformations. The document that describes XSL Transformations (XSLT) is available here:

[http://www.w3.org/TR/xsl](http://www.w3.org/TR/xslt)

Example
xsltproc -o sensor_hub.vhdl "/home/efb/HDL/KiCad/Plugins/netlist_form_VHDL.xsl" sensor_hub.xml

