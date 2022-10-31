#!/usr/bin/env bash

locust -f locustfile.py --host https://mlpredictorapp.azurewebsites.net/
