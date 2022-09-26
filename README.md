# Doodle Representation

Introduction
============

This application is based on the [DuD-Poll](https://dud-poll.inf.tu-dresden.de/) software developed by the [Dresden University of Technology](https://tu-dresden.de/ing/informatik/sya/ps). The code was modified as a way to implement a user-testable version of Doodle for Harvard's CS279R.

Installation
============

Doodle Representation uses a Docker container for distribution. Fetch Doodle Representation sources, create the Docker image and a folder for backups:
    
```console
$ cd doodle-representation
$ docker build -t my-dudle .
```

Update the `scripts/maintenance/dudle-maint.sh` file:

```bash
run() {...

${DOCKR} run -d -v {path to folder doodle-representation}/backup:/backup:Z ${TZ_PARAM} -p 8888:80 --name ${CONTAINER_NAME} my-dudle || exit 1
}
```

For example:
```bash
run() {...

${DOCKR} run -d -v /Users/ekassos/doodle-representation/backup:/backup:Z ${TZ_PARAM} -p 8888:80 --name ${CONTAINER_NAME} my-dudle || exit 1
}
```

Create and start the container:
```console
$ scripts/maintenance/dudle-maint.sh run
```

### Doodle Representation should be now running on port 8888.

Customization
============
If you want to customize the installation, add the relevant CSS and artwork files to `skin/css/` and modify `skin/conf/config.rb`:
```ruby
$conf.default_css = "css/DoodleTheme.css"
```
with your preferred default theme.

License
============
The original unmodified sourcecode of this application is available under the terms of [AGPL Version 3](http://www.fsf.org/licensing/licenses/agpl-3.0.html). The sourcecode of this application can be found [here](https://github.com/kellerben/dudle/).

Improvements
============

1. The distribution was not working right out of the box, so I fixed the docker file:
    - CentOS 8 is no longer supported, so I updated the mirrors from:

        ```dockerfile
        FROM centos:8

        RUN yum -y install httpd ruby ruby-devel git rubygems gcc make epel-release wget redhat-rpm-config
        RUN gem install gettext iconv
        RUN yum clean all
        ```
        to
                
        ```dockerfile
        FROM centos

        RUN cd /etc/yum.repos.d/
        RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
        RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
        
        RUN yum -y install httpd ruby ruby-devel git rubygems gcc make epel-release wget redhat-rpm-config
        RUN gem install gettext iconv
        RUN yum clean all
        ```
    - Fixed backup file method, where Docker did not have permission to access `/srv/dudle/backup`.

1. Language was updated throughout the application to make it more user-friendly and similar to Doodle.

1. New CSS stylesheet developed with Doodle branding.

1. Functions and HTML presentation of forms was updated to better reflect the Doodle experience and to offer more guidance to users working their way through the app.
