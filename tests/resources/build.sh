#!/bin/bash
# Build the doxygen documentation for the test cases 


DOXYGEN_PATH="/Applications/Doxygen.app/Contents/Resources/doxygen"

#  Run doxygen on the updated config file.

$DOXYGEN_PATH conf

exit 0
