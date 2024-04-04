module "stage1" {
  source          = "./modules/stage1"
  word_transition = local.full_salam_hello
}

module "stage2" {
  source          = "./modules/stage2"
  word_transition = var.word_ask
}