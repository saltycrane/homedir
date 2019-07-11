#!/bin/bash -e

# Usage:
#   next.ts my-project

set -x

project_name=$1
mkdir $project_name
cd $project_name
git init
git config user.email saltycrane@gmail.com
git config user.name Eliot
mkdir pages

# README.md
cat << EOF > README.md
# $project_name

## Usage

\`\`\`
\$ npm install
\$ npm run dev
\`\`\`

Go to http://localhost:3000 in the browser
EOF

# package.json
cat << EOF > package.json
{
  "scripts": {
    "dev": "next",
    "build": "next build",
    "start": "next start"
  },
  "prettier": {
    "trailingComma": "all"
  }
}
EOF

# .gitignore
cat << EOF > .gitignore
.next
node_modules
EOF

# tsconfig.json
cat << EOF > tsconfig.json
{
  "compilerOptions": {
    "allowJs": true,
    "alwaysStrict": true,
    "esModuleInterop": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "lib": [
      "dom",
      "es2017"
    ],
    "module": "esnext",
    "moduleResolution": "node",
    "noEmit": true,
    "noFallthroughCasesInSwitch": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "strict": true,
    "target": "esnext",
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true
  },
  "exclude": [
    "node_modules"
  ],
  "include": [
    "next-env.d.ts",
    "**/*.ts",
    "**/*.tsx"
  ]
}
EOF

# next-env.d.ts
cat << EOF > next-env.d.ts
/// <reference types="next" />
/// <reference types="next/types/global" />
EOF

# pages/index.tsx
cat << EOF > pages/index.tsx
import React from "react";

const Home = () => <div>Home</div>;

export default Home;
EOF

npm install next react react-dom
npm install @types/react @types/react-dom @types/node
npm install typescript
npm install --save-dev prettier
git add .
git commit -m 'create empty next.js project'

set +x
