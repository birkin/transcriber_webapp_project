#!/bin/bash


## LOCALDEV settings for django `x_project`
##
## This file is loaded by `env/bin/activate` when running locally...
## ...and by `project/config/passenger_wsgi.py` on our servers.
##
## When deploying on our servers, copy this file to the appropriate place, edit it, 
## ...and point to it from activate and the apache <Location> entry.


## ============================================================================
## standard project-level settings
## ============================================================================

export TRNSCRBR_WEBAPP__SECRET_KEY="example_secret_key"

export TRNSCRBR_WEBAPP__DEBUG_JSON="true"

export TRNSCRBR_WEBAPP__ADMINS_JSON='
    [
      [
        "exampleFirst exampleLast",
        "example@domain.edu"
      ]
    ]
    '

export TRNSCRBR_WEBAPP__ALLOWED_HOSTS_JSON='["127.0.0.1", "127.0.0.1:8000", "0.0.0.0:8000", "localhost:8000"]'  # must be json

export TRNSCRBR_WEBAPP__DATABASES_JSON='
    {
      "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "HOST": "",
        "NAME": "../DB/x_project_files.sqlite3",
        "PASSWORD": "",
        "PORT": "",
        "USER": ""
      }
    }
    '

export TRNSCRBR_WEBAPP__STATIC_URL="/static/"
export TRNSCRBR_WEBAPP__STATIC_ROOT="/static/"

export TRNSCRBR_WEBAPP__EMAIL_HOST="localhost"
export TRNSCRBR_WEBAPP__EMAIL_PORT="1026"  # will be converted to int in settings.py
export TRNSCRBR_WEBAPP__SERVER_EMAIL="donotreply_x-project@domain.edu"

export TRNSCRBR_WEBAPP__LOG_PATH="../logs/x_project.log"
export TRNSCRBR_WEBAPP__LOG_LEVEL="DEBUG"

export TRNSCRBR_WEBAPP__CSRF_TRUSTED_ORIGINS_JSON='["localhost", "127.0.0.1"]'

## https://docs.djangoproject.com/en/3.2/topics/cache/
## - TIMEOUT is in seconds (0 means don't cache); CULL_FREQUENCY defaults to one-third
export TRNSCRBR_WEBAPP__CACHES_JSON='
{
  "default": {
    "BACKEND": "django.core.cache.backends.filebased.FileBasedCache",
    "LOCATION": "../cache_dir",
    "TIMEOUT": 0,
    "OPTIONS": {
        "MAX_ENTRIES": 1000
    }
  }
}
'

## ============================================================================
## app
## ============================================================================

export TRNSCRBR_WEBAPP__README_URL="https://github.com/birkin/django_template_32_project/blob/main/README.md"

## auth -------------------------------------------------------------

export TRNSCRBR_WEBAPP__SUPER_USERS_JSON='[
]'

export TRNSCRBR_WEBAPP__STAFF_USERS_JSON='
[
  "eppn@domain.edu"
]'

export TRNSCRBR_WEBAPP__STAFF_GROUPER_GROUP="the:group"

export TRNSCRBR_WEBAPP__TEST_META_DCT_JSON='{
  "Shibboleth-eppn": "eppn@brown.edu",
  "Shibboleth-brownNetId": "First_Last",
  "Shibboleth-mail": "first_last@domain.edu",
  "Shibboleth-givenName": "First",
  "Shibboleth-sn": "Last",
  "Shibboleth-isMemberOf": "aa:bb:cc;dd:ee:ff;the:group;gg:hh"
}'

export TRNSCRBR_WEBAPP__LOGIN_PROBLEM_EMAIL="x_project_problems@domain.edu"


## end --------------------------------------------------------------
