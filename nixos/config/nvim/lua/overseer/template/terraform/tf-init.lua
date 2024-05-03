return {
  name = "Terraform init",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "init" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
