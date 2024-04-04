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


&nbsp;