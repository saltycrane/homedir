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
EOF

# package.json
cat << EOF > package.json
{
  "scripts": {
    "dev": "next",
    "build": "next build",
    "start": "next start",
    "tsc": "tsc"
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

# next.config.js
cat << EOF > next.config.js
const withTypescript = require("@zeit/next-typescript");
module.exports = withTypescript({});
EOF

# .babelrc
cat << EOF > .babelrc
{
  "presets": [
    "next/babel",
    "@zeit/next-typescript/babel"
  ]
}
EOF

# tsconfig.json
cat << EOF > tsconfig.json
{
  "compilerOptions": {
    "allowJs": true,
    "allowSyntheticDefaultImports": true,
    "jsx": "preserve",
    "lib": ["dom", "es2017"],
    "module": "esnext",
    "moduleResolution": "node",
    "noEmit": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "preserveConstEnums": true,
    "removeComments": false,
    "skipLibCheck": true,
    "sourceMap": true,
    "strict": true,
    "target": "esnext"
  }
}
EOF

# pages/index.tsx
cat << EOF > pages/index.tsx
import React from "react";

const Home = () => <div>Home</div>;

export default Home;
EOF

npm install next react react-dom
npm install @zeit/next-typescript
npm install @types/react
npm install --save-dev prettier
npm install --save-dev typescript
git add .
git commit -m 'create empty next.tsx project'

set +x
