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
