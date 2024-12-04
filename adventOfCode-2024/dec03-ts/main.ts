export async function readCorrupted(
  fileLocation: string,
): Promise<string> {
  const entireFile = await Deno.readTextFile(fileLocation);
  return entireFile;
}

export function extractInstructions(
  corruptedStr: string,
  disablable: boolean = false,
): string[] {
  let enabled = true;
  const mulRegex = /mul\(\d+,\d+\)|don't\(\)|do\(\)/g;
  const matches = corruptedStr.match(mulRegex)?.flatMap((m) => {
    if (m.startsWith("mul(")) {
      if (!disablable || enabled) {
        return m.toString();
      }
    } else if (m.startsWith("don't()")) {
      enabled = false;
    } else if (m.startsWith("do()")) {
      enabled = true;
    }
    return [];
  });
  return matches || [""];
}

export function runCalculation(instructions: string[]): number {
  let returnValue = 0;
  instructions.forEach((instruction) => {
    const numRegex = /\d+/g;
    const numbers = instruction.match(numRegex)?.map(Number);
    const val = numbers?.reduce((v, n) => {
      v *= n;
      return v;
    }, 1);
    returnValue += val || 0;
  });
  return returnValue;
}

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const corruptedStr = await readCorrupted("./3_input.txt");

  const instructions = extractInstructions(corruptedStr);
  const calculatedValue = runCalculation(instructions);
  console.log("Part1: ", calculatedValue);

  const instructions2 = extractInstructions(corruptedStr, true);
  const calculatedValue2 = runCalculation(instructions2);
  console.log("Part2: ", calculatedValue2);
}
