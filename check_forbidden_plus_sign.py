import math
import time
import sys
import subprocess as sp
from pathlib import Path
from junit_xml import TestCase, TestSuite

# Check forbidden words and output `argv[1]` as xml on error as well as return 1
# exercise to check is `argv[2]`

# Add all the forbidden keywords you want here
# You can use regexes or any script that output an xml like this and returns 0 or !0 on error

EXO_PATH = Path(sys.argv[2])

forbidden_keywords = ["+"]
f = "./"+sys.argv[2]+"src/main.rs"
found_any = 0
data = []
with open(f, "r") as my_file:
    for l in my_file:
        data.extend(l.split())

    for keyword in forbidden_keywords:
        if keyword in data:
            found_any = 1
            break

if found_any != 0:
    t = TestCase('forbidden', f'{EXO_PATH.name}.forbidden', 0)
    t.add_failure_info(
        message='Use of forbidden keywords: ' + ' '.join(forbidden_keywords))
    ts = TestSuite('forbidden', [t])
    with open(sys.argv[1], 'w') as file:
        file.write(TestSuite.to_xml_string([ts]))
    sys.exit(1)
