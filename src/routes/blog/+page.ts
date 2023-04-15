/** @@type {import('./$types').PageLoad} */
export async function load({ fetch }: { fetch: any }) {
  const res = await fetch('https://swapi.dev/api/people/1');
  return await res.json();
}