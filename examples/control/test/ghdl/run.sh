#!/bin/sh

cd $(dirname $0)

mkdir -p wrk

ghdl_args="--std=08 --workdir=wrk"

ghdl -i $ghdl_args ../../srcs/lib/*
ghdl -a $ghdl_args ../../srcs/lib/*

ghdl -a $ghdl_args *.vhd

ghdl --elab-run $ghdl_args tb --wave=wave.ghw

#printf "[TEST] ghdl -r --disp-tree=none\n"
ghdl -r $ghdl_args tb --disp-tree=none > disp-tree_none.txt

#printf "[TEST] ghdl -r --disp-tree=inst\n"
ghdl -r $ghdl_args tb --disp-tree=inst > disp-tree_inst.txt

#printf "[TEST] ghdl -r --disp-tree=proc\n"
ghdl -r $ghdl_args tb --disp-tree=proc > disp-tree_proc.txt

#printf "[TEST] ghdl -r --disp-tree=port\n"
ghdl -r $ghdl_args tb --disp-tree=port > disp-tree_port.txt

#printf "[TEST] ghdl -r --disp-tree\n"
ghdl -r $ghdl_args tb --disp-tree > disp-tree.txt

#printf "[TEST] ghdl --pp-html\n"
ghdl --pp-html $ghdl_args ../../srcs/lib/* > pid.html

#printf "[TEST] ghdl --file-to-xml\n"
ghdl --file-to-xml $ghdl_args ../../srcs/lib/* > pid.xml
