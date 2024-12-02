import { assertEquals } from "@std/assert";
import { readFileNumberNumber, distance, similarity } from "./main.ts";

Deno.test(async function listDistance() {
  const [list1, list2] = await readFileNumberNumber("./1_test.txt");
  const distanceValue = distance(list1, list2);
  assertEquals(distanceValue, 11);
});

Deno.test(async function listSimilarity() {
  const [list1, list2] = await readFileNumberNumber("./1_test.txt");
  const similarityValue = similarity(list1, list2);
  assertEquals(similarityValue, 31)
})