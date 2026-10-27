# tool/export_npl_codes.ps1
#
# Exports the three sheets of data/_raw/npl-codes/1695378470_83.xls (the
# Government of Nepal administrative code table: provinces, districts, local
# units) to UTF-8 TSV files next to it, so the merge pipeline can parse them
# without an Excel dependency at merge time.
#
# The .xls is binary BIFF and Excel COM is the only reader available on this
# machine without adding a dependency. Run this once after (re-)vendoring the
# XLS; the resulting TSVs are pinned in data/PROVENANCE.sha256, so any later
# re-export that produces different bytes fails the provenance gate loudly
# instead of silently feeding the merge different data.
#
# Usage (from the repo root):
#   powershell -ExecutionPolicy Bypass -File tool\export_npl_codes.ps1
#
# Notes:
#   - Cell values are written verbatim except that embedded line breaks and
#     tabs become a single space: the district sheet wraps two long
#     Devanagari cells across two physical lines, and a TSV row must be one
#     line.
#   - Fully empty rows are dropped; trailing empty cells are trimmed.
#   - Output is UTF-8 WITHOUT BOM (the Dart merge tools decode plain UTF-8).
#   - Sheets 1-2 carry legacy Preeti-font Devanagari (not Unicode); the bytes
#     are preserved as-is. The merge tooling deliberately reads only the
#     English/code columns of those sheets.

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $repoRoot 'data\_raw\npl-codes'
$src = Join-Path $dir '1695378470_83.xls'
if (-not (Test-Path $src)) { throw "source workbook not found: $src" }

$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$excel.DisplayAlerts = $false
try {
  $wb = $excel.Workbooks.Open($src, 0, $true)
  try {
    foreach ($name in @('pradesh_code', 'district_code', 'localunit_code')) {
      $sheet = $wb.Worksheets.Item($name)
      $ur = $sheet.UsedRange
      $rows = [int]$ur.Rows.Count
      $cols = [int]$ur.Columns.Count
      $lines = New-Object System.Collections.Generic.List[string]
      for ($r = 1; $r -le $rows; $r++) {
        $cells = New-Object System.Collections.Generic.List[string]
        for ($c = 1; $c -le $cols; $c++) {
          $v = $ur.Cells.Item($r, $c).Value2
          if ($null -eq $v) { $s = '' } else { $s = [string]$v }
          $s = $s -replace "(`r|`n|`t)+", ' '
          $cells.Add($s)
        }
        while ($cells.Count -gt 0 -and $cells[$cells.Count - 1] -eq '') {
          $cells.RemoveAt($cells.Count - 1)
        }
        if ($cells.Count -eq 0) { continue }
        $lines.Add(($cells -join "`t"))
      }
      $out = Join-Path $dir ($name + '.tsv')
      $utf8 = New-Object System.Text.UTF8Encoding($false)
      [System.IO.File]::WriteAllLines($out, $lines, $utf8)
      Write-Output ("{0}: {1} rows x {2} cols -> {3} ({4} bytes)" -f `
        $name, $lines.Count, $cols, $out, (Get-Item $out).Length)
    }
  } finally { $wb.Close($false) }
} finally {
  $excel.Quit()
  [System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null
}
