# How-to: Developing a minimal 'Hello World' Java app using Vaadin

[Vaadin](https://vaadin.com/) is a framework that enables you to specify the UI of your web app in Java code. It handles the routing and generates all the HTML and CSS for you. It's great for developers who know Java but don't know (or don't have time to learn) any additional languages like (HTML and CSS).

Vaadin has a [quick start tutorial](https://vaadin.com/learn/tutorials/vaadin-quick-start) that is worth following too.

## Creating the minimal app
We have two options for creating a barebones *Hello World* app - either use Maven or Vaadin's own *Starter* web page which generates a zip file.

### Using Maven:
1. In VSCode, `F1` or `CTRL + SHIFT + P` to open the Command Palette
   1. Enter `Maven: Create Maven Project`
   2. Supply an archetype: `vaadin-archetype-application` (if you type `vaa` it should find it)
   3. Select the Vaadin version (the latest version at time of writing was `13.0.10`)
   4. Specify a *groupId*: `com.helloworld` 
   5. Specify an *artifactId*: `HelloWorldApp`
   6. For the rest of the questions you can accept the defaults and hit enter for each question
   
### Examining the output files
Maven generates the following files:

`c:\Code\HelloWorldApp\LICENSE.md
c:\Code\HelloWorldApp\pom.xml
c:\Code\HelloWorldApp\README.md
c:\Code\HelloWorldApp\src
c:\Code\HelloWorldApp\src\main
c:\Code\HelloWorldApp\src\main\java
c:\Code\HelloWorldApp\src\main\webapp
c:\Code\HelloWorldApp\src\main\java\com
c:\Code\HelloWorldApp\src\main\java\com\helloworld
c:\Code\HelloWorldApp\src\main\java\com\helloworld\MainView.java
c:\Code\HelloWorldApp\src\main\webapp\frontend
c:\Code\HelloWorldApp\src\main\webapp\icons
c:\Code\HelloWorldApp\src\main\webapp\frontend\favicon.ico
c:\Code\HelloWorldApp\src\main\webapp\frontend\styles
c:\Code\HelloWorldApp\src\main\webapp\frontend\styles\README
c:\Code\HelloWorldApp\src\main\webapp\icons\icon.png`

The two most important files (that we will be editing later are):
`MainView.java` and `pom.xml`

In Visual Studio Code, open the folder Maven created with `CTRL + O` and selecting the folder.
In VS Code's Explorer `CTRL + SHIFT + E` and navigate to `src\main\java\com\helloworld\` and click on `MainView.java`.

Here is the code:
```java
package com.helloworld;

import com.vaadin.flow.component.dependency.HtmlImport;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.server.PWA;
import com.vaadin.flow.router.Route;

/**
 * The main view contains a button and a click listener.
 */
@Route
@PWA(name = "My Application", shortName = "My Application")
public class MainView extends VerticalLayout {

    public MainView() {
        Button button = new Button("Click me",
                event -> Notification.show("Clicked!"));
        add(button);
    }
}
```

Skip past the next section if you've used Maven, but if you're not familiar with Maven and would like to use the web starter, you can do this alternatively.

### Alternate: Using [vaadin.com/start/](https://vaadin.com/start/latest)
1. Navigate to https://vaadin.com/start/latest
   1. Select the version: `Vaadin 14 (Latest LTS)` (latest as of writing)   
2. Select Plain Java Servlet
3. Specify a *Maven Group ID*: `com.helloworld` 
4. Specify a *Project Name*: `HelloWorldApp`
5. Download and unzip the files into a folder 
6. In Visual Studio Code, open the folder Maven created with `CTRL + O` and selecting the folder.
7. In VS Code's Explorer `CTRL + SHIFT + E` and navigate to `src\main\java\com\helloworld\` and click on `MainView.java`.

Here is the code:
```java
package com.helloworld;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Route;
import com.vaadin.flow.server.PWA;

/**
 * The main view contains a button and a click listener.
 */
@Route("")
@PWA(name = "Project Base for Vaadin", shortName = "Project Base")
public class MainView extends VerticalLayout {

    public MainView() {
        Button button = new Button("Click me",
                event -> Notification.show("Clicked!"));
        add(button);
    }
}
```
The code is slightly different as the versions of Vaadin used are slightly different.

### Compiling, executing and testing the app
1. Right click on the `Maven Projects` 
2. Right click on `HelloWorldApp` or `helloworldapp` and select `Install`
   1. Wait until  Maven's finished compiling and downloading everything it needs (first time takes a while)
3. Right click again and select `Custom...` and in the Command Palette, enter `jetty:run`
4. Wait until you see `[INFO] Started Jetty Server` in the output terminal
5. Open your web browser, go to `localhost:8080` and click the `Click me` button that appears, you should see a notification `Clicked!`