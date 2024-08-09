import requests
from dotenv import dotenv_values

config = dotenv_values(".env")
print(config)

# Configuration
github_token = config['github_token']
user_name = 'learninguser'
HEADERS = {'Authorization': f'token {github_token}'} # {'Authorization': 'token ' + github_token}

def list_repos(user_name):
    """
    Lists all repositories for the given GitHub account with pagination.
    """
    repos = []
    url = f'https://api.github.com/users/{user_name}/repos'
    while url:
        response = requests.get(url, headers=HEADERS, params={'per_page': 100})
        if response.status_code == 200:
            repos.extend(response.json())
            # Check if there is a next page in the pagination
            if 'next' in response.links:
                url = response.links['next']['url']
            else:
                url = None
        else:
            print('Failed to fetch repositories:', response.content)
            url = None
    
    # Print the names of the repositories
    for repo in repos:
        print(repo['name'])

list_repos(user_name)
