# Overview
This project will detail how to apply Continous Integration (CI) and Continous Delivery (CD) for a Python Machine Learning application using Github Actions and Microsoft Azure Pipelines.

[![Python application test with Github Actions](https://github.com/mike3983/UD_Project2_AzureDevOps/actions/workflows/main.yml/badge.svg)](https://github.com/mike3983/UD_Project2_AzureDevOps/actions/workflows/main.yml)

## Project Plan

* A link to a [Trello board](https://trello.com/b/YdfJEAQc/machine-learning-app-udacity-project) for the project 
* A link to a spreadsheet that includes the [project plan](https://docs.google.com/spreadsheets/d/1bcAi7Gi0GrflvtWf9zhT2umgKhMSX3n7L9yZFwEQt5c/edit#gid=1348135932)
  
## Architectural Diagram (CI/CD workflow)
<p>
<img src="./images/852E2112-29BF-43FD-880C-91B040EBD1D7.jpeg" width="100%" />
</p>

## Instructions

In MS Azure, launch the Azure Cloud Shell:
<p>
<img src="./images/305DDF62-1677-4A6F-A96C-5E1A5D517424.jpeg" width="100%" />
</p>

Once Azure Cloud Shell is running, execute the following commands:

```
git clone https://github.com/mike3983/UD_Project2_AzureDevOps.git
cd UD_Project2_AzureDevOps
```

The output will look like this:
<p>
  <img src="./images/0C81B84E-90AD-4B9F-A63A-C0A7AB90EDE3.jpeg" width="100%" />
</p>
  
After the repository is available, create a virtual environment:

```
python3 -m venv .venv
source .venv/bin/activate
```
When the virtual environment is activated, install all requirements and execute tests and lint:

```
make all
```

Successful lint and test will yield this:
<p>
  <img src="./images/99A2611A-DE28-4F24-8535-A859B83CFAAB.jpeg" width="100%" />
</p>

Githib Actions can be configured to automatically trigger this command when new code is committed: 
<p>
  <img src="./images/5F8425F6-D082-41A0-9F39-AC32A8EC18AF.jpeg" width="100%" />
</p>

Now, the Python Flask application can be pushed to Microsoft Azure using this command:
```
az webapp up -n mlpredictorapp --runtime PYTHON:3.7
```
Verify the webapp is running in the Azure Portal:
<p>
  <img src="./images/0CF7EA4C-1DE1-4440-B226-5D2946120A76.jpeg" width="100%" />
</p>
<p>
You should be able to visit the URL Azure provides for the webapp, and see the following:
</p>
<p>
  <img src="./images/A4AAA52C-DC14-43C4-94BB-EB511EC274DC_4_5005_c.jpeg" width="100%" />
</p>

We can [configure Continuous Deployment with Azure Pipeline](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops#create-an-azure-devops-project-and-connect-to-azure)

Once pipeline is configured, any change in code can be pushed to the webapp in Azure:
<p>
  <img src="./images/2B333240-A449-427C-B960-913C7085CCD1.jpeg" width="100%" />
</p>

[Note the official documentation should be referred to and double checked as you setup CI/CD](https://docs.microsoft.com/en-us/azure/devops/pipelines/ecosystems/python-webapp?view=azure-devops).


The deployed application can be called and tested using the Azure Cloud Shell:
```
./make_predict_azure_app.sh
```

A successful API call will look like this:
<p>
  <img src="./images/1B0B4788-05F8-474B-BEC7-CBE9D7022D44_4_5005_c.jpeg" width="100%" />
</p>

The webapp can also be load tested using Locust. 
```
pip install locust
locust -P 8089
locust
```
Visit the localhost:8089 and input the webapp URL:
<p>
  <img src="./images/1D51FD25-9BDB-4DE3-927B-CA55B9EAA7F1.jpeg" width="100%" />
</p>

Performance will be displayed as follows:
<p>
  <img src="./images/6E596BD5-7D98-42EB-B7F7-E1BF9A667C63.jpeg" width="100%" />
</p>

Further information can be gathered via the logs for the webapp, which can be obtained with the following command:
```
az webapp log tail --resource-group <rg name> --name  <webapp name>
```
<p>
  <img src="./images/C951C399-002F-47E9-A7DE-42BAFED40DB3.jpeg" width="100%" />
</p>

## Enhancements

- UI design: display predictions via web interface instead of JSON object in CLI, so that users can easily see predictions 
- Pipeline improvement: the build pipeline is slow; implement contianerization for performance improvement
- ML model upgrade: refine the model so that predictions are more accurate

## Demo 

https://youtu.be/VjhSwv3xv3s

