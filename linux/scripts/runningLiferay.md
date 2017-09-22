# How to run Liferay 7.0.x

> Make sure Java 8 is installed

1. Clone the repo

2. run `ant -f build-dist.xml unzip-tomcat` in the repo

    * Double check that it created the bundles folder

3. run `ant all`

    * That will start your build

4. go into your bundles folder, then tomcat then bin and run `./catalina.sh run`


## Deploying plugins on 6.2.x

1. make sure your parent dir prop in your build.properties file is correct directory
2. go to your theme or plugin dir and run `ant deploy`
