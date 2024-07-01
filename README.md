# microblaze 最小系统

mb时钟来自clk_wiz, 有dc有ic，通过axi_interconnect访问mig7, ddr4速率配置为2400Mbps(clk1200M),

for XCKU040-2FFVA1156I(xcku040-ffva1156-2-i)

ddr4 (MT40A512M16LY-062E) 颗粒本身 3200Mbps

vivado 里 Momory Part 选择”MT40A512M16HA-083E” 跑在 2400 Mbps, ref to AXU7EV course s1

# block design

[doc/system.pdf](doc/system.pdf)

# MicroBlaze 最小系统

# Jtag模式

可以选上 program fpga

也可以不选，先下载bitstream，再debug

