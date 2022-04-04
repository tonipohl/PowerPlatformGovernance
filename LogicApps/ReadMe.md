# Logic Apps helper

Logic Apps provide a great way to work with data for business processes.  
Find out more at https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-overview

## Helper expressions

Avoid errors when an item is null (not existing): Use [coalesce()](https://docs.microsoft.com/en-us/azure/logic-apps/workflow-definition-language-functions-reference#coalesce)

~~~~
coalesce(items('For_each')?['admin_displayname'],'','')
~~~~

These examples return the first non-null value from the specified values, or null when all the values are null:

~~~~
coalesce(null, true, false)
returns: **true**

coalesce(null, 'hello', 'world')
returns: **"hello"**

coalesce(null, null, null)
returns: **"null"**
~~~~

## Access an item in a loop

~~~~
items('For_each')
~~~~

Add any properties with the following syntax.

~~~~
items('For_each')?['admin_displayname']
items('For_each')?['value']?['admin_displayname']
~~~~


## Sample payload

Process data from Dataverse, e.g. into an array converted to an HTML table or similar.

~~~~json
{
"name": "@{coalesce(items('For_each')?['admin_displayname'],'','')}",
"id": "@{coalesce(items('For_each')?['admin_flowid'],'','')}",
"created": "@{coalesce(items('For_each')?['createdon'],'','')}",
"environment": "@{coalesce(items('For_each')?['admin_flowenvironmentdisplayname'],'','')}",
"description": "@{coalesce(items('For_each')?['admin_flowdescription'],'','')}"
}
~~~~
