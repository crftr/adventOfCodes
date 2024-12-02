export async function readFileNumberNumber(
  fileLocation: string,
): Promise<[number[], number[]]> {
  const column1: number[] = [];
  const column2: number[] = [];
  const entireFile = await Deno.readTextFile(fileLocation);
  const lines = entireFile.split("\n");
  lines.forEach((line) => {
    const numbers = line.match(/^(\d+)\s+(\d+)$/);
    if (numbers?.length !== 3) {
      return;
    }
    column1.push(Number(numbers[1]));
    column2.push(Number(numbers[2]));
  });
  column1.sort();
  column2.sort();
  return [column1, column2];
}

/**
 * @throws {Error} If arrays have different lengths
 */
export function distance(
  list1: readonly number[],
  list2: readonly number[],
): number {
  if (list1.length !== list2.length) {
    throw new Error("Arrays must have equal length");
  }
  return list1.reduce((sum, val, idx) => sum + Math.abs(val - list2[idx]), 0);
}

export function similarity(
  list1: readonly number[],
  list2: readonly number[],
): number {
  return list1.reduce((total, currentNum) => {
    const firstIdx = list2.indexOf(currentNum);
    if (firstIdx === -1) return total;

    const lastIdx = list2.lastIndexOf(currentNum);
    return total + currentNum * (lastIdx - firstIdx + 1);
  }, 0);
}

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const [list1, list2] = await readFileNumberNumber("./1_input.txt");

  const distanceValue = distance(list1, list2);
  console.log("Part 1", distanceValue);

  const similarityValue = similarity(list1, list2);
  console.log("Part 2", similarityValue);
}
