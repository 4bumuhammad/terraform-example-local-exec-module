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

