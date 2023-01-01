#### overview

Purpose: to enable easy new-project-creation from a template.

This template creates a project (with a single app) that can easily be run by [runserver](https://docs.djangoproject.com/en/3.2/ref/django-admin/#runserver), or docker, and is [passenger](https://www.phusionpassenger.com)-compatible [django](https://www.djangoproject.com) project.

---


#### checklist

(eventually pieces of this could be scripted)

- assumes python 3.x

- main
    - make 'x_project_stuff' dir and cd into it
    - git clone this repo...
        - `git clone git@github.com:birkin/django_template_32_project.git ./x_project`
            - remove the .git/ dir
        - `$ git init`, then set up in GitHub Desktop or alternate-app
        - push to GitHub
    - make sublime/vs_code project
    - update names
        - change all `transcriber_webapp_project` references to name of project
        - change all `transcriber_webapp_app` references to actual name of app
        - include in above transcriber_webapp_app directory
        - change all `TRNSCRBR_WEBAPP__` settings references to name of project-settings prefix
    - make env

            /path/to/python3 -m venv /path/to/project_x_stuff/env_x

        - source new env, and run: `pip install --upgrade pip`
    - with new env activated, pip update it from requirements.txt
        - suggested for localdev: `pip install ipython` -- it'll make experimentation lots easier

- log
    - make log dir, ensuring permissions are correct
    - touch a project_x.log file, and update 'owner/group', and update group-permissions
        - note, if setting up on a production-server, make the owner the apache user, and the group the shared-group
    - add log to system's logrotate
    - add dir to sublime project
    - Note: initial run may create an empty logfile with an incorrect owner, causing an error. If this happens, simply update the owner -- the subsequent system's logrotate will ensure the log-file's permissions remain correct.

- settings
    - make settings dir and .sh file
    - update `env/bin/activate.py` in two areas:

        - add this to the last line of the `deactivate` function...

                unset $(env | grep PREFIX__ | cut -d= -f1 | xargs)

            (this will remove any application-specific env-vars when the virtual-environment is deactivated or re-sourced)

        - add this to the end of the `activate` file...

                export PREFIX__SETTINGS_PATH="/path/to/project_env_settings.sh"
                source $PREFIX__SETTINGS_PATH

            (this sets an env-var needed by `passenger_wsgi.py`)

        - notes...
            - substitute the app-specific env-var prefix for `PREFIX__` above
            - be sure the exported-path env-var matches the environmental-variable accessed by the `ENV_SETTINGS_FILE` entry in `config/passenger_wsgi.py`

    - add dir to sublime project
    - add needed items along the way; eg, in django:
        - one way to see what needs set: source the environment and run `python ./manage.py check`
        - new secret-key ([helpful code](https://gist.github.com/birkin/0f6245dd7eeb24c0f5ad))
        - db if needed
        - project's django_media directory
            - hitting the [runserver admin link](http://127.0.0.1:8000/admin/) is a good way to check the django_media directory and db

- update
    - add git-pull script (w/set-permissions) & run it
    - once this works, source the env and try a `python ./manage.py check`

- other
    - webapp
        - create db if necessary
            - django:
                - run `python ./manage.py makemigrations --empty name_of_app` to initialize stuff
                - run `python ./manage.py makemigrations --dry-run` to see what will be done with the real command
                - run `python ./manage.py makemigrations`
                - run `python ./manage.py migrate` to actually create tables
                    - if expected tables aren't created, may need to run `python ./manage.py migrate --run-syncdb`
                - run `python ./manage.py createsuperuser` for the admin user prompt
        - django:
            - test with `python ./manage.py check` and then...
            - `python ./manage.py runserver host:port`, and hit host/port with browser or `curl`
            - add session-clearance crontab entry in format:

                    random_minute 01 * * * cd /path/to/project_stuff/project/; source ../env_prj/bin/activate > /dev/null; ../env_prj/bin/python ./manage.py clearsessions

        - https-ify project & shib-ify admin & login urls
        - setup apache handoff to python
        - restart apache if web-app
    - [site-checker](http://library.brown.edu/services/site_checker/status/) entry
    - cron work if necessary (besides possible django session work listed above)
        - update crontab via (one-line):

                cd /to/main/dir; source ../env/bin/activate; ../env/bin/python ./the_script.py

---

---
