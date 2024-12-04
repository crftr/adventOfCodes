export async function readCorrupted(
  fileLocation: string,
): Promise<string> {
  const entireFile = await Deno.readTextFile(fileLocation);
  return entireFile;
}

export function extractInstructions(corruptedStr: string): string[] {
  const mulRegex = /mul\(\d+,\d+\)/g;
  const matches = corruptedStr.match(mulRegex)?.map(String);
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
}
