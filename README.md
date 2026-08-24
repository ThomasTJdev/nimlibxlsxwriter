# Nimlibxlsxwriter

*This is a working fork from [KeepCoolWithCoolidge](https://github.com/KeepCoolWithCoolidge/nimlibxlsxwriter) updated to work with current versions of Nim.*

# General

Nimlibxlsxwriter is a [Nim](https://nim-lang.org/) wrapper for the
[libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) library.


# OS support

The package only supports Linux. For legacy support of Windows/Mac see [Legacy support](legacy/LEAGACY.md).


# Installation

Nimlibxlsxwriter can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
$ nimble install nimlibxlsxwriter
# or
$ git clone https://github.com/ThomasTJdev/nimlibxlsxwriter
$ cd nimlibxlsxwriter
$ nimble install
```

## Dynamic XLSX library
The libxlsxwriter shared library is required before installing this package.
This binding is tested against libxlsxwriter 1.2.4 on Linux and supports its
versioned `libxlsxwriter.so.11` library name as well as the unversioned
development symlink.

Install libxlsxwriter using your system package manager, or follow the official
[build and installation instructions](https://libxlsxwriter.github.io/getting_started.html).
The repository no longer bundles a platform-specific shared library.

# Want more XLSX?

Then checkout:
- [xlsx](https://github.com/xflywind/xlsx): For reading and parsing XLSX files.
- [xlsxio](https://github.com/jiiihpeeh/xlsxio-nim): For reading and writing


# Usage

```nim
import nimlibxlsxwriter

proc main() =
  let workbook = workbook_new("demo.xlsx")
  let worksheet = workbook_add_worksheet(workbook, nil)
  let heading = workbook_add_format(workbook)

  format_set_bold(heading)
  discard worksheet_write_string(worksheet, 0, 0, "Hello", heading)
  discard worksheet_write_number(worksheet, 1, 0, 123.45, nil)

  let error = workbook_close(workbook)
  if error != LXW_NO_ERROR:
    raise newException(IOError, $lxw_strerror(error))

main()
```

`workbook_close()` writes the XLSX file and frees the workbook. Always check its
returned error and do not use workbook-owned pointers after it succeeds.

Refer to the `tests` directory for more examples.

# Credits

Nimlibxlsxwriter wraps the libxlsxwriter source code and all licensing terms of
[libxlsxwriter](https://github.com/jmcnamara/libxlsxwriter) apply to the usage
of this package.
