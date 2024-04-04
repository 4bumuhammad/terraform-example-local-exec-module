# Terraform Module

&nbsp;

&#x1F516; Information on the user's device.<br />
<pre>
    ❯ system_profiler SPSoftwareDataType SPHardwareDataType

        Software:
            System Software Overview:
                System Version: macOS 13.3.1 (22E261)
                Kernel Version: Darwin 22.4.0
                Boot Volume: Macintosh HD
                Boot Mode: Normal    
                . . .

        Hardware:
            Hardware Overview:
                Model Name: MacBook Pro
                Model Identifier: MacBookPro17,1
                Model Number: MYD82ID/A
                Chip: Apple M1
                Total Number of Cores: 8 (4 performance and 4 efficiency)
                Memory: 8 GB
                . . .
</pre>

&nbsp;

<div align="center">
    <img src="./gambar-petunjuk/ss_terraform_logo_black.png" alt="ss_terraform_logo_black" style="display: block; margin: 0 auto;">
</div> 

&nbsp;

---

&nbsp;

Project structure.
<pre>
    ❯ tree -L 3 -a -I 'README.md|.DS_Store|.git|.gitignore|gambar-petunjuk|.terraform|*.hcl|*.tfstate|*.tfstate.backup' ./
        ├── main.tf
        ├── modules
        │   ├── stage1
        │   │   └── salam_hello.tf
        │   └── stage2
        │       └── ask.tf
        ├── output.tf
        ├── provider.tf
        └── variables.tf

        3 directories, 6 files
</pre>

&nbsp;

<pre>
    ❯ vim provider.tf


            terraform {
                required_providers {
                    null = {
                        source = "hashicorp/null"
                    }
                }
            }
</pre>

&nbsp;

<pre>
    ❯ vim main.tf


            module "stage1" {
              source = "./modules/stage1"
              word_transition = local.full_salam_hello
            }
            
            module "stage2" {
              source = "./modules/stage2"
              word_transition = var.word_ask
            }
</pre>

&nbsp;

<pre>
    ❯ vim variables.tf


            variable "word_hello" {
              description = "Kalimat Hello World"
              default     =  "HELLO WORLD!"
            }
            
            locals{
              full_salam_hello = "Assalamualaikum Warahmatullah Wabarakatuh, ${var.word_hello}"
            }
            
            variable "word_ask" {
              description = "Kalimat bertanya"
              default = "Hi, apakabar?"
            }
</pre>

&nbsp;

<pre>
    ❯ vim modules/stage1/salam_hello.tf


            variable "word_transition" {
              type = string
            }
            
            resource "null_resource" "echo_word_salam_hello" {
              triggers = {
                always_run = "${timestamp()}"
              }
            
              provisioner "local-exec" {
                command = "echo '${var.word_transition}'"
              }
            }
</pre>

&nbsp;

<pre>
    ❯ vim modules/stage2/ask.tf


            variable "word_transition" {
              type = string
            }
            
            resource "null_resource" "echo_word_ask" {
                  triggers = {
                    always_run = "${timestamp()}"
                  }    
                  
                  provisioner "local-exec" {
                    command = "echo '${var.word_transition}'"
                  }
            }
</pre>

&nbsp;

<pre>
    ❯ vim output.tf


            output "hello_output" {
              value = local.full_salam_hello
            }
            
            output "ask_output" {
              value = var.word_ask
            }
</pre>

&nbsp;

&nbsp;

### &#x1F530; TERRAFORM STAGES :

<pre>
    ❯ terraform init

            Initializing the backend...
            Initializing modules...

            Initializing provider plugins...
            - Reusing previous version of hashicorp/null from the dependency lock file
            - Using previously-installed hashicorp/null v3.2.2

            Terraform has been successfully initialized!

            You may now begin working with Terraform. Try running "terraform plan" to see
            any changes that are required for your infrastructure. All Terraform commands
            should now work.

            If you ever set or change modules or backend configuration for Terraform,
            rerun this command to reinitialize your working directory. If you forget, other
            commands will detect it and remind you to do so if necessary.
</pre>

&nbsp;

<pre>
    ❯ terraform fmt

        main.tf
        output.tf
        variables.tf


    ❯ terraform fmt -recursive

        modules/stage1/salam_hello.tf
        modules/stage2/ask.tf


    ❯ terraform validate

        Success! The configuration is valid.

</pre>

&nbsp;

<pre>
    ❯ terraform plan


            module.stage1.null_resource.echo_word_salam_hello: Refreshing state... [id=7529023315021869282]
            module.stage2.null_resource.echo_word_ask: Refreshing state... [id=76872259101793597]

            Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            -/+ destroy and then create replacement

            Terraform will perform the following actions:

            # module.stage1.null_resource.echo_word_salam_hello must be replaced
            -/+ resource "null_resource" "echo_word_salam_hello" {
                ~ id       = "7529023315021869282" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run" = "2024-04-04T07:39:13Z" -> (known after apply)
                    }
                }

            # module.stage2.null_resource.echo_word_ask must be replaced
            -/+ resource "null_resource" "echo_word_ask" {
                ~ id       = "76872259101793597" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run" = "2024-04-04T07:39:13Z" -> (known after apply)
                    }
                }

            Plan: 2 to add, 0 to change, 2 to destroy.

            ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

            Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
</pre>

&nbsp;

<pre>
    ❯ terraform apply -auto-approve


            module.stage1.null_resource.echo_word_salam_hello: Refreshing state... [id=7529023315021869282]
            module.stage2.null_resource.echo_word_ask: Refreshing state... [id=76872259101793597]

            Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            -/+ destroy and then create replacement

            Terraform will perform the following actions:

            # module.stage1.null_resource.echo_word_salam_hello must be replaced
            -/+ resource "null_resource" "echo_word_salam_hello" {
                ~ id       = "7529023315021869282" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run" = "2024-04-04T07:39:13Z" -> (known after apply)
                    }
                }

            # module.stage2.null_resource.echo_word_ask must be replaced
            -/+ resource "null_resource" "echo_word_ask" {
                ~ id       = "76872259101793597" -> (known after apply)
                ~ triggers = { # forces replacement
                    ~ "always_run" = "2024-04-04T07:39:13Z" -> (known after apply)
                    }
                }

            Plan: 2 to add, 0 to change, 2 to destroy.
            module.stage2.null_resource.echo_word_ask: Destroying... [id=76872259101793597]
            module.stage1.null_resource.echo_word_salam_hello: Destroying... [id=7529023315021869282]
            module.stage2.null_resource.echo_word_ask: Destruction complete after 0s
            module.stage1.null_resource.echo_word_salam_hello: Destruction complete after 0s
            module.stage1.null_resource.echo_word_salam_hello: Creating...
            module.stage2.null_resource.echo_word_ask: Creating...
            module.stage1.null_resource.echo_word_salam_hello: Provisioning with 'local-exec'...
            module.stage2.null_resource.echo_word_ask: Provisioning with 'local-exec'...
            module.stage2.null_resource.echo_word_ask (local-exec): Executing: ["/bin/sh" "-c" "echo 'Hi, apakabar?'"]
            module.stage1.null_resource.echo_word_salam_hello (local-exec): Executing: ["/bin/sh" "-c" "echo 'Assalamualaikum Warahmatullah Wabarakatuh, HELLO WORLD!'"]
            module.stage2.null_resource.echo_word_ask (local-exec): Hi, apakabar?
            module.stage1.null_resource.echo_word_salam_hello (local-exec): Assalamualaikum Warahmatullah Wabarakatuh, HELLO WORLD!
            module.stage1.null_resource.echo_word_salam_hello: Creation complete after 0s [id=260327161307294055]
            module.stage2.null_resource.echo_word_ask: Creation complete after 0s [id=6494815015400437356]

            Apply complete! Resources: 2 added, 0 changed, 2 destroyed.

            Outputs:

            ask_output = "Hi, apakabar?"
            hello_output = "Assalamualaikum Warahmatullah Wabarakatuh, HELLO WORLD!"
</pre>

&nbsp;

<pre>
    ❯ terraform destroy -auto-approve


            module.stage2.null_resource.echo_word_ask: Refreshing state... [id=6494815015400437356]
            module.stage1.null_resource.echo_word_salam_hello: Refreshing state... [id=260327161307294055]

            Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
            - destroy

            Terraform will perform the following actions:

            # module.stage1.null_resource.echo_word_salam_hello will be destroyed
            - resource "null_resource" "echo_word_salam_hello" {
                - id       = "260327161307294055" -> null
                - triggers = {
                    - "always_run" = "2024-04-04T08:17:05Z"
                    } -> null
                }

            # module.stage2.null_resource.echo_word_ask will be destroyed
            - resource "null_resource" "echo_word_ask" {
                - id       = "6494815015400437356" -> null
                - triggers = {
                    - "always_run" = "2024-04-04T08:17:05Z"
                    } -> null
                }

            Plan: 0 to add, 0 to change, 2 to destroy.

            Changes to Outputs:
            - ask_output   = "Hi, apakabar?" -> null
            - hello_output = "Assalamualaikum Warahmatullah Wabarakatuh, HELLO WORLD!" -> null
            module.stage2.null_resource.echo_word_ask: Destroying... [id=6494815015400437356]
            module.stage1.null_resource.echo_word_salam_hello: Destroying... [id=260327161307294055]
            module.stage2.null_resource.echo_word_ask: Destruction complete after 0s
            module.stage1.null_resource.echo_word_salam_hello: Destruction complete after 0s

            Destroy complete! Resources: 2 destroyed.
</pre>

&nbsp;

&nbsp;

---

&nbsp;

<div align="center">
    <img src="./gambar-petunjuk/well_done.png" alt="well_done" style="display: block; margin: 0 auto;">
</div> 

&nbsp;

---

&nbsp;

&nbsp;
