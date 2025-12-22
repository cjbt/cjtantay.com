import { readFileSync, writeFileSync, existsSync } from 'fs';
import { join } from 'path';

// Try both old and new function paths
const paths = [
  join('.vercel', 'output', 'functions', '_render.func', '.vc-config.json'),
  join('.vercel', 'output', 'functions', 'render.func', '.vc-config.json'),
];

let updated = false;
for (const vcConfigPath of paths) {
  if (existsSync(vcConfigPath)) {
    const config = JSON.parse(readFileSync(vcConfigPath, 'utf-8'));
    config.runtime = 'nodejs20.x';
    writeFileSync(vcConfigPath, JSON.stringify(config, null, '\t') + '\n');
    console.log(`✅ Updated runtime to nodejs20.x in ${vcConfigPath}`);
    updated = true;
    break;
  }
}

if (!updated) {
  console.warn('⚠️  .vc-config.json not found. This is normal if build output was cleaned.');
}

