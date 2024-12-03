import { assertEquals } from "@std/assert";
import { readFileOfReports, safeReportCount } from "./main.ts";

Deno.test(async function phase1() {
  const reportArray: number[][] = await readFileOfReports("./2_test.txt");
  const countOfSafeReports = safeReportCount(reportArray);
  assertEquals(countOfSafeReports, 2);
});
