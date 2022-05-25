# PowerPlatformGovernance

IT Governance helps to to monitor and control key information technology and processes in an organization. This repository contains presentations and helpful information to control your power platform components in your Microsoft 365 tenant. This repository is a joint project from Peter Hödl, [Martina Grom](https://twitter.com/magrom), [Toni Pohl](https://twitter.com/atwork), and [Christoph Wilfing](https://twitter.com/CWilfing) from [atwork.at](https://www.atwork-it.com/) and will be extended from time to time with additional information and tools for automating governance tasks in Microsoft 365.

## Administration of the Power Platform

- Microsoft Power Platform Admin Center: [aka.ms/ppac](https://aka.ms/ppac)
- Activate the Unified Audit Log in your tenant: [aka.ms/Security-and-Compliance](https://aka.ms/Security-and-Compliance). See more at https://docs.microsoft.com/en-us/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance. **Note:** It can take up to 30 minutes or up to 24 hours after an event occurs for the corresponding audit log record to be returned in the results of an audit log search.

## Use PowerShell for Power Apps and Power Automate

Note: Earlier, the Power Platform modules required Windows PowerShell version 5.x. This is no longer required, now PowerShell Core is supported as well. To check the version of the PowerShell version running on your machine, run the following command:

~~~powershell
$PSVersionTable.PSVersion
~~~

See more at https://docs.microsoft.com/en-us/powershell/powerapps/get-started-powerapps-checker?view=pa-ps-latest

~~~powershell
# Install the modules from the PowerShell Gallery
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Scope CurrentUser
Install-Module -Name Microsoft.PowerApps.PowerShell -AllowClobber -Scope CurrentUser
# Install-Module -Name Microsoft.PowerApps.Checker.PowerShell
# Check the latest version
Get-InstalledModule -Name Microsoft.PowerApps.Administration.PowerShell, Microsoft.PowerApps.PowerShell
~~~

**Note:** To automate, such PowerShell scripts can be executed in Microsoft Azure in an Azure Automation Account environment.

## Use PowerShell for Power BI

The Power BI modules run in Windows PowerShell and in PowerShell core (v7.x). You can install them from the PowerShell Gallery.

~~~powershell
# Install the modules from the PowerShell Gallery
Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser
# Check the latest version
Get-InstalledModule -Name MicrosoftPowerBIMgmt
~~~

**Note:** To automate, such PowerShell scripts can be executed in Microsoft Azure in an Azure Automation Account , or in an Azure Function v3 environment.

## Center of Excellence (CoE)

The CoE allows to monitor and react on activities in the Microsoft Power Platform: "The Microsoft Power Platform CoE Starter Kit is a collection of components and tools that are designed to help you get started with developing a strategy for adopting and supporting Microsoft Power Platform, with a focus on Power Apps and Power Automate." It´s a helpful tool for your governance projects.

A part of the CoE solution includes Power BI dashbards, as here.

[![link](./images/CoE-Demo-PowerBI-1.png)](./images/CoE-Demo-PowerBI-1.png "Click to enlarge")

There is a lot of information about the components included, such as a list of all apps.

[![link](./images/CoE-Demo-PowerBI-3-Apps.png)](./images/CoE-Demo-PowerBI-3-Apps.png "Click to enlarge")

...and much more. Give it a try.

- Install the  CoE starter kit: [aka.ms/coestarterkit](aka.ms/coestarterkit)
- Download the CoE starter kit: [aka.ms/coestarterkitdownload](aka.ms/coestarterkitdownload)

## Develop a Power App

- See the helpful formula help: [Formula reference for Power Apps](https://docs.microsoft.com/en-us/powerapps/maker/canvas-apps/formula-reference)
  
## Develop a custom connector

- See [Get started with Swashbuckle and ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/tutorials/getting-started-with-swashbuckle?view=aspnetcore-3.1&tabs=visual-studio)
- [Create and deploy an ASP.NET web app to Azure](https://docs.microsoft.com/en-us/connectors/custom-connectors/create-web-api-connector#create-and-deploy-an-aspnet-web-app-to-azure)
- See this blog post series from Patrick Lamber at [Describe-Your-Custom-Connector-With-An-Swagger](https://www.nubo.eu/Describe-Your-Custom-Connector-With-An-Swagger/)

## Power Virtual Agents

- Create your own chatbot with no code and start at [powerva.microsoft.com](https://powerva.microsoft.com/)

## More

- Develop your own governance processes with automation, using PowerShell or APIs
- Check out our [GovernanceToolkit365.com](https://governancetoolkit365.com/)
- Check out other tools such as the [Power Studio for the Power Platform](https://flowstudio.app/) from our MVP colleague John Liu

to be continued...
