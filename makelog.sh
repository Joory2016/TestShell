#!/bin/bash
# copy the directory listing to a log file
today=$(date +"%y-%m-%d")
ls /root -al > log.$today

