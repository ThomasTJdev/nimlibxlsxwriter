#!/usr/bin/env python3
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree


workbook_path = Path(sys.argv[1])
with zipfile.ZipFile(workbook_path) as archive:
    archive.testzip()
    names = set(archive.namelist())
    required = {
        "xl/workbook.xml",
        "xl/worksheets/sheet1.xml",
        "xl/worksheets/sheet2.xml",
        "xl/sharedStrings.xml",
        "xl/styles.xml",
        "xl/charts/chart1.xml",
    }
    missing = required - names
    if missing:
        raise AssertionError(f"missing XLSX members: {sorted(missing)}")

    spreadsheet_ns = "{http://schemas.openxmlformats.org/spreadsheetml/2006/main}"
    workbook = ElementTree.fromstring(archive.read("xl/workbook.xml"))
    sheet_names = [sheet.attrib["name"] for sheet in workbook.iter(spreadsheet_ns + "sheet")]
    if sheet_names != ["Data", "Summary"]:
        raise AssertionError(f"unexpected worksheets: {sheet_names}")

    shared_strings = ElementTree.fromstring(archive.read("xl/sharedStrings.xml"))
    text = "".join(node.text or "" for node in shared_strings.iter(spreadsheet_ns + "t"))
    for expected in ("Quarter", "Sales", "Total"):
        if expected not in text:
            raise AssertionError(f"missing shared string: {expected}")

    summary = ElementTree.fromstring(archive.read("xl/worksheets/sheet2.xml"))
    formulas = [node.text for node in summary.iter(spreadsheet_ns + "f")]
    if "SUM(Data!B2:B4)" not in formulas:
        raise AssertionError(f"unexpected formulas: {formulas}")

    styles = ElementTree.fromstring(archive.read("xl/styles.xml"))
    number_formats = {
        node.attrib["formatCode"] for node in styles.iter(spreadsheet_ns + "numFmt")
    }
    if "#,##0.00" not in number_formats:
        raise AssertionError(f"unexpected number formats: {sorted(number_formats)}")

print(f"validated {workbook_path}")
