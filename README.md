# terraform Provisioner

`A "**provisioner**" in Terraform is a mechanism that allows you to run scripts or commands on a local or remote machine after a resource has been created, essentially performing additional configuration tasks like installing software or setting up initial settings on a newly provisioned server; it's used when you need to do something beyond what Terraform's core resource creation capabilities can handle, but should be used sparingly as it can add complexity to your configuration. `

 
`**Key points about Terraform provisioners**`

**Functionality**
Provisioners execute custom scripts or commands on either the machine where Terraform is running ("local-exec") or on the newly created remote resource ("remote-exec"). 
**Use cases**
Installing necessary software on a server after it's been created. 
Setting up initial configurations for a service. 
Performing cleanup tasks before destroying a resource. ''


`**Important considerations:**`

Avoid over-reliance: Ideally, you should try to configure resources fully within Terraform's resource definitions whenever possible, as provisioners can make your infrastructure setup less predictable and harder to manage. 
Potential for complexity: Using provisioners can add extra steps and dependencies to your Terraform code, which can be difficult to debug and maintain. 

`**Types of Terraform provisioners**:`
"local-exec": Executes commands on the machine where Terraform is running. 
"remote-exec": Executes commands on the newly created remote resource (like a server) using SSH. 
"file": Copies files from your local machine to the remote resource.
