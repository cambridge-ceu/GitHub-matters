## Flask

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

so we start[^1] with `python app.py`.

### Test

`curl -G http://127.0.0.1:5000/api/hello` showing,

```
{
  "message": "Hello, World!"
}
```

### API documentation

Web: <https://editor.swagger.io/>

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

### Python workflow

.github/workflows/python-workflow.yml,

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

    - name: Run tests
      run: |
        pytest

    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        deploy_key: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs
```

### Swagger action

.github/workflows/swagger.yml,

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

[^1]: This is achieved with

    ```bash
    module load python/3.8
    python -m venv venv
    source venv/bin/activate
    pip install Flask
    pip install requests
    ```
