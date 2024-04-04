# ke module_stage2
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