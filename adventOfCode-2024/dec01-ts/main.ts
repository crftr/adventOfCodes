export async function readFileNumberNumber(
  fileLocation: string
): Promise<[number[], number[]]> {
  const column1: number[] = [];
  const column2: number[] = [];
  const entireFile = await Deno.readTextFile(fileLocation);
  const lines = entireFile.split("\n");
  lines.forEach((line) => {
    const numbers = line.match(/^(\d+)\s+(\d+)$/)
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

export function distance(
  list1: number[],
  list2: number[]
): number {
  let distance = 0;
  for(let idx=0; idx < list1.length; idx++) {
    distance += Math.abs(list1[idx] - list2[idx]);
  }
  return distance;
}

export function similarity(
  list1: number[],
  list2: number[]
): number {
  const isValue = (val:number) => {
    return (num:number) => num === val;
  }
  let similarity = 0;
  list1.forEach(l1Number => {
    const firstIdx = list2.findIndex(isValue(l1Number));
    if (firstIdx === -1) return;
    const secondIdx = list2.findLastIndex(isValue(l1Number));
    similarity += l1Number * (secondIdx - firstIdx + 1);
  });

  return similarity;
}

// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  const [list1, list2] = await readFileNumberNumber('./1_input.txt');

  const distanceValue = distance(list1, list2);
  console.log("Part 1", distanceValue);

  const similarityValue = similarity(list1, list2);
  console.log("Part 2", similarityValue);

}
