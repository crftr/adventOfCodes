import { assertArrayIncludes, assertEquals } from "@std/assert";
import { extractInstructions, readCorrupted, runCalculation } from "./main.ts";

Deno.test(async function phase1_extract() {
  const corruptedStr: string = await readCorrupted("./3_test.txt");
  const instructions = extractInstructions(corruptedStr);

  assertArrayIncludes(instructions, [
    "mul(2,4)",
    "mul(5,5)",
    "mul(11,8)",
    "mul(8,5)",
  ]);
});

Deno.test(async function phase1_test_calc() {
  const corruptedStr: string = await readCorrupted("./3_test.txt");
  const instructions = extractInstructions(corruptedStr);
  const calculation = runCalculation(instructions);
  assertEquals(calculation, 161);
});

Deno.test(async function phase1_input_calc() {
  const corruptedStr: string = await readCorrupted("./3_input.txt");
  const instructions = extractInstructions(corruptedStr);
  const calculation = runCalculation(instructions);
  assertEquals(calculation, 157621318);
});
