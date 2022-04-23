import math
import time
import sys
from pathlib import Path
import subprocess as sp
import xml.etree.ElementTree as ET
from junit_xml import TestCase, TestSuite

# There must be only one <Testsuites> and one <Testsuite> in the output.xml

# Merge argv[1] and argv[2]
# argv[1] can not exist and in this case, result is just argv[2]
# Name of trace is argv[3]


def rename_xml(xml_path):
    if xml_path == 'output.xml':
        return
    if Path(xml_path).is_file():
        tree = ET.parse(xml_path)
        r = tree.getroot()
        for testsuite in r.iter('testsuite'):
            testsuite_name = testsuite.attrib['name']
            if testsuite_name == 'compile' or testsuite_name == 'forbidden' or \
               testsuite_name == 'architecture':
                continue
            for testcase in testsuite.iter("testcase"):
                testcase.set('classname', (testsuite_name + "." +
                             testcase.attrib['name']).replace(" ", "_"))
        tree.write(xml_path, encoding="UTF-8")


def merge_xml(xml_path1, xml_path2):
    if Path(xml_path2).is_file():
        tree2 = ET.parse(xml_path2)
        r2 = tree2.getroot()
        # Append all <testsuite> element
        if Path(xml_path1).is_file():
            tree1 = ET.parse(xml_path1)
            r1 = tree1.getroot()
            for testsuite in r1.iter('testsuite'):
                r2.set('tests', str(int(r2.attrib['tests']) +
                       int(testsuite.attrib['tests'])))
                r2.set('failures', str(int(r2.attrib['failures']) +
                       int(testsuite.attrib['failures'])))
                r2.set('errors', str(int(r2.attrib['errors']) +
                       int(testsuite.attrib['errors'])))

                r2.append(testsuite)

        # merge all <testsuite> into a single one
        first_testsuite = r2.find('testsuite')
        first_testsuite.set('name', sys.argv[3])
        if first_testsuite is None:
            return
        for testsuite in r2.findall('testsuite')[1:]:
            for child in testsuite.iter('testcase'):
                first_testsuite.append(child)
            r2.remove(testsuite)

        tree2.write("output.xml")


rename_xml(sys.argv[1])
rename_xml(sys.argv[2])

merge_xml(sys.argv[1], sys.argv[2])
