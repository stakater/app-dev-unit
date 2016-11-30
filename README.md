# app-dev-unit
Unit file for Dev environment in Stakater

The given unit file is templatized.
Running the script will replace the template variables with given values and create a file named `application.service`

Usage: 

```
./substitute-Docker-vars.sh -f <File location> -d <Docker Image> -o <Docker Options>(optional)
```

Example:
```
./substitute-Docker-vars.sh -f application.service.tmpl -d hello-world
```

## Branches: 
* #####with-consul-discovery-dns:
  
  This branch adds docker hostname variable in the unit file and `--dns` and `--dns-search` docker options needed to access DNS entries in consul. 
