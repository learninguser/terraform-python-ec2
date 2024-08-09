# DevOps use cases with python

1. List available repositories in our GitHub account
2. How to create a GitHub repository?
3. How to schedule a Cron Job to start and stop instances

## How to create virtual environment in python

- Create a virtual environment with name "devops": `python -m venv devops`
- To activate a virtual environment: `source ./devops/Scripts/activate`
- To install a package (for e.g. ansible): `pip install ansible`
- To uninstall a package: `pip uninstall ansible`
- To list all the packages that are present in an environment: `pip list --format=freeze`
- A package is a collection of libraries, a library is a collection of modules and a module is a collection of functions
- All the necessary packages that are required to setup an application is defined in a file called `requirements.txt`
- To install packages from the requirements.txt file, we use: `pip install -r requirements.txt`
