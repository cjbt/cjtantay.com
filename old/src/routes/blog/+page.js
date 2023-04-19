// @ts-ignore
export async function load({ fetch }) {
  const res = await fetch('https://swapi.dev/api/people/1');
  return await res.json();
}