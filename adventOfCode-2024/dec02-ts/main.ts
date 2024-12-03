function getDiffs(levelReport: number[]): number[] {
  const diffs = [];
  for (let idx = 0; idx < levelReport.length - 1; idx++) {
    diffs.push(levelReport[idx] - levelReport[idx + 1]);
  }
  return diffs;
}

function isConsistentDirection(levelReport: number[]): boolean {
  const isPositive = (n: number) => n >= 0;
  const isNegative = (n: number) => n <= 0;

  const allPositive = levelReport.every(isPositive);
  const allNegative = levelReport.every(isNegative);

  return allPositive || allNegative;
}

function isChangingInAcceptableRange(levelReport: number[]): boolean {
  return levelReport.map(Math.abs).every((reading) =>
    reading > 0 && reading < 4
  );
}

export async function readFileOfReports(
  fileLocation: string,
): Promise<number[][]> {
  const entireFile = await Deno.readTextFile(fileLocation);
  const lines = entireFile.split("\n");

  return lines.reduce((reports, reportStr) => {
    const numbers = reportStr.split(" ").map((str) => {
      return Number(str);
    });
    reports.push(numbers);
    return reports;
  }, [] as number[][]);
}

export function safeReportCount(
  reportArray: readonly number[][],
): number {
  return reportArray.reduce((safeCount, report) => {
    if (report.length < 2) return safeCount;

    const diffs = getDiffs(report);
    const changeOk = isChangingInAcceptableRange(diffs);
    const directionOk = isConsistentDirection(diffs);

    if (changeOk && directionOk) {
      safeCount++;
    }

    console.log(
      diffs,
      isChangingInAcceptableRange(diffs),
      isConsistentDirection(diffs),
    );

    return safeCount;
  }, 0);
}

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const reports = await readFileOfReports("./2_input.txt");

  const safeCount = safeReportCount(reports);
  console.log("Part 1", safeCount);
}