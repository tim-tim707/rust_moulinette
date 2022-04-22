import math
import time
import sys
import subprocess as sp
from junit_xml import TestCase, TestSuite

# Check compilation and output `argv[1]` as xml on error as well as return 1
# exercise to check is `argv[2]`

start_time = time.time()
p = sp.Popen(["cargo", "build", "--release"],
             cwd='./'+sys.argv[2], stderr=sp.PIPE, stdout=sp.PIPE)
(stdout, stderr) = p.communicate(timeout=60)
stop_time = time.time()

elapsed_time = (stop_time - start_time) / 1000

if p.returncode != 0:
    t = TestCase('compile', sys.argv[2].split("/")[1]+'.compile', elapsed_time)
    t.add_failure_info(message='Compilation failed',
                       output=stdout.decode('utf8') + stderr.decode('utf8'))
    ts = TestSuite('compile', [t])
    with open(sys.argv[1], 'w') as file:
        file.write(TestSuite.to_xml_string([ts]))
    sys.exit(1)
