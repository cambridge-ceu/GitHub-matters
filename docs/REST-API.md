## via Node.js

(Based on ChatGPT, *to be fully tested*)

### Step 1: Set Up Your Project Locally

#### Initialize a new Node.js project:

```bash
npm init -y
```

```
Wrote to /home/jhz22/package.json:

{
  "name": "jhz22",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "directories": {
    "doc": "doc"
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

#### Install Express:

```bash
npm install express
```

```
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN jhz22@1.0.0 No description
npm WARN jhz22@1.0.0 No repository field.

+ express@4.18.2
added 62 packages from 41 contributors and audited 62 packages in 2.929s

11 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

#### Create an index.js file:

```js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3030;

app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
```

### Step 2: Test Locally

```bash
node index.js
firefox http://localhost:3030
```

### Step 3: Set Up a GitHub Repository

This is handy using GitHub API.

### Step 4: Deploy to Heroku (Optional)

* Sign up from https://www.heroku.com/
* Install Heroku CLI, https://devcenter.heroku.com/articles/heroku-cli
* Login to Heroku, `heroku login`
* Prepare Your Application, having a package.json for Node.js
* Create a Procfile: `web: node index.js`
* Initialize a Git Repository, `git init;git add .;git commit -m "Initial commit"`
* Create a Heroku App, `heroku create`
* Deploy Application, 'git push heroku master'
* Open Application, `heroku open`
* Check additional information, https://devcenter.heroku.com/

## via Flask

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/hello', methods=['GET'])
def hello():
    return jsonify(message='Hello, World!')

if __name__ == '__main__':
    app.run(debug=True)
```

API documentation, <https://editor.swagger.io/>

Swagger action .github/workflows/swagger.yml,

```
name: Swagger Documentation

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Generate Swagger Documentation
      run: docker run --rm -v ${PWD}:/local swaggerapi/swagger-codegen-cli generate -i /local/docs/openapi.yml -l html2 -o /local/docs

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        deploy_key: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs
```

Action workflow,

```
name: CI/CD

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Set up Python
      uses: actions/setup-python@v3
      with:
        python-version: 3.8

    - name: Install dependencies
      run: |
        pip install -r requirements.txt

    - name: Run tests
      run: |
        pytest

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        deploy_key: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs
```
