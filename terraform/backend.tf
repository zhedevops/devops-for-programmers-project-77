terraform {
  cloud {
    organization = "zhedev"

    workspaces {
      name = "zhedev-tf"
    }
  }
}