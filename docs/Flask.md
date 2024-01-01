## Flask

In the following, it assumes that `source venv/bin/activate`[^1] is called under CSD3.

### app.py

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/hello', methods=['GET'])
def hello():
    return jsonify(message='Hello, World!')

if __name__ == '__main__':
    app.run(debug=True)
```

so we start with `python app.py`.

### Test

`curl -G http://127.0.0.1:5000/api/hello` showing,

```
{
  "message": "Hello, World!"
}
```

### API documentation

Web: <https://editor.swagger.io/>

```yml
openapi: 3.0.0
info:
  title: My REST API
  version: 1.0.0
paths:
  /api/hello:
    get:
      summary: Get a greeting message
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              example: {"message": "Hello, World!"}

```

### github_api.py

```python
import requests

def get_github_user(username):
    api_url = f'https://api.github.com/users/{username}'
    
    # Make a GET request to the GitHub REST API
    response = requests.get(api_url)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the JSON response
        user_data = response.json()
        return user_data
    else:
        # Print an error message if the request was not successful
        print(f"Error: Unable to fetch data. Status code: {response.status_code}")
        return None

# Replace 'your_username' with the GitHub username you want to fetch
github_username = 'jinghuazhao'
user_data = get_github_user(github_username)

# Print the retrieved user data
if user_data:
    print(f"GitHub User Data for {github_username}:")
    print(f"Name: {user_data['name']}")
    print(f"Location: {user_data['location']}")
    print(f"Public Repositories: {user_data['public_repos']}")
    # Add more fields as needed
```

which is called with `python github_api.py`.

### Python action workflow

.github/workflows/python-workflow.yml,

```yml
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

    - name: Run tests
      run: |
        pytest

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        deploy_key: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs
```

A link can be made as `[![CI/CD](https://github.com/cambridge-ceu/GitHub-matters/workflows/CI/CD/badge.svg)](https://github.com/cambridge-ceu/GitHub-matters/actions/workflows/python-workflow.yml)`

### Swagger action workflow

.github/workflows/swagger.yml,

```yml
name: Python CI

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
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Run tests
      run: |
        python -m pytest tests/

    - name: Generate Swagger documentation
      run: |
        pip install flasgger
        python generate_swagger.py

    - name: Deploy Swagger documentation
      run: |
        # Add commands to deploy Swagger documentation to a server or platform
```

### generate_swagger.py

```python
from flask import Flask, jsonify
from flasgger import Swagger

app = Flask(__name__)
swagger = Swagger(app)

@app.route('/api/hello', methods=['GET'])
def hello():
    """
    A sample endpoint that returns a hello message.
    ---
    responses:
      200:
        description: 'Successful response'
        content:
          application/json:
            example:
              message: Hello, World!
    """
    return jsonify(message='Hello, World!')

if __name__ == '__main__':
    app.run(debug=True)
```

## Links

- Deploy Django on Render, <https://render.com/docs/deploy-django>
- Flas web app tutorial, <https://github.com/techwithtim/Flask-Web-App-Tutorial>
- flask-blog, <https://github.com/adyouri/flask_blog> (as [exposition](https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3) by [do-community](https://github.com/do-community/flask_blog))
- MobiDetails, <https://github.com/vidboda/MobiDetails> (REST API, <https://github.com/mobidic/spliceai>)

[^1]: This is achieved with
    
    ```bash
    module load python/3.8
    python -m venv venv
    source venv/bin/activate
    pip install Flask
    pip install flasgger
    pip install requests
    ```

    > Flasgger is a Python package that integrates with Flask, a popular web framework, to automatically generate Swagger documentation for your API. Swagger is a tool that helps design, build, document, and consume RESTful web services. It provides a standard way to describe RESTful APIs, making it easier for developers to understand and interact with the API.

    > Flasgger simplifies the process of documenting your API by automatically generating Swagger documentation based on your Flask application's routes, request parameters, and responses. With Flasgger, you can annotate your Flask routes with Swagger specifications using comments, and the package will take care of creating the Swagger UI for you.
