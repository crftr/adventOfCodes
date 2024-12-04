import { assertEquals } from "@std/assert";
import { readFileOfReports, safeReportCount } from "./main.ts";

Deno.test(async function phase1() {
  const reportArray: number[][] = await readFileOfReports("./2_test.txt");
  const countOfSafeReports = safeReportCount(reportArray);
  assertEquals(countOfSafeReports, 2);
});

Deno.test(async function phase1_realInput() {
  const reportArray: number[][] = await readFileOfReports("./2_input.txt");
  const countOfSafeReports = safeReportCount(reportArray);
  assertEquals(countOfSafeReports, 287);
});

Deno.test(async function phase2() {
  const reportArray: number[][] = await readFileOfReports("./2_test.txt");
  const countOfSafeReports = safeReportCount(reportArray, true);
  assertEquals(countOfSafeReports, 4);
});
