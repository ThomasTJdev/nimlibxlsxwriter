import std/[os, unittest]
import nimlibxlsxwriter

proc cFree(pointer: pointer) {.cdecl, importc: "free", header: "<stdlib.h>".}

let outputPath = getEnv("NIMLIBXLSXWRITER_TEST_OUTPUT", "generated-test.xlsx")

suite "libxlsxwriter workbook integration":
  test "creates a formatted two-sheet workbook with a formula and chart":
    let outputDir = outputPath.parentDir
    if outputDir.len > 0:
      createDir(outputDir)

    let workbook = workbook_new(outputPath.cstring)
    require workbook != nil

    let dataSheet = workbook_add_worksheet(workbook, "Data")
    let summarySheet = workbook_add_worksheet(workbook, "Summary")
    require dataSheet != nil
    require summarySheet != nil

    let heading = workbook_add_format(workbook)
    let numberFormat = workbook_add_format(workbook)
    require heading != nil
    require numberFormat != nil
    format_set_bold(heading)
    format_set_num_format(numberFormat, "#,##0.00")

    check worksheet_write_string(dataSheet, 0, 0, "Quarter", heading) == LXW_NO_ERROR
    check worksheet_write_string(dataSheet, 0, 1, "Sales", heading) == LXW_NO_ERROR
    for row in 1'u32 .. 3'u32:
      check worksheet_write_number(dataSheet, row, 0, row.cdouble, nil) == LXW_NO_ERROR
      check worksheet_write_number(dataSheet, row, 1, (row * 10).cdouble,
        numberFormat) == LXW_NO_ERROR

    var invalidDate = lxw_datetime(year: 2026, month: 13, day: 1)
    let dateError = worksheet_write_datetime(dataSheet, 4, 0, addr invalidDate, nil)
    check dateError == LXW_ERROR_DATETIME_VALIDATION
    check $lxw_strerror(dateError) ==
      "Datetime struct parameter has an invalid field value."

    check worksheet_write_string(summarySheet, 0, 0, "Total", heading) == LXW_NO_ERROR
    check worksheet_write_formula(summarySheet, 0, 1, "=SUM(Data!B2:B4)", nil) ==
      LXW_NO_ERROR

    let chart = workbook_add_chart(workbook, LXW_CHART_COLUMN.uint8)
    require chart != nil
    require chart_add_series(chart, "=Data!$A$2:$A$4", "=Data!$B$2:$B$4") != nil
    check worksheet_insert_chart(summarySheet, 2, 0, chart) == LXW_NO_ERROR
    check workbook_close(workbook) == LXW_NO_ERROR
    check fileExists(outputPath)

  test "workbook_new_opt supports fully initialized constant-memory output":
    var outputBuffer: cstring
    var outputSize: csize_t
    var options = default(lxw_workbook_options)
    options.constant_memory = 1
    options.output_buffer = addr outputBuffer
    options.output_buffer_size = addr outputSize

    let workbook = workbook_new_opt(nil, addr options)
    require workbook != nil
    let worksheet = workbook_add_worksheet(workbook, "Streamed")
    require worksheet != nil
    check worksheet_write_string(worksheet, 0, 0, "in memory", nil) == LXW_NO_ERROR
    check workbook_close(workbook) == LXW_NO_ERROR
    require outputBuffer != nil
    check outputSize > 2
    check outputBuffer[0] == 'P'
    check outputBuffer[1] == 'K'
    cFree(outputBuffer)

  test "workbook_close reports output errors":
    let workbook = workbook_new("missing-output-directory/workbook.xlsx")
    require workbook != nil
    check workbook_close(workbook) == LXW_ERROR_CREATING_XLSX_FILE
