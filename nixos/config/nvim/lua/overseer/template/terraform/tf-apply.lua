return {
  name = "Terraform apply",
  builder = function()
    return {
      cmd = { "terraform" },
      args = { "apply" },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "terraform" },
  },
}
